From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] Documentation updates for 'git fetch'
Date: Thu, 29 May 2014 15:42:25 -0700
Message-ID: <1401403350-7122-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 00:42:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq921-0003O0-IP
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 00:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbaE2Wmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 18:42:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54852 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753210AbaE2Wmg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 18:42:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 00BA01C317;
	Thu, 29 May 2014 18:42:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=0F9R143ID3gemOZHLAD6yD9IP9Q
	=; b=lwd5QWSGJSUa55de/uGyoM8Q5v8bbvxaXlp5MxOkBIKAd6iQBHHA/l8h6Ad
	AnHsrhEoBEz9vayUqO6vKXBm0kAiguK4xnudna5E/Wf2bWGl3r7sXnnnu+DR3TIf
	ICEJ98ODL6A5nH+6fh6xika/K53dq2+aV/4rnJK89czXMG/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=vLsGsJeYfn2+M9cSRoIfc1hO3MDJM
	ioKrvOcUyZZg5eqaCvgk/pcFpChp3oFELCpSGlYEMMyHGU7AyO11JuG2pmdvhuk9
	/PMP8eHP6UQ5sBrW7lLVLe4z2DJrNLllqpg5OXJZSUPhJcCtTV5dlhknpL4K92Aq
	2FLoNzaumDa3Ng=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E9CAF1C316;
	Thu, 29 May 2014 18:42:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7EF341C315;
	Thu, 29 May 2014 18:42:32 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-479-g59ac8f9
X-Pobox-Relay-ID: 85A648AA-E782-11E3-9BA5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250411>

Noticed that this page has antiquated description, which may still
be correct, that can use some modernization.

There are a few more larger updates coming, but these are small
enough to be reviewed separately and quickly, so I am sending them
out early.

Junio C Hamano (5):
  fetch doc: update introductory part for clarity
  fetch doc: update note on '+' in front of the refspec
  fetch doc: remove notes on outdated "mixed layout"
  fetch doc: on pulling multiple refspecs
  fetch doc: update refspec format description

 Documentation/git-fetch.txt        | 29 ++++++++++++++-----------
 Documentation/pull-fetch-param.txt | 44 ++++++++++++++++----------------------
 2 files changed, 34 insertions(+), 39 deletions(-)

-- 
2.0.0-479-g59ac8f9
