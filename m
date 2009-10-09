From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/9] Documentation: clarify "working tree" definition
Date: Fri, 9 Oct 2009 05:20:19 -0500
Message-ID: <20091009102019.GH16558@progeny.tock>
References: <20091009101400.GA16549@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:14:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwCUw-0002is-Ni
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760630AbZJIKMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 06:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760617AbZJIKMo
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:12:44 -0400
Received: from mail-qy0-f172.google.com ([209.85.221.172]:52942 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760616AbZJIKMn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 06:12:43 -0400
Received: by qyk2 with SMTP id 2so6376593qyk.21
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 03:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wlNi+urv++gg66Z/ebdN0mCw8O7MmOgBwCOB5o0YJOo=;
        b=cC705gc63mk7Hu6oDeWxGBf25quhm2V2vwNdf35fkiZ6vLWqm/C3aQTqrl3T0e9w8V
         l4/IeYyKm8CIvYFZ/8iBi9c4hdnKYFiKh2qleLKzhEnl+62ZL5upoiscnmaTgis8A6SK
         H9HGh9eX1u52GEbaNYsInHnifhPXCb/ZqFjJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nUmauKyXDKGiTuRBEM4vkJAYQBTc1J1DcggjnoKc+pXIp1sp5qh/3p48ovq/DfzSLE
         7deVxDrRSkId6Rui14cvpu7gnhdLAcKm8kvtXtd0XQtYALCQCaJRIQxQ3H2NxpAFETGq
         DAUbG1SXJebC8xlq2vTmR68sm1LafcIqDCj5A=
Received: by 10.224.95.200 with SMTP id e8mr2340090qan.157.1255083127082;
        Fri, 09 Oct 2009 03:12:07 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm4051yxe.6.2009.10.09.03.12.06
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 03:12:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091009101400.GA16549@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129763>

It is not necessarily obvious to a git novice what it means for a
filesystem tree to be equal to the HEAD.  Spell it out.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/glossary-content.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 572374f..43d84d1 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -456,6 +456,6 @@ This commit is referred to as a "merge commit", or sometimes just a
 	of 'A' is 'origin/B' sometimes we say "'A' is tracking 'origin/B'".
 
 [[def_working_tree]]working tree::
-	The tree of actual checked out files.  The working tree is
-	normally equal to the <<def_HEAD,HEAD>> plus any local changes
-	that you have made but not yet committed.
+	The tree of actual checked out files.  The working tree normally
+	contains the contents of the <<def_HEAD,HEAD>> commit's tree,
+	plus any local changes that you have made but not yet committed.
-- 
1.6.5.rc1.199.g596ec
