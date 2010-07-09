From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH 1/2] checkout: accord documentation to what git does
Date: Fri,  9 Jul 2010 22:27:48 +0200
Message-ID: <33e9dcc468b1e1ed18a180046f5d4c135921c7ab.1278707023.git.nicolas.s.dev@gmx.fr>
References: <7vd3uystsh.fsf@alter.siamese.dyndns.org>
Cc: <git@vger.kernel.org>, Wincent Colaiuta <win@wincent.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 22:28:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXKBp-0003DM-QY
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 22:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783Ab0GIU2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 16:28:40 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37645 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598Ab0GIU2b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 16:28:31 -0400
Received: by wwb24 with SMTP id 24so5303544wwb.1
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 13:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=wDAkBoYqwfHWeARA8VgX4aJgMV8lwcJmHHaDZQHsqUk=;
        b=nJH7bYQBy0K2baNL8x79Qnae5pCDJD42m2HDoywngLX7Tt2ME3wXtjsSv54Dj7kOCm
         e8baQ/dzuvI8oU26nN1vquBu01hDLb1tCYbh7GDTo3mf2a8xq1u4ruCt4snrgjOoGuBH
         vRf4ENjrhr+Gd9oeuDDTZB60XPTJgNclc7b6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=AS73GvxR9y6OZPO7ZaYIuA/YmBk+CNDKAcDcOUaSsf143krzaWC0+5hRh3bVK9ZErL
         xAjspZK/bmC05WAjVX07469+6MvcVgoz77sI641He0T7c7JDXsN5xtLZW6sQCdVA3TMw
         YhZoBSRTchf4F8dzZnM2KziTfrqyyirPF+5M4=
Received: by 10.227.154.9 with SMTP id m9mr1257569wbw.123.1278707304081;
        Fri, 09 Jul 2010 13:28:24 -0700 (PDT)
Received: from localhost (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id g37sm8969857wbg.15.2010.07.09.13.28.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 13:28:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2.194.g494e9.dirty
In-Reply-To: <7vd3uystsh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150687>

Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---

The 07/07/10, Junio C Hamano wrote:

> Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:
> > Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
> > ---
> >
> > The 07/07/10, Junio C Hamano wrote:
> >
> >> The "struct unpack_trees_error_msgs" mechanism was introduced so that we
> >> can change the Porcelain level messages without breaking the plumbing API,
> >> which these messages are part of.  Please see 8ccba00 (unpack-trees: allow
> >> Porcelain to give different error messages, 2008-05-17) and fadd069
> >> (merge-recursive: give less scary messages when merge did not start,
> >> 2009-09-07) for backstory.
> >
> > Oh, thanks. I was unaware of this mechanism and didn't care about what I was
> > touching.
> 
> I suspect that the documentation patch talks about a nonexistent reality.
> See 8ccba00 again ;-)

Doh! You said in this commit that

	"If you do not see something wrong with this output, your brain has already
	been rotten with use of git for too long a time."

but I claim the right to be rotten in much more ways. :-)

 Documentation/git-checkout.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 261dd90..1bacd2e 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -263,7 +263,7 @@ the above checkout would fail like this:
 +
 ------------
 $ git checkout mytopic
-fatal: Entry 'frotz' not uptodate. Cannot merge.
+error: You have local changes to 'frotz'; not switching branches.
 ------------
 +
 You can give the `-m` flag to the command, which would try a
-- 
1.7.2.rc2.194.g494e9.dirty
