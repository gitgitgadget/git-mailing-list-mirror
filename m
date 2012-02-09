From: Tom Grennan <tmgrennan@gmail.com>
Subject: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Thu,  9 Feb 2012 11:43:35 -0800
Message-ID: <1328816616-18124-1-git-send-email-tmgrennan@gmail.com>
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 20:43:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvZuN-0006Ep-Ii
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 20:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758093Ab2BITnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 14:43:50 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40787 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479Ab2BITnt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 14:43:49 -0500
Received: by qcqw6 with SMTP id w6so1212717qcq.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 11:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=hOv6HdEFjUVKOCoDw1fEOZZ0GxrmsOOpMKorTrBnDLA=;
        b=SzD6PPqOOeRZcbOanDQZLk5rgzXFC4TcGe/Zn+sxqh5orIHaShEXVBozXwTU2t44lE
         HGWCU3/zeuErqbQ7Yg77+Yl4KvSV4tXLKyKtianeab6/jM7jC+WxPwhe8KY5Znaowacy
         Vird8cphAOF1gBumGN8CH6p+cerKuG4nv//Tw=
Received: by 10.229.75.216 with SMTP id z24mr2041118qcj.50.1328816628681;
        Thu, 09 Feb 2012 11:43:48 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id c2sm7648970qao.15.2012.02.09.11.43.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 11:43:48 -0800 (PST)
X-Mailer: git-send-email 1.7.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190312>

Please see the following patch which filters the tag list of "!" prefaced
patterns.  If this is deemed desirable and correct, I'll resubmit with updated
documentation and unit tests.

Thanks,
Tom Grennan (1):
  tag: make list exclude !<pattern>

 builtin/tag.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

-- 
1.7.8
