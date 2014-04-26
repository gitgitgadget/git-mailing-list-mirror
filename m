From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/3] remote-helpers: move out of contrib
Date: Fri, 25 Apr 2014 20:28:22 -0500
Message-ID: <535b0bb612af5_ba2148d31061@nysa.notmuch>
References: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com>
 <1398112633-23604-3-git-send-email-felipe.contreras@gmail.com>
 <38F8C9C6-E186-4C42-B3F0-931AE73400FA@quendi.de>
 <5358286ba756e_24448772ec82@nysa.notmuch>
 <EFCABE07-971C-4699-9A03-C5076B3B45ED@quendi.de>
 <53585996ae447_3c7abff31065@nysa.notmuch>
 <480ACEB0-7629-44DF-805F-E9543E66241B@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 03:39:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdrar-0007Cn-Sj
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 03:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbaDZBjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 21:39:40 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:47429 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbaDZBiw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 21:38:52 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so5040124obc.24
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 18:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Hig3D4/7pGqpR4cpX+wsbht3OxR11svJBeXEizZrgiY=;
        b=GDrdk1C88qUZID1w7IZUh7+ySkyLJs9Rvc4IK9CLoMZQ0O2F8DP5scf+gtXImcMYwD
         4M0JQ5sZ0aCA5YeZNT/l/QMj2zIdzxayeTiNQGcTaBIuQ2nw1Zdp/kpK7HjX2/rrlV0m
         Nitvs0Axhi9mHSpjBzN114rhsowwmUUspxUmzklGUHFjB7IhfggDBGPaTzc21sd/+o3M
         bmrbjFomHIblIxrfIpTY76ZrEpUST+PNZjSXMyvxjhwpJWxuAM27PNzAkvoO4Az9MFTx
         CX2nC96/ou3wSF7+ZflxMcsnuobSY3I6Xu8l78gQ8bgMM81uuu9yWN/PnlBJQzMz5kKX
         tZsg==
X-Received: by 10.182.33.6 with SMTP id n6mr9732020obi.48.1398476331501;
        Fri, 25 Apr 2014 18:38:51 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id zm8sm19280649obc.16.2014.04.25.18.38.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 18:38:50 -0700 (PDT)
In-Reply-To: <480ACEB0-7629-44DF-805F-E9543E66241B@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247140>

Max Horn wrote:
> I am going to step away from this painful discussion and also this mailing
> list, but I owed it to send one last reply with two of the problems I am
> still seeing, simply in the hope that this will benefit some future
> git-remote-hg users, but also to dispel any claims I was "hoarding" bugs to
> somehow hurt Felipe.
> 
> Beyond that, I refuse to further "discuss" with Felipe on anything. It leads
> nowhere, and he is so full of himself that it seems impossible to reason
> with him. I will also refrain from countering everything he said, even
> though I am sure he'll construe this as me admitting that he is right. I
> don't care enough to try to keep up the flames *shrug*.  In the end,
> everybody here can interpret this in whichever way they like.

I don't construe anything as an admission that I'm right. The $subject is that
git-remote-hg/bzr are ready to be moved out of contrib, that's my contention
and I don't see why would anyone think that it's not right.

> Ah well, OK, I can't resist one last retort to one point Felipe wrote:
> 
> On 24.04.2014, at 02:23, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> 
> > Max Horn wrote:
> [...]
> > 
> >> Out of curiosity: How do you yourself use git-remote-hg in your daily work?
> > 
> > I don't.
> 
> So you don't eat your own dog-food (at most you sometimes snack on it)?
> That would explain a lot...

Fortunately I don't use Mercurial in my daily work, so I can't use
git-remote-hg on my daily work. It's not a matter of will.

> Now to the issues: The following results are based on git "next" at revision
> e8486314780a4. In addition, I cobbled together fixes from Felipe's
> repository, namely the commit [1] he claimed to have fixed the multi head
> issue I mentioned, as well as the changes from the fc/remote/fixes branch on
> his github repository [2].
> 
> It is very well possible that this is still not the latest and greatest, and
> that I missed some important patch that changes everything -- it's hard to
> tell given the multitude of branches in Felipe's repository. Anyway, to
> avoid confusion, I put my merged version of the script into a Gist [3], so
> if I made a mistake there, it should be easy to discover.
> 
> Given that, the following script (which Felipe already knows from his
> issue tracker [4]) still causes a fast-import crash after which "git pull"
> from the remote hg repository is impossible, and the user has no idea
> how to recover.
> 
> -- 8< --
> #!/bin/sh -ex
> rm -rf hgrepo gitrepo
> 
> # Create a multi-head repository
> hg init hgrepo
> cd hgrepo
> echo a > a && hg add a && hg commit -m a
> echo b > b && hg add b && hg commit -m b
> hg update 0
> echo c > c && hg add c && hg commit -m c
> cd ..
> 
> # Clone it via remote-hg
> git clone "hg::hgrepo" gitrepo
> 
> cd gitrepo
> git gc --prune=now
> git pull  # error
> -- 8< --
> 
> Which results in this:
> 
> WARNING: Branch 'default' has more than one head, consider merging
> fatal: object not found: 61780798228d17af2d34fce4cfbdf35556832472
> fast-import: dumping crash report to .git/fast_import_crash_78219
> fatal: Error while running fast-import
> 
> Any subsequent pulls then give something like this:
> 
> WARNING: Branch 'default' has more than one head, consider merging
> fatal: mark :6 not declared
> fast-import: dumping crash report to .git/fast_import_crash_78834
> fatal: Error while running fast-import

Clearly you are doing something wrong, because 'next' with the git-remote-hg
you put in gist[1] doesn't trigger this issue. I tested.

> What happens here is that a hg branch with two heads is created; this
> repository is cloned via git-remote-hg. Both heads of the hg branch are
> imported to git,

No, they are not. You must be using a version of git-remote-hg other than the
one you said you did.

> The second script is similar but uses a closed branch to trigger essentially
> the same issue. Background: closed branches are ignored by git-remote-hg,
> meaning that no git ref is created for them, which can again lead to a
> commit without a git ref but referenced by the marks file(s). However,
> reproducing the bug in this case is a bit more complicated, because the
> problem is obscured by another bug (?): Namely, if a hg branch is closed,
> then git-remote-hg starts ignoring it, but does not seem to remove the ref
> created for that branch.  So, the git user will not see that the remote
> branch was closed (which is a bug, I'd say); on the upside, since the ref is
> still around, no dangling commit is produced.
> 
> But we can "work around" this by re-opening the hg branch at a different
> position, i.e. as child of an unrelated commit, which does *not* have the
> commits of the original branch as parents. If we do that, git-remote-hg
> moves the git ref to point to the new branch tip, and again we end up with a
> dangling commit (the git commit corresponding to the former hg branch tip).
> 
> Again, this is something me and also colleagues "discovered" in real life
> usage. So don't be fooled by the somewhat convoluted test script. This *does*
> happen.
> 
> -- 8< ---
> #!/bin/sh -ex
> 
> rm -rf hgrepo gitrepo
> 
> # Create a repository with two branches
> hg init hgrepo
> cd hgrepo
> echo a > a && hg add a && hg commit -m a
> hg update 0
> hg branch foobar
> echo b > b && hg add b && hg commit -m b
> hg update default
> cd ..
> 
> # Clone it via remote-hg
> git clone "hg::hgrepo" gitrepo
> cd gitrepo
> git gc --prune=now
> git pull
> cd ..
> 
> # close the branch
> cd hgrepo
> hg update foobar
> hg commit --close-branch -m "close branch"
> hg update default
> cd ..
> 
> cd gitrepo
> git gc --prune=now
> git pull
> # This pull should trigger the issue, but for some reason, the ref
> # origin/branches/foobar is still around, and so nothing happens.
> cd ..
> 
> cd hgrepo
> hg update default
> hg branch -f foobar
> echo c > c && hg add c && hg commit -m c
> hg update default
> cd ..
> 
> cd gitrepo
> git gc --prune=now
> git pull
> # at this point, origin/branches/foobar is gone
> git gc --prune=now
> git pull      # now we get the error
> -- 8< --

Fixed.
http://pastie.org/9113797

[1] https://gist.github.com/fingolfin/11296352

-- 
Felipe Contreras
