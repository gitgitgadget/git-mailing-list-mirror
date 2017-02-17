Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E21222013A
	for <e@80x24.org>; Fri, 17 Feb 2017 07:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755570AbdBQHB2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 02:01:28 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:36228 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752574AbdBQHB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 02:01:27 -0500
Received: by mail-qt0-f176.google.com with SMTP id k15so33778576qtg.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 23:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NEJOQhNNZCGxSTQgQ8N7WFrvQUmo1wQPYh7e6yL3xxo=;
        b=ROb5QD4cLoc7clE5sDh75xG35zu8UAuwb9Gd9CgCPPEJUT5frBOsS2HOsHtp4fRxMk
         YpY+XMVfvB75fo2LSOPmpcz31hEZEuouiZfkqLDVtoPi2OtiiN+r5dTDaTiHrhz3BBbP
         BH/tG3IYNV0Qx+UuZVLNz+b1fMiPQZSlrqcXzS1OzzcYmJCcs9XYCQi1w4So0jKKTmO4
         s0EgaXs8wywY2GP2miHAAfiWZEbVI8MjMfQrsTcaIRqSdWZ+TzEC812/jo4m9FnmMqt6
         Ncj3XWFOQGi4bPyhI1KNMccjHLOi3bva6JdbxqTxbZ+aM7Cmp8QVDBwvA57wgpiMAItd
         guHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NEJOQhNNZCGxSTQgQ8N7WFrvQUmo1wQPYh7e6yL3xxo=;
        b=Hq76SGZucNQ3kqD7gYud5WLz3Xim9/opMp3L6pD/LCfIsUDCz0zBj5H/H8C5rquTba
         IdDtCdZJF5wq/n8fe7bIF/OgeZkIf4kbay0sCUpssGpJCWgNuIH/uonx7mv2UgmY8Zcg
         vQpJ19oOzBVvnTWMr1jqfrf+rjvu4atgYQBwzwFNtLkh40oDk4bv79VZMVPWe1bQJaBt
         jFLLCqJ9UpPYsyt0WHIux31mgAwbkscj0y4WQ5zPhgK11a401uQEdYwS+n/wVHxfDKnA
         EDTUzuQ9E4bRw2UwfKuThKqexQFW2JF5y35cQ/DX2dtd0tiabYhQ1CDii1Q3YzUHRJGe
         y5hw==
X-Gm-Message-State: AMke39l4n1b0H7mB8K0+kR+n8wt9vQ5ITPwruEJOj8Tce7/YGNumi24CuAoEexcHCbFfKX5AZmn0hPk6Uek3hw==
X-Received: by 10.200.34.28 with SMTP id o28mr6546114qto.269.1487314886278;
 Thu, 16 Feb 2017 23:01:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.52.198 with HTTP; Thu, 16 Feb 2017 23:01:25 -0800 (PST)
In-Reply-To: <20170217051755.fx2ueizsprw2vida@sigill.intra.peff.net>
References: <CAOc6etYz6+FzDRbkLS2SB9=F9DP18=6uLKdfCN3D3yd2Gug-tw@mail.gmail.com>
 <20170217051755.fx2ueizsprw2vida@sigill.intra.peff.net>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Fri, 17 Feb 2017 01:01:25 -0600
Message-ID: <CAOc6etZxkspqafifjPTbRDoVBt0XuOLbhiuY9bFTD2Wjtxw-HQ@mail.gmail.com>
Subject: Re: difflame improvements
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 11:17 PM, Jeff King <peff@peff.net> wrote:

> This isn't difflame's fault; that's what "git blame" tells you about
> that line. But since I already told difflame "v2.6.5..HEAD", it would
> probably make sense to similarly limit the blame to that range. That
> turns up a boundary commit for the line. Which is _also_ not helpful,
> but at least the tool is telling me that the line came from before
> v2.6.5, and I don't really need to care much about it.


I'm running my own tests on difflame and I have a theory about "when"
it breaks.... at least one of the cases when it breaks:

Analysis for deleted lines is being driven by git blame --reverse.
What I have noticed is that it "breaks" when blame --reverse drives
the analysis into revisions where "treeish1" is not part of their
history (like, bringing analysis "to the sides" of treeish1 instead of
keeping analysis in revisions in the history of treeish2 that have
treeish1 as one of their ancestors.... which is definitely a valid
case for analysis, anyway). In this case, blame --reverse stops being
helpful.

Take this example (I just pushed a debug-deletion branch into gh...
probably more debugging messages will be needed):

$ difflame.py HEAD~100 HEAD -- Documentation/git-commit.txt
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index f2ab0ee2e..4f8f20a36 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -265,7 +265,8 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
bcf9626a71 (Matthieu Moy      2016-06-28 13:40:11 +0200 265)   If this
option is specified together with `--amend`, then
04c8ce9c1c (Markus Heidelberg 2008-12-19 13:14:18 +0100 266)   no
paths need to be specified, which can be used to amend
d4ba07cac5 (Johannes Sixt     2008-04-10 13:33:09 +0200 267)   the
last commit without committing changes that have
       Range of revisions: 02db2d..066fb04
               Treeish1 02db2d04: 02db2d042 Merge branch 'ah/grammos'
               Treeish2 066fb0494: 066fb0494 blame: draft of line format
       Blamed Revision afe0e2a39: afe0e2a39 Merge branch
'da/difftool-dir-diff-fix'
       Original Filename a/Documentation/git-commit.txt Deleted Line 268
       Children revisions:
               3aead1cad7a: 3aead1cad Merge branch 'ak/commit-only-allow-empty'
       There's only one child revision.... on that revision the line
we are tracking is gone
       Parents of this child revision:
               afe0e2a39166: afe0e2a39 Merge branch 'da/difftool-dir-diff-fix'
               beb635ca9ce: beb635ca9 commit: remove 'Clever' message
for --only --amend
       Finding parent where the line has been deleted:
               beb635ca9: beb635ca9 commit: remove 'Clever' message
for --only --amend
       Range of revisions: 02db2d042..beb635c
               Treeish1 02db2d0: 02db2d042 Merge branch 'ah/grammos'
               Treeish2 beb635c: beb635ca9 commit: remove 'Clever'
message for --only --amend
       Blamed Revision 02db2d0: 02db2d042 Merge branch 'ah/grammos'
       Original Filename a/Documentation/git-commit.txt Deleted Line 268
       Children revisions:
       Found no children... will return the original blamed revision
(02db2d0) saying that the deleting revision could not be found
       beb635ca9 commit: remove 'Clever' message for --only --amend
-beb635ca9 (Andreas Krey 2016-12-09 05:10:21 +0100 268)
already been staged.
       319d83524 commit: make --only --allow-empty work without paths
+319d835240 (Andreas Krey      2016-12-02 23:15:13 +0100 268)
already been staged. ...
+319d835240 (Andreas Krey      2016-12-02 23:15:13 +0100 269)   paths
are also not requi...
d4ba07cac5 (Johannes Sixt     2008-04-10 13:33:09 +0200 270)
1947bdbc31 (Junio C Hamano    2008-06-22 14:32:27 -0700 271) -u[<mode>]::
1947bdbc31 (Junio C Hamano    2008-06-22 14:32:27 -0700 272)
--untracked-files[=<mode>]::



I know that line 268 was deleted on 319d835240.

So.... on the first round of merge analysis it says "let's go into
beb635ca9". That's fine. That's exactly the path that is required to
reach 319d835240. But then when using this new "range of revisions"
for git blame --reverse, we get that line 268 is not telling us
anything useful:

$ git blame --reverse -L268,268 02db2d042..beb635c --
Documentation/git-commit.txt
^02db2d042 (Junio C Hamano 2016-12-19 14:45:30 -0800 268)
already been staged.

So, instead of pointing to 319d835240 (the parent of beb635c), it's
basically saying something like "I give up". My hunch (haven't sat
down to digest all the details about the output of git blame
--reverse... YET) is that, given that 02db2d042 is _not_ part of the
history of beb635c, git blame reverse is trying to tell me just
that... and that means I'll have to "script around this scenario".

$ git merge-base 02db2d042 beb635c
0202c411edc25940cc381bf317badcdf67670be4


Thanks in advance.
