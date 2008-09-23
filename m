From: "rae l" <crquan@gmail.com>
Subject: Re: please consider remove those tags named master, which is ambigous with master branch
Date: Tue, 23 Sep 2008 22:46:08 +0800
Message-ID: <91b13c310809230746o1c2cb694taebc814bea57c8c5@mail.gmail.com>
References: <91b13c310808310948r5e9e825as27bcdf381137e179@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Andrew Morton" <akpm@linux-foundation.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: "Matthias Urlichs" <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Tue Sep 23 16:47:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki9Ah-0004pR-V8
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 16:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbYIWOqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 10:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbYIWOqN
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 10:46:13 -0400
Received: from gv-out-0910.google.com ([216.239.58.184]:61641 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753614AbYIWOqK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 10:46:10 -0400
Received: by gv-out-0910.google.com with SMTP id e6so129956gvc.37
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 07:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=exq1WbW1SbX47dgze/yL4xsojF8gJYID91Rz7V4BAOk=;
        b=gE0DF3gg1gpzty2yvpPZj/XJjmJZWTsYa9rEk3xNvUQXwcESV8kphGzdpGNRe4Qiv3
         f426D8z+H6qHUWLxvKGxETPDJ0nGU66IotxZOT2btZvXikKqaXOr+Yu5lyeqIIVUogvh
         ZsVmfv19Y8q5x2fBmVzqzZcTYPLYGEgCEv22Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aFuZQnvwc/0YI1SVURIm9A7HIKT6SLA5CQVjJObp2S7AcbMB1am2X+qz9I05XBC8AU
         m848eAGYymcc9dPDFuFePB97VhcDZ02x5qzH4OYms3wDr0g9jnpfr5Vl+eVdOpx5zhSY
         5ISZ7L8eaPQX08sZBbbhG25BulVEYs0M2+R5c=
Received: by 10.103.243.7 with SMTP id v7mr3774767mur.24.1222181168140;
        Tue, 23 Sep 2008 07:46:08 -0700 (PDT)
Received: by 10.103.191.7 with HTTP; Tue, 23 Sep 2008 07:46:08 -0700 (PDT)
In-Reply-To: <91b13c310808310948r5e9e825as27bcdf381137e179@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96572>

To Smurf and Andrew:
  Did you notice that there's a tag named "master" in the smurf
mm-trees.git repo,
this would confuse the git and the users, please consider remove the
"master" tag, OK?

---------- Forwarded message ----------
From: rae l <crquan@gmail.com>
Date: Mon, Sep 1, 2008 at 12:48 AM
Subject: please consider remove those tags named master, which is
ambigous with master branch
To: Matthias Urlichs <smurf@smurf.noris.de>

please consider remove those tags named master, which is ambigous with
master branch

http://git.kernel.org/?p=linux/kernel/git/smurf/linux-trees.git;a=tags

--

To Git developers:
  I found that different git subcommand have inconsitent processing
about ambiguous refname,

git show will take "master" tag first,
while git tag -v will take "master" branch first,

So what's your suggestion to fix this? Just simple remove ambiguous refnames?

Or we can add a feature to allow same refname in different namespaces
(tags and branches)?
Such as "-b" to refer a branch while "-t" to refer a tag name? Else
how to distinguish them?

gektop@tux ~/sforge/linux-2.6 0 $ PAGER= git show master
warning: refname 'master' is ambiguous.
commit 05230bd16821e2ec80321d72e97e7a2b1a07c6f2
Author:     Adrian Bunk <bunk@stusta.de>
AuthorDate: Sat Jul 30 00:45:08 2005 +0000
Commit:     Matthias Urlichs <smurf@hera.kernel.org>
CommitDate: Mon Aug 1 05:16:36 2005 -0700

    sound-oss-sequencer_syms-unexport-reprogram_timer

    This patch remoes an unneeded EXPORT_SYMBOL.

    Signed-off-by: Andrew Morton <akpm@osdl.org>

diff --git a/sound/oss/sequencer_syms.c b/sound/oss/sequencer_syms.c
index 45edfd7..5d00879 100644
--- a/sound/oss/sequencer_syms.c
+++ b/sound/oss/sequencer_syms.c
@@ -19,7 +19,6 @@ EXPORT_SYMBOL(sequencer_timer);
 EXPORT_SYMBOL(sound_timer_init);
 EXPORT_SYMBOL(sound_timer_interrupt);
 EXPORT_SYMBOL(sound_timer_syncinterval);
-EXPORT_SYMBOL(reprogram_timer);

 /* Tuning */

gektop@tux ~/sforge/linux-2.6 0 $ git tag -v master
error: 05230bd16821e2ec80321d72e97e7a2b1a07c6f2: cannot verify a
non-tag object of type commit.
error: could not verify the tag 'master'


--
Denis Cheng Renquan
