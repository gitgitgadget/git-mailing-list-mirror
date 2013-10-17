From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 00/14] Officially start moving to the term 'staging
 area'
Date: Thu, 17 Oct 2013 16:50:10 -0500
Message-ID: <52605b927fb30_448145fe747c@nysa.notmuch>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
 <1381789769-9893-4-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s3u_SMyZOe5jxkvoGn5MBJ_g70iHRT5v_3u1rZwFoqiVA@mail.gmail.com>
 <xmqqwqlbznfp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 00:35:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWwA9-0008JP-6a
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 00:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759330Ab3JQWfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 18:35:19 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:57189 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653Ab3JQWfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 18:35:16 -0400
Received: by mail-oa0-f49.google.com with SMTP id j10so2225774oah.36
        for <git@vger.kernel.org>; Thu, 17 Oct 2013 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=ax4NYATBv+J0mfplByOWbD8FLdcIgVYM/xP8XqivqDQ=;
        b=syR7pPU7S3q/bSdJ+UJm+ldj4UcK04Ryckuh5w2+NQdBncDjPbsik9AngOu27QRojG
         zVmgvVJMTRcWZbaWFnkH56B9zx2pH9H553lnVjF1ytusb2K4mrY0py6oGD/BE4ocBnA/
         3XXfVSt3iTtlDdbeJ/u1EQCdSm4awEywneACOQKS3SXaiyOztGbuS5eO+zGLZgXsILil
         sA06sS1FpAjZ91r8g7UrbQlspNYSXbpJHuUjKBB3yr/qs8v5eG1xFZv/1BaliGYOLSt0
         Vc++HSv+nkFVVR9Evg+LDzOsImmkwab5zA7vjeTrAT4A+vw8s6NB8p9+d2Pi4Ul1awSy
         8SMQ==
X-Received: by 10.182.104.130 with SMTP id ge2mr17447604obb.6.1382049316056;
        Thu, 17 Oct 2013 15:35:16 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xr8sm79392209obc.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Oct 2013 15:35:15 -0700 (PDT)
In-Reply-To: <xmqqwqlbznfp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236329>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio, can you make an exception and reply to this thread? The change
> > to move away from the term "the index" has been suggested many times
> > since many years ago, it is an extremely important change to users,
> > and all the Git developers agree it must be done.
> 
> "It must be done" is different from "any change is good, as long as
> it introduces more instances of word 'stage'". As we established, we
> do not seem to be able to do a sensible design discussion with you
> without wasting time for nothing, I won't directly comment on that
> patch series, at least for now.
> 
> However, since you asked, I would share a couple of comments
> regarding the index, cache and staging area.
> 
> (1) "Staging area".
> 
> The phrase "staging area" is not an everyday phrase or common CS
> lingo, and that unfortunately makes it a suboptimal choice of words
> especially to those of us, to whom a large portion of their exposure
> to the English language is through the command words we use when we
> talk to our computers.

That's because Git is the only command tool that has such a concept.

> I personally do not mind explaining the index is "like a staging
> area, where an army piles up ammunition to a temporary dump before
> starting a major campaign." to native speakers, though ;-).

If you agree that explaining to users "the index is like a staging area", then
why just not call it the staging area?

Moreover, a staging area is not just a temporary dump, it is used in
preparation for something specific, and you might need to remove certain
weapons in place of better ones suited for the mission, that's why the word
"staging" is used.

> The index can also be thought of "like the buffer cache, where new
> contents of files are kept before they are committed to disk
> platter."

A buffer and a cache are two very different things used for two very different
purposes, and the term cache doesn't apply to "the index".

> At least, non-native speaker with CS background would understand that, much
> better than "the index" (no, I am not saying that we should call it "the
> cache"; I am just saying "the index" is not a good word, but we may need to
> find a better word than "the staging area").

All right, so that's progress; you do accept "the index" is not a good term.
Now, if you don't think "staging area" is a good term, do you have any that is
better?

This has been discussed for several years, and nobody has come up with a better
term, in fact, the vast majority of people prefer the term "staging area", and
it is already used in online documentation, including the ProGit book. It seems
inside and outside the Git project, the term has already been chosen.

Do you honestly think somebody is just suddenly going to come up with a better
term? How long do we have to wait before we decide X is the best term we could
come up with? One year? Two years? Ten years? Or do you just want to wait until
we have the "perfect" term, which might be never.

> The noun phrase "staging area" and the verb "to stage" are good
> (especially when we do not worry too much about us foreigners), but
> we need to make sure "stage" is not mistaken as a noun when used in
> a context that talks about the index as a whole, to avoid confusion
> with the use of the word "stage" long established since
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/231/focus=286
> 
> to call "ours" stage#2, etc.

Lets assume that "staging area" is not the best option, even though after
years of discussion nobody has come up with a better one. How would a different
term solve the problem you state above? If we use the term "commit draft", we
still could have people saying "draft # 2". So is there any term that would
avoid this problem, and is it really important to worry about such a marginal
problem?

Regardless of the term used, we can make sure it's not used in that context, so
I don't understand how that argument goes against "staging area". We can make
sure "staging area" is not used to denote the different "index" files.

Is this the *only* argument you have against the term "staging area"?

> (2) "cached" vs "index".
> 
> I think this is the more major issue between the two issues (the
> other one being "why do we force people to say 'index'?").  Some
> commands take "--cached", some others take "--index", some take
> both.  What these two mean are documented in gitcli manual page, but
> that is far from sufficient.  The users can get confused by this UI
> mistake in different ways.
> 
>  * We do need to have "git apply" that mimics "patch" (i.e. works
>    only to a working tree files, or even outside Git repository)
>    without any option, "git apply --mode1" that only applies the
>    change to the index, and "git apply --mode2" that applies the
>    change to both the index and the working tree. No renaming of
>    "the index" does not change this need to have three different
>    mode of operation.
> 
>    It was a major UI mistake to call one of the modes "--cached" and
>    another "--index", because there is no way, other than rote
>    learning, for people to choose the one between the two depending
>    that is right for the situation they face.
> 
>    If "--cached" were called "--index-only", it might have been a
>    lot more learnable (and then "--index" could be renamed to
>    "--index-and-working-tree" at the same time to reduce the
>    confusion further).  Alternatively, with the synonym "--staged"
>    for "--cached" already in place for "git diff", we could
>    introduce "--staged-and-working-tree" as a synonym for "--index"
>    to achieve the same effect (of course we need to find a way to
>    shorten "-and-working-tree" part in a sensible way).

Or we can do what I already did to solve the problem:

  git apply --stage --working-tree

>  * "git grep" barfs when given "--index", even though it does accept
>    "--cached" and searches the patterns in contents that are in the
>    index. This is technically correct, as the command does not
>    search both in the index and in the working tree, but again,
>    there is no way other than rote learning for users to tell that
>    "--cached" is the correct one to use, even after they know that
>    they want to search in the index (I already called it a major UI
>    mistake, didn't I?).
> 
>    A new synonym "--staged" for "--cached" may be able to alleviate
>    the confusion somewhat, given especially that "git diff" already
>    knows "--staged" as a synonym for "--cached".  I think a better
>    end result will come if we taught "git grep --index" to actually
>    search the patterns both in the index and in the working tree at
>    the same time.  There is no logical reason from the end user's
>    point of view that "git grep --index" (aka "git grep
>    --staged-and-working-tree") needs to fail; if we make the
>    "--mode2" to mean to work on both the index and the working tree
>    for any Git command when it makes sense, things will be more
>    consistent, and it certainly makes sense to ask "git grep" to
>    work on both the index and the working tree.  We do allow "git
>    grep -e pattern tree-ish-1 tree-ish-2" to search in multiple data
>    sources already, so it can be seen as a logical extension.

  git grep --staged --working-tree

>  * "git diff --index [TREE-ISH]" has exactly the same issue as "git
>    grep", and the same conclusion, i.e. it may be worthwhile to
>    teach "git diff --index [TREE-ISH]" to give combined diff between
>    the given tree-ish (defaulting to HEAD as usual), the index and
>    the working tree.

  git diff --staged --working-tree

-- 
Felipe Contreras
