From: =?ISO-8859-2?Q?Bojan_Petrovi=E6?= <bojan85@gmail.com>
Subject: Re: Mistake in git-reset documentation
Date: Sun, 28 Oct 2012 10:32:21 +0100
Message-ID: <CABPGWqoA9RKfAT5HPtL8q+cqVnNtY3m62FbnFupDfdNztjOhVA@mail.gmail.com>
References: <CABPGWqr7=Rq4qS7yP09t2vMBUJ98NFTSmHUUgMzUQ5=WVrjfqg@mail.gmail.com>
	<20121028083610.GA26374@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 10:32:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSPES-0006x4-7K
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 10:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901Ab2J1JcY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Oct 2012 05:32:24 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174]:42983 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab2J1JcW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Oct 2012 05:32:22 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1332976eaa.19
        for <git@vger.kernel.org>; Sun, 28 Oct 2012 02:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=WDcPl1AiLKbBm3qYkEf+xKSgR+GUvPIKwlpiNjl0CYs=;
        b=ioXVeq8wm8/4Cryy+GN0YSAy/MlmOX5IvzPs+nV86nrb5ma8yMhS4c5oMO9EUuuGhU
         5vp9FgyH3X9TRlXnlG9x4IblHUBpG6fk9GyDTcnI67pMqowQzOKFj5u/cjCUtgp5rHdd
         Dm3tWd73qxNYTe0DsmKXmgw/eIa1YDFa788YcAT1HkTUZE6BI6R1LwY04jQsjL7TbK0E
         HDyW5Ws9gVp1CQt1b1HqqaEWAx/aW79x14vK/SvVpUPL0B77hLPhQoQdj6St4Eidgd6e
         r3ZVLEvrVrxxWpCnwIaYGXvJzdgHsgVzAc7gR2cl7HGVvRQfWLUVRt3bRUuVQ5EU4Lv/
         HFQw==
Received: by 10.14.216.193 with SMTP id g41mr40973880eep.37.1351416741364;
 Sun, 28 Oct 2012 02:32:21 -0700 (PDT)
Received: by 10.223.144.68 with HTTP; Sun, 28 Oct 2012 02:32:21 -0700 (PDT)
In-Reply-To: <20121028083610.GA26374@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208535>

No need for that. Getting this patched will be enough. :) Thank you!

On 28 October 2012 09:36, Krzysztof Mazur <krzysiek@podlesie.net> wrote=
:
> On Sat, Oct 27, 2012 at 01:21:18PM +0200, Bojan Petrovi=C4=87 wrote:
>> None of the three forms of git-reset accept: "git reset" which is th=
e
>> equivalent of "git reset -mixed".
>>
>> Square brackets should be used instead of parentheses for "--soft |
>> --mixed | --hard | --merge | --keep".
>>
>> Bojan
>
> Square brackets are also missing in "'git reset' --<mode> [<commit>]"=
=2E
>
> Bojan, do you want to add a Reported-by line with your name?
>
> Krzysiek
>
> -- >8 --
> Subject: [PATCH] doc: git-reset: make "--<mode>" optional
>
> The git-reset's "--<mode>" is an optional argument, however it was
> documented as required.
>
> Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
> ---
>  Documentation/git-reset.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.tx=
t
> index 117e374..1f95292 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  [verse]
>  'git reset' [-q] [<commit>] [--] <paths>...
>  'git reset' (--patch | -p) [<commit>] [--] [<paths>...]
> -'git reset' (--soft | --mixed | --hard | --merge | --keep) [-q] [<co=
mmit>]
> +'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<co=
mmit>]
>
>  DESCRIPTION
>  -----------
> @@ -43,7 +43,7 @@ This means that `git reset -p` is the opposite of `=
git add -p`, i.e.
>  you can use it to selectively reset hunks. See the ``Interactive Mod=
e''
>  section of linkgit:git-add[1] to learn how to operate the `--patch` =
mode.
>
> -'git reset' --<mode> [<commit>]::
> +'git reset' [--<mode>] [<commit>]::
>         This form resets the current branch head to <commit> and
>         possibly updates the index (resetting it to the tree of <comm=
it>) and
>         the working tree depending on <mode>, which
> --
> 1.8.0.46.gd11dae0
>
