From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 28/32] gc: style change -- no SP before closing bracket
Date: Wed, 9 Jul 2014 05:47:27 -0400
Message-ID: <CAPig+cSfbs3NuyfbrUrJ5BGP9J7GvGCSda2E7ZjA2k4ZXotNRQ@mail.gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
	<1404891197-18067-29-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 11:47:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4oTO-0005o8-6F
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 11:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150AbaGIJra convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 05:47:30 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:59217 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbaGIJr3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jul 2014 05:47:29 -0400
Received: by mail-lb0-f182.google.com with SMTP id c11so4871744lbj.13
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=FApghwO/fAJhFTLWjo0q2vDX2HLak/UpoLXv6uCchKE=;
        b=k8vF7XQ2zYLeLgMOcRVxOgjilcVqo9ZYSJV5juLq99ueBPe90AhsQRIrIQuOg67siB
         25IMp0qx+CU3gwcgBfjg6BDz/7CqKbDSzUAFWrD25it7V80EK+Y3NnmsXvKUhWP0HszO
         yHB4CXffUT7XqxcwJvhvm+BE15J+AguG9WGwjyVo7ZeRBn3qWlOY0uH/4kKJo6kGGv9U
         H5vU+19Ro4QJvpPRSyPFeXlWVVX7uVoYC5rgC+3/bu9A48zhRTPZ/SPc8Hi/ByiRQfnS
         vnp5VPZd8G0VmJ0q4SyGkRi179BDIjHdEiX/UXrLaemNGJnVRhKLH1W71Rye/riVUSKO
         +VAA==
X-Received: by 10.112.138.36 with SMTP id qn4mr1026261lbb.74.1404899247613;
 Wed, 09 Jul 2014 02:47:27 -0700 (PDT)
Received: by 10.114.78.167 with HTTP; Wed, 9 Jul 2014 02:47:27 -0700 (PDT)
In-Reply-To: <1404891197-18067-29-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: Yosx1yV53rdenBxuZyxGSekDuC4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253109>

On Wed, Jul 9, 2014 at 3:33 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/gc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 8d219d8..53f1302 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -285,7 +285,7 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
>                 OPT__QUIET(&quiet, N_("suppress progress reporting"))=
,
>                 { OPTION_STRING, 0, "prune", &prune_expire, N_("date"=
),
>                         N_("prune unreferenced objects"),
> -                       PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expir=
e },
> +                       PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expir=
e},

Yet, there is a space after the opening '{'. So, this is now
inconsistently formatted as:

    { foo, bar}

>                 OPT_BOOL(0, "aggressive", &aggressive, N_("be more th=
orough (increased runtime)")),
>                 OPT_BOOL(0, "auto", &auto_gc, N_("enable auto-gc mode=
")),
>                 OPT_BOOL(0, "force", &force, N_("force running gc eve=
n if there may be another gc running")),
> @@ -298,7 +298,7 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
>         argv_array_pushl(&pack_refs_cmd, "pack-refs", "--all", "--pru=
ne", NULL);
>         argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
>         argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
> -       argv_array_pushl(&prune, "prune", "--expire", NULL );
> +       argv_array_pushl(&prune, "prune", "--expire", NULL);
>         argv_array_pushl(&rerere, "rerere", "gc", NULL);
>
>         git_config(gc_config, NULL);
> --
> 1.9.1.346.ga2b5940
