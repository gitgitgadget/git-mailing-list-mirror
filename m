Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 813C31F424
	for <e@80x24.org>; Fri, 27 Apr 2018 17:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758831AbeD0RS1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 13:18:27 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:47098 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758271AbeD0RSY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 13:18:24 -0400
Received: by mail-pf0-f196.google.com with SMTP id p12so1930693pff.13
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 10:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JiNXUgZj4sd7ghU12E9RRPmJAZlAotxBL01iEHaBYzg=;
        b=KhnidsJWIZ4ZV4+fTIsyn4HlMoVucCinZEF8OawTgfRPPINt/noSOCCCAO8RpipQsu
         ANtIGuF2k7BXz4cfn5a7QDpVtoVQ4bYWLNPHkZYMnd0402ZOUTVmMq1nFR298jLWEer1
         JGtXj7IKIHtzQE+L8nLvIU3LFgKOxJqpGYahWEnTCzLK9USmb46qePqhv0mBPCnOjltG
         9Yum9/+YKuVOn2jlaFSRptczCwQgwp+7F9GxYCCyugNsdJ4I0bpmGBonWv4Vxw2HGNOH
         PQ2uYxZo9ETeC4sobt22HOHAHnOsVZi4FoArSxauszsUSMm4nbQ3ntU4h7A0xMVGz8Vq
         p9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JiNXUgZj4sd7ghU12E9RRPmJAZlAotxBL01iEHaBYzg=;
        b=X9qeQGeFr7re9ld3wyaHiyqQMWIbXNgNLSYIxox7UDJ4Jp1ooP+UjUEk1f1Za0GBxj
         M+YVcBHS9XOvs+DoTzmUVe8b8WWZPBvIOdMfo7lNOuXz0HSwMmE1/WodRPPhB1FTIOS5
         w2GEds+kHSzwmfvJXDg0H4PQYkCFzR4YuqdL7eW35zzi24xPPa3P9ZzJdFW9Dq1vGEzn
         RxI8akpNHItlU2YzuLn+Py6+OmkQIYsdMBRysUtuiTOZMfxumYjlF0rmg4LwsAusti67
         waTZNurVgG/Un5wiLNMmhrMMeZW0W/E3SG0cQJi2gfpO6vCwXEMY8ig/uarR3Dpd2yzF
         +ong==
X-Gm-Message-State: ALQs6tCe0mJttNB4I4+Dbm/X2tHBlCgbKz/PMQDpZ/BQ1z5kaEQtKZlt
        ePwNY0y6JGBHNI52v1DZ3Z+jPiiOkH0wuWS7FGw=
X-Google-Smtp-Source: AB8JxZreivjs6tsb4pcuSttIgZONBV60o/GueGzCm+fMueTOzSqH9WkCbHdTS5hOfo67pqc46Is9EZX84XtLKQLIyh8=
X-Received: by 10.98.237.17 with SMTP id u17mr2944148pfh.78.1524849504241;
 Fri, 27 Apr 2018 10:18:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Fri, 27 Apr 2018 10:18:23 -0700 (PDT)
In-Reply-To: <20180427170440.30418-3-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com> <20180427170440.30418-1-asheiduk@gmail.com>
 <20180427170440.30418-3-asheiduk@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 27 Apr 2018 19:18:23 +0200
Message-ID: <CAN0heSpdc51+7-uWcLVXU72qLZgZApdME8ywBJaQQy4DiWHAfg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] doc: align 'diff --no-index' in text with synopsis
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27 April 2018 at 19:04, Andreas Heiduk <asheiduk@gmail.com> wrote:
> The two '<path>' parameters are not optional but the option
> '--no-index' is. Also move the `--options` part to the same
> place where the other variants show them.

Should this commit message be updated after the changes you did to
address Junio's comment? This text suggests you want to place --no-index
in [] (and you did in v1) but you do not do that below.

> All three items are already correct in the synopsis.

Same here, now you actually do change things there.

> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> Reviewed-by: Martin =C3=85gren <martin.agren@gmail.com>

Strictly speaking, my Reviewed-by was on another patch. I do find this
one better though thanks to Junio's suggestion (except the mismatch with
the commit message).

Thanks for continuing with this series.

Martin

> ---
>  Documentation/git-diff.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index b0c1bb95c8..6593b58299 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  'git diff' [options] --cached [<commit>] [--] [<path>...]
>  'git diff' [options] <commit> <commit> [--] [<path>...]
>  'git diff' [options] <blob> <blob>
> -'git diff' [options] [--no-index] [--] <path> <path>
> +'git diff' [options] --no-index [--] <path> <path>
>
>  DESCRIPTION
>  -----------
> @@ -29,7 +29,7 @@ two blob objects, or changes between two files on disk.
>         further add to the index but you still haven't.  You can
>         stage these changes by using linkgit:git-add[1].
>
> -'git diff' --no-index [--options] [--] [<path>...]::
> +'git diff' [--options] --no-index [--] <path> <path>::
>
>         This form is to compare the given two paths on the
>         filesystem.  You can omit the `--no-index` option when
