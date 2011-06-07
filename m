From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: [PATCH] Remarks that tags need to be pushed explicitly
Date: Tue, 7 Jun 2011 17:33:23 +0200
Message-ID: <20110607153323.GA71116@sherwood.local>
References: <7vk4cx7mst.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 17:33:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTyHk-0001qx-9z
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 17:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755765Ab1FGPdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 11:33:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44112 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755705Ab1FGPdb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 11:33:31 -0400
Received: by bwz15 with SMTP id 15so4279666bwz.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GtpWWu4xqhvxV9BE6Q50E7/iJ1saYGoUXNPlMqD+zMo=;
        b=suhqRo2QuYEwItwtc6a+AY0814Myo0E4sLyBnaTSzKEaSCPfVH3z4+NnZYzC0+/2Ld
         CbxV9m3hxD5U4OJr3IVgx1jEqT05h9MJ4lViO3ggG3u9flhepym+HyoN4fndWTa88Qp1
         L03AhnF944+hk75QIoFB0THXXlL4tZMoJHjEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        b=yEqMaBO9av64tC/Wiwo46ZbGZ5Dm0UX6iY5ZG5w+AOergRVx3XPqURoYeXGMeShY+6
         37uGFH0aupenEw9FYZDJw2fpIscR8Vk8t7ORutr37wtOMLpumHV9SBBY5dDgiMQaYkm+
         29wzC8eHpmLy49yUv/jJTGYeyU1KqbyIbLinA=
Received: by 10.204.12.84 with SMTP id w20mr649107bkw.49.1307460810409;
        Tue, 07 Jun 2011 08:33:30 -0700 (PDT)
Received: from sherwood.local ([89.204.137.216])
        by mx.google.com with ESMTPS id ek1sm4284812bkb.9.2011.06.07.08.33.27
        (version=SSLv3 cipher=OTHER);
        Tue, 07 Jun 2011 08:33:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk4cx7mst.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175210>

@ Junio C Hamano <gitster@pobox.com> wrote (2011-06-07 16:12+0200):
> > diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
> This feels way out of place in the context of the story the tutorial is
> telling.

No door gap at all for this in *tut* and user-manual!

> How about adding an example in git-push section instead?

I'll pack this in verbatim.  :).
You'll notice that the patch also adds the word "Utilize" in front
of `tag <tag>` in the OPTIONS section.  I did not even now that
the term "tag" can be used, but i'm afraid that i thought of that
as a spelling error - on my terminal all these `terms` are not
highlighted in any special way.  'Would thus be good?
__
Ciao, Steffen
sdaoden(*)(gmail.com)
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments


Signed-off-by: Steffen Daode Nurpmeso <sdaoden@gmail.com>
---
 Documentation/git-push.txt |    7 ++++++-
 Documentation/git-tag.txt  |    3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 88acfcd..898348a 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -55,7 +55,7 @@ you can tell git to update the <dst> ref even when the update is not a
 fast-forward.  This does *not* attempt to merge <src> into <dst>.  See
 EXAMPLES below for details.
 +
-`tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
+Utilize `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 +
 Pushing an empty <src> allows you to delete the <dst> ref from
 the remote repository.
@@ -371,6 +371,11 @@ git push origin HEAD:master::
 	`origin` repository. This form is convenient to push the current
 	branch without thinking about its local name.
 
+git push origin tag v1.5::
+       Push the `v1.5` tag to the `origin` repository. A newly created
+       tag needs to be published explicitly like this, just like a newly
+       created branch does not get published automatically.
+
 git push origin master:refs/heads/experimental::
 	Create the branch `experimental` in the `origin` repository
 	by copying the current `master` branch.  This form is only
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index d82f621..242837f 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -27,7 +27,8 @@ Unless `-f` is given, the tag to be created must not yet exist in the
 If one of `-a`, `-s`, or `-u <key-id>` is passed, the command
 creates a 'tag' object, and requires a tag message.  Unless
 `-m <msg>` or `-F <file>` is given, an editor is started for the user to type
-in the tag message.
+in the tag message.  Tag objects can be pushed upstream with
+linkgit:git-push[1].
 
 If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <key-id>`
 are absent, `-a` is implied.
-- 
1.7.6.rc0
