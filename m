From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/8] Update the CodingGuidelines
Date: Wed, 30 Apr 2014 14:45:04 -0700
Message-ID: <1398894312-30763-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 23:45:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfcJf-0004Xt-Cf
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 23:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758944AbaD3VpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 17:45:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54284 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752219AbaD3VpS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 17:45:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B075825CF;
	Wed, 30 Apr 2014 17:45:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=ql2ZWW3CJapgCp13AoDiumkKvmE
	=; b=qJRwmVz6r6Iql6H3oqfomNQDaWFiEqwB5Bsr/TkmBkiapgZjQ62159orHz8
	FrJ6PFj+pbTjQYAd28fFaCwPzCyAZl7pqUjfTdWM2pTquqVSqJDHSnmbOji9DAJj
	95t5Y3s06Pu4DkKnGa7zUJ5gT2z5e+wj9lHOm0DdqqwutYgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=PHp7MaVY3L/c7I842jUqDw+jKfLy2
	2q7FFkF/fTSXT1OFP0XQZbKloQPv7Kv7PKjyeoniWb9FdMPc0SMHB1zlbhr/xsd9
	EJ6SHhFtvPQk90LAfvom8wAlnNNGZovTT1V3akz4AP7u7FbzIqIfpmpVsxS2coXr
	eTx087E5LKSyqU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F782825CE;
	Wed, 30 Apr 2014 17:45:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F001F825CC;
	Wed, 30 Apr 2014 17:45:14 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-rc1-355-gd6d6511
X-Pobox-Relay-ID: B6BEDCB0-D0B0-11E3-87ED-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247784>

After seeing a large torrent of patches from Elia, I was re-reading
the CodingGuidelines to see if our preference of $( ... ) over `...`
was properly described, and then I spotted a typo and also lack of
examples on a few points that I recall pointing out during recent
reviews, which grew to this series.

Junio C Hamano (8):
  CodingGuidelines: typofix
  CodingGuidelines: give an example for case/esac statement
  CodingGuidelines: give an example for redirection
  CodingGuidelines: give an example for control statements
  CodingGuidelines: give an example for shell function preamble
  CodingGuidelines: call the conditional statement "if ()", not "if()"
  CodingGuidelines: on comparison
  CodingGuidelines: once it is in, it is not worth the code churn

 Documentation/CodingGuidelines | 81 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 6 deletions(-)

-- 
2.0.0-rc1-355-gd6d6511
