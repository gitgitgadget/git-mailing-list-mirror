From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 03:32:56 -0500
Message-ID: <535e12389eb8d_338911e930c9c@nysa.notmuch>
References: <535C47BF.2070805@game-point.net>
 <1748955386.11457068.1398588660139.JavaMail.zimbra@dewire.com>
 <535D3DF8.4020904@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeremy Morton <admin@game-point.net>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 10:43:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WehA5-0004RY-AD
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 10:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbaD1Ing (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 04:43:36 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:53540 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbaD1Ind (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 04:43:33 -0400
Received: by mail-oa0-f50.google.com with SMTP id i11so6879392oag.37
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 01:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=K4uwlwusP65MRuM02zTy02EaEL3du016gwEld01Hf3s=;
        b=nv55Yoei7SCE9TGayEOJ31P41aLmqlLrfVkmx6njxk0IVlLL72b9mRAG0F9ApUyoNj
         TJ23g4i6NdZBA/JcHP4qupt2bDiQ9jkb8knAlxXMLayNY3UJ4QtG9WK7X0/5UiHBAf6m
         J8eBl4WIIi0+AXm0H8u3OOFDJYf0TSpfRhpK9ZEjamZVJQaVFbTqaOKbGTaCzGTpvYCD
         GXR3gNi5XUk0QZE0UlauWEbeiQ/77SgSLVTn2/xYeSlUsqVQGrVRITG7UeoXD19iNAar
         P7cWeE5grxurECG/P1TpvKWEcvREpNoJtx46xWcdvN+qwI19WDR86VNiYuqhIE7M6gc3
         9CVQ==
X-Received: by 10.60.16.103 with SMTP id f7mr21156462oed.8.1398674613257;
        Mon, 28 Apr 2014 01:43:33 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ut8sm35370054obc.22.2014.04.28.01.43.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 01:43:31 -0700 (PDT)
In-Reply-To: <535D3DF8.4020904@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247245>

Jeremy Morton wrote:
> On 27/04/2014 09:51, Robin Rosenberg wrote:
> >> Currently, git records a checksum, author, commit date/time, and commit
> >> message with every commit (as get be seen from 'git log').  I think it
> >> would be useful if, along with the Author and Date, git recorded the
> >> name of the current branch on each commit.  The branch name can provide
> >> useful contextual information.  For instance, let's say I'm developing a
> >> suite of games.  If the commit message says "Added basic options
> >> dialog", it might be useful to see that the branch name is
> >> "pacman-minigame" indicating that the commit pertains to the options
> >> dialog in the Pacman minigame.  Basically, I'm saying that well-named
> >> branches can and do carry useful contextual information that oughtn't to
> >> be thrown away.  Currently, when you delete that branch, you lose the
> >> branch name altogether.
> >>
> >> So what do you think?  Would it be good to have a patch to add this feature?
> >
> > Branch names are usually poorly named, so often you don't lose much. One way
> 
> Speak for yourself - I give my branches useful names.  :-)

Me too.

> I definitely feel that I am often losing useful contextual information by
> throwing away the branch name.

I don't.

> > some people to is to always merge with --no-ff, that way you see the branch
> > name in the merge commit.
> 
> But surely, it's recommended with Git that you try to avoid doing 
> --no-ff merges to avoid commit noise?

Nope. Different people have different needs, there's no recommendation. If
anything, the recommendation is to do a ff merge, because that's the default.

> Also, it is a lot more hassle (and no doubt, CPU cycles) to track down where
> a branch was merged to try and figure out which branch name a commit
> pertained to, not to mention the fact that the commit could've been moved
> since.  Nothing short of tagging the commit with the branch name when the
> commit is made will definitely record the branch name at the time of
> committing.

But why do you need that information?

-- 
Felipe Contreras
