From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 4/5] command-list.txt: drop the common tag
Date: Fri, 15 May 2015 17:41:05 -0400
Message-ID: <CAPig+cRDq7VaBL-KHn4OcNaYW_KbYCH074GkbuCqm=grGadmvQ@mail.gmail.com>
References: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431714904-16599-5-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 23:41:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtNM0-0005Zs-9e
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 23:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428AbbEOVlH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 17:41:07 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33588 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbbEOVlF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2015 17:41:05 -0400
Received: by igbpi8 with SMTP id pi8so49476851igb.0
        for <git@vger.kernel.org>; Fri, 15 May 2015 14:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=kcbjiygIqsbS82zpA/NBq89od9F7QJSTqeBgrYmZ+Kg=;
        b=yKLYm7KhFCwLpVR2iYhRhqpcgILUwJlpzfoHPB5C763qfItYpTHr68SIWGhdpsNiAh
         B2mUK23bUuh6dgtABFSyABGBO2iu1kje9pmPtVLfk02M6R1AIzXQfGpP2ByIEhvjAf4G
         zkjmXDuRjtsXNa8M32FxHPxeocBQI9zjlXX/wzQoQXXHAdPNJGkDiB084lQiC47WYPBp
         ogcVJJeKtzgs9LoEnRBm79A2k5LCS6IqRYaIw1QHMhvMPCYjtO4IK/xdCnAii0bmy3hW
         7ze5GuRnFDvQLmRSupwo3/7BJesFPw4iQtC+GF3ykVA36TATJD0Gbwh+J6Q/qYYwaH2/
         C+ig==
X-Received: by 10.107.151.75 with SMTP id z72mr11996720iod.46.1431726065397;
 Fri, 15 May 2015 14:41:05 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 15 May 2015 14:41:05 -0700 (PDT)
In-Reply-To: <1431714904-16599-5-git-send-email-sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: mESK-I9ZWDHp0cCr9TEu0LSHXBk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269188>

On Fri, May 15, 2015 at 2:35 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> The parser generate-cmdlist.awk gathers all group information without
> needing the common tag.

This might leave the reader wondering why the "common" tag was there
in the first place. I probably would have written it this way:

    command-list.sh, retired in the previous patch, was the only
    consumer of the "common" tag, so drop this now-unnecessary
    attribute.

> before:
>     git-add          mainporcelain        common worktree
>
> after:
>     git-add          mainporcelain        worktree

which makes this example effectively unnecessary (plus, the patch
itself already says the same thing).

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---
> diff --git a/command-list.txt b/command-list.txt
> index c00b0b6..2203566 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -11,30 +11,30 @@ remote       collaborate (see also: git help work=
flows)
>  # List of known git commands.
>  # command name                          category [deprecated] [commo=
n]
>  [commands]
> -git-add                                 mainporcelain           comm=
on worktree
> +git-add                                 mainporcelain           work=
tree
