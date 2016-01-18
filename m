From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH v2 3/6] worktree.txt: how to fix up after moving a worktree
Date: Mon, 18 Jan 2016 13:30:05 -0500
Message-ID: <CAPig+cRydwV4VMcfJ1ab50xumU=Ff4k13tN-R2VuEZhP3n=NjQ@mail.gmail.com>
References: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
	<1453116094-4987-4-git-send-email-pclouds@gmail.com>
Reply-To: Eric Sunshine <sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 19:30:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLEZA-0006ly-Op
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 19:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070AbcARSaJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jan 2016 13:30:09 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35137 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057AbcARSaG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jan 2016 13:30:06 -0500
Received: by mail-vk0-f65.google.com with SMTP id i129so12354057vkb.2
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 10:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=Vm1+UhjZFgfCCbGWKyd9kdjZr5MlTX5+AbVnDlREqU4=;
        b=CyfKg87JuQSVKXW6f1VS6ILY3fwwcDROj3H2Wn0y+qSJCEX09KiCFUkeChFmakOn7k
         8Lrh3/nZWxZX2DykW1urKgEuV2hYZlqmZejsW/vbLO3wqg1uEacSr2hiXeuuaqFeRZ7Y
         ex9B4cxkv39PK11/txjvwD4SJrPKvt6enu/HGCDRaZDF+iiFDuvTET/eQu/9PYfQcqCK
         ex21uKrY5/BXH7Oi0/K5bv21WjJAIFPPB1QgjctS/ii+BGh7XgBC1rmwXBFbtDc1ddSB
         +8X0OjVsp8C5R6CnaqyT3lFMuAKDGn+6cQX41xM6q86KXySSq1cRyRmg7g7Fdao/WEf5
         UUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Vm1+UhjZFgfCCbGWKyd9kdjZr5MlTX5+AbVnDlREqU4=;
        b=Sk1Al/A2W2JsofzdQ9VQwOvFWR+YdamqpL3HRdu3eP5Yp7/N884o/DW2sRitFLrPzL
         3PZ2FT4Hh5ln8O1LycoRpttnmZznf4AQ9ZLGeN+Ucef7fbL4ZLVUhljmFR4Kkz1uvnpZ
         PZQTlxy5n8dhr7UYF+VZcS2VaV9cE5r1FxQvVtpPSmv4bodsh5lMv2O14rAmW10meAsO
         88TdQxXyoGVuVfO/0nc4KnZ1lwLr9gthU8hginjHN1tTdHL5s64UxiPtDhBNDrCQOiQQ
         +E65hPeobTqJ4+PZZ5I0ZDU+vuIMcG1oJmmE5gUQLvIVa9XHAe5wSbYELNcEWlr0G4Rf
         duuA==
X-Gm-Message-State: ALoCoQnKgyBtdIfAMbdXR2kc3wWNsw3soZM+Jp+g0Rt0TOs3QhvCwmmZQWf1vB7DKPBwOyux484uWZvMjXl7O+QJ95rkmfDw/w==
X-Received: by 10.31.58.74 with SMTP id h71mr17875065vka.151.1453141805641;
 Mon, 18 Jan 2016 10:30:05 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 18 Jan 2016 10:30:05 -0800 (PST)
In-Reply-To: <1453116094-4987-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284303>

On Mon, Jan 18, 2016 at 6:21 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> From: Eric Sunshine <ericsunshine@gmail.com>

Let's use sunshine@sunshineco.com instead.

If you want to keep this patch separate from the previous patch, then
perhaps add a commit message here saying something like:

    Following the example of af189b4 (Documentation/git-worktree:
    split technical info from general description, 2015-07-06), keep th=
e
    high-level overview free of low-level details about updating
    administrative files when moving a worktree, and instead mention
    $GIT_DIR/worktrees/<id>/gitdir in the "DETAILS" section.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

> ---
>  Documentation/git-worktree.txt | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-workt=
ree.txt
> index 4814f48..62c76c1 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -32,9 +32,9 @@ The working tree's administrative files in the repo=
sitory (see
>  `git worktree prune` in the main or any linked working tree to
>  clean up any stale administrative files.
>
> -If you move a linked working tree to another file system, or
> -within a file system that does not support hard links, you need to u=
pdate
> -$GIT_DIR/worktrees/<id>/gitdir so that they do not get automatically=
 pruned.
> +If you move a linked working tree, you need to manually update the
> +administrative files so that they do not get pruned automatically. S=
ee
> +section "DETAILS" for more information.
>
>  If a linked working tree is stored on a portable device or network s=
hare
>  which is not always mounted, you can prevent its administrative file=
s from
> @@ -135,6 +135,13 @@ thumb is do not make any assumption about whethe=
r a path belongs to
>  $GIT_DIR or $GIT_COMMON_DIR when you need to directly access somethi=
ng
>  inside $GIT_DIR. Use `git rev-parse --git-path` to get the final pat=
h.
>
> +If you move a linked working tree, you need to update the 'gitdir' f=
ile
> +in the entry's directory. For example, if a linked working tree is m=
oved
> +to `/newpath/test-next` and its `.git` file points to
> +`/path/main/.git/worktrees/test-next`, then update
> +`/path/main/.git/worktrees/test-next/gitdir` to reference `/newpath/=
test-next`
> +instead.
> +
>  To prevent a $GIT_DIR/worktrees entry from being pruned (which
>  can be useful in some situations, such as when the
>  entry's working tree is stored on a portable device), add a file nam=
ed
> --
> 2.7.0.96.g5373197
>
