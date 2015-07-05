From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Draft of Git Rev News edition 5
Date: Sun, 5 Jul 2015 15:11:01 -0400
Message-ID: <20150705191101.GB9815@flurp.local>
References: <CAP8UFD2fpRiOmgL9GW-1N9ZLAY+p-nOSH-b57vJFO4e_tELrWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <npaolucci@atlassian.com>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	Eric Raible <raible@nextest.com>,
	Emma Jane Hogbin Westby <emma@emmajane.net>,
	Max Kirillov <max@max630.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	karthik nayak <karthik.188@gmail.com>,
	Paul Tan <pyokagan@gmail.
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 21:11:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBpKE-0000qi-1o
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jul 2015 21:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbbGETLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jul 2015 15:11:11 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34554 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbbGETLI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 15:11:08 -0400
Received: by igcsj18 with SMTP id sj18so219242124igc.1
        for <git@vger.kernel.org>; Sun, 05 Jul 2015 12:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/WcJ9k7nanf8Lv1UpuVvf2yXzeJRl0m509pMtV15D1Q=;
        b=gm05vhetZTN/wlw/1OjKhkSSkCS777L9rEfykPt/4/d6XoGKB66RNLlUyf4T6A6FQr
         7t0sCtH0/bKy9qh+LWOlhoTDPkqXyzGAtSBO1d056wTG3fkRaJ52QcEaIoZ17bWorPQI
         IOl2/gaqCMiZxQCW6ss5oKESX8z0t69O1lbTBSB2cjRJmYp9pmWOmIQ9sTvGUNIeDJeW
         dZj4kdIDdqg3xgwSi3W2E3F0fVcE9MHc+PEGmwlZrpCkaiRD9kOmL09dwbIbAunwgBoh
         gUfjcmeXZaTM6hzhcxZYnzNf8QIfauTnFvb5Jyq2MAyEhMWImyCXpYCEBJ5PItpz4K2U
         UBRA==
X-Received: by 10.42.216.199 with SMTP id hj7mr31713793icb.11.1436123467847;
        Sun, 05 Jul 2015 12:11:07 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j4sm8227565igo.0.2015.07.05.12.11.06
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 05 Jul 2015 12:11:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAP8UFD2fpRiOmgL9GW-1N9ZLAY+p-nOSH-b57vJFO4e_tELrWw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273370>

On Sun, Jul 05, 2015 at 01:13:57PM +0200, Christian Couder wrote:
> A draft of Git Rev News edition 5 is available here:
> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edit=
ion-5.md
> Everyone is welcome to contribute in any section...

I'm not familiar with the criteria for deciding what merits mention
in the newsletter. Is the recent introduction of git-worktree and the
attendant relocation of "add" and "prune" functionality worthy? If
so, perhaps the following write-up would be suitable?

---- 8< ----
=46rom: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] rn-5: talk about new git-worktree command

---
 rev_news/drafts/edition-5.md | 60 ++++++++++++++++++++++++++++++++++++=
+++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/rev_news/drafts/edition-5.md b/rev_news/drafts/edition-5.m=
d
index eb00c4a..9df4155 100644
--- a/rev_news/drafts/edition-5.md
+++ b/rev_news/drafts/edition-5.md
@@ -206,6 +206,63 @@ to process the format passed in `--date=3Dformat:.=
=2E.`, a discussion
 about how to manage a potential strftime() failure when it is passed a
 bogus format ensued.
=20
+
+* Linked-worktrees
+
+The linked-worktree facility allows multiple working directories to sh=
are a
+single repository, with (typically) a different branch checked out in =
each
+worktree. Introduced more than half a year ago to provide integrated a=
nd
+platform-agnostic support for similar functionality long supplied by t=
he
+Unix-only and somewhat fragile `contrib/git-new-workdir` script,
+linked-worktrees recently migrated to the *master* branch, but is not
+yet part of any release.
+
+Creation of linked-worktrees is accomplished via `git checkout --to <p=
ath>
+<branch>`, and cleanup of leftover administrative files, after `<path>=
` is
+deleted, is done with `git prune --worktrees`. However, a recent unrel=
ated
+change to `git prune` led to a
+[discussion](http://article.gmane.org/gmane.comp.version-control.git/2=
72546)
+that concluded that worktree-related maintenance functionality doesn't
+belong in `git prune`.
+
+Consequently, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy submitted a
+[patch](http://thread.gmane.org/gmane.comp.version-control.git/272949)
+which introduces a new `git worktree` command, and relocates `git prun=
e
+--worktrees` functionality to `git worktree prune`.
+
+Eric Sunshine then further fleshed out `git worktree` with a
+[patch](http://article.gmane.org/gmane.comp.version-control.git/273032=
)
+which relocates `git checkout --to` functionality to `git worktree new=
`.
+A lengthy
+[discussion](http://thread.gmane.org/gmane.comp.version-control.git/27=
3032)
+ensued, which eventually led to a second version, consisting of [23
+patches](http://thread.gmane.org/gmane.comp.version-control.git/273316=
),
+and which names the command `git worktree add`, rather than `git workt=
ree
+new`, and gives the documentation some needed attention.
+
+Aside from documentation updates, several other user-visible changes a=
rrive
+with the second version. For instance, while preparing worktree-creati=
on
+functionality for the move from `git checkout` to `git worktree`, Eric
+discovered and fixed a bug where `git checkout --to <path> HEAD~1` wou=
ld
+instead incorrectly checkout `HEAD~2` at `<path>`.
+
+The second version also introduces convenience enhancements.  In
+particular, the `<branch>` in `git worktree add <path> <branch>`, is n=
ow
+optional. When omitted, a new branch is created automatically based up=
on
+`<path>`, as if `-b $(basename <path>)` had been provided (where `-b
+<new-branch>` creates a new branch). For example, given `git worktree =
add
+../hotfix`, a new branch named *hotfix* is created and checked out int=
o new
+worktree `../hotfix`, as if `git worktree -b hotfix ../hotfix HEAD` ha=
d
+been specified.
+
+Finally, the question was
+[raised](http://article.gmane.org/gmane.comp.version-control.git/27310=
7)
+whether `git checkout --ignore-other-worktrees` should be retired and =
`git
+checkout --force` overloaded to subsume its duties, however, Junio was=
 [not
+thrilled](http://article.gmane.org/gmane.comp.version-control.git/2731=
08)
+by the idea.
+
+
 ## Releases
=20
 * [git-multimail](https://github.com/git-multimail/git-multimail) [1.1=
=2E0](https://github.com/git-multimail/git-multimail/releases/tag/1.1.0=
) was released. git-multimail is a tool to send notification emails for=
 pushes to a git repository. It is also available in the `contrib/hooks=
/multimail/` directory of Git's source tree (version 1.1.0 will be dist=
ributed with Git 2.5).
@@ -282,5 +339,6 @@ __Git tools and sites__
 ## Credits
=20
 This edition of Git Rev News was curated by Christian Couder &lt;<chri=
stian.couder@gmail.com>&gt;,
-Thomas Ferris Nicolaisen &lt;<tfnico@gmail.com>&gt; and Nicola Paolucc=
i &lt;<npaolucci@atlassian.com>&gt;
+Thomas Ferris Nicolaisen &lt;<tfnico@gmail.com>&gt; Nicola Paolucci &l=
t;<npaolucci@atlassian.com>&gt;,
+and Eric Sunshine &lt;<sunshine@sunshineco.com>&gt;,
 with help from Junio C Hamano, Matthieu Moy and Johannes Schindelin.
--=20
2.5.0.rc1.197.g417e668

---- 8< ----
