From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4]  Documentation: expand 'git diff' SEE ALSO section
Date: Mon, 11 Oct 2010 11:05:32 -0500
Message-ID: <20101011160532.GD25842@burratino>
References: <20101011150342.292ad725@chalon.bertin.fr>
 <AANLkTinqPiGf1nbo0oOvDD5edgLBdO8xZfjGeFC4q0MU@mail.gmail.com>
 <20101011161721.35940919@chalon.bertin.fr>
 <20101011160224.GA25842@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>, git@vger.kernel.org
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Mon Oct 11 18:08:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5Kvo-0004uK-Dl
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 18:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab0JKQIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 12:08:51 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54110 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959Ab0JKQIu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 12:08:50 -0400
Received: by qwf7 with SMTP id 7so1899932qwf.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=edY0LlCA48Np7YG6jTYh7RXsJmcb44mf5BT+YnUtEBk=;
        b=P3hUNd2VYgIFp/cnUSn0IvD5d6oGaf5ept93R1oY3mW03oIQ21azSgNFQh18akQmE4
         dtLRcW+/JXE2prDQTOZRaBArcsvIbTgCL8TBZss7AYdlYgIfcp23BKSmXgQ59cyBroR4
         uNt9qOm1Qkdzt+kKiFcYLBqgfVPrpaILla2vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Xgwl7VLeZ4phCdZ3igR+EWxqiofcdtuEN2hLYoPoL9w2R2uJgHTrrturHKKD61t2ND
         rYawRiUnC696Exgn+vCUn2QDwRzL0atp8wBJMHbyxvPUt79BiAO5p1Y9xwo3ceefA9bR
         nyi2uv1FEOW0ulCMYAmOuarqrDh7nJO1XiXU8=
Received: by 10.224.137.130 with SMTP id w2mr4694031qat.112.1286813328011;
        Mon, 11 Oct 2010 09:08:48 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id m7sm2522713qck.25.2010.10.11.09.08.46
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 09:08:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011160224.GA25842@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158773>

Point in many directions in the hope of helping the reader find what
is needed more quickly.

This commit also removes the summary attached to the SEE ALSO entry
for difftool, to avoid making the SEE ALSO list too verbose.  If the
reader wants a summary of the commands referred to, she can always
look to the top of the named pages or to the table of contents on the
main git(1) page.

Suggested-by: Goswin von Brederlow <goswin-v-b@web.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-diff.txt |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index db2c6c2..fe34d4e 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -160,8 +160,12 @@ rewrites (very expensive).
 
 SEE ALSO
 --------
-linkgit:git-difftool[1]::
-	Show changes using common diff tools
+diff(1),
+linkgit:git-difftool[1],
+linkgit:git-log[1],
+linkgit:gitdiffcore[7],
+linkgit:git-format-patch[1],
+linkgit:git-apply[1]
 
 Author
 ------
-- 
1.7.2.3
