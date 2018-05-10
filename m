Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FB971F406
	for <e@80x24.org>; Thu, 10 May 2018 15:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966035AbeEJPAQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 11:00:16 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38366 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965215AbeEJPAP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 11:00:15 -0400
Received: by mail-ot0-f193.google.com with SMTP id n3-v6so2639383ota.5
        for <git@vger.kernel.org>; Thu, 10 May 2018 08:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hatpAC/Xrh1Kamy5JT/POGCTzH2YZ/UiRP1TQWgeRqw=;
        b=ZC6VXwIKKCjEqOHJOedtMT8OIh9A0oBau5tmcp9mnPxjOHn2m89W3HXFNHHfioam0d
         X1cYt5FMRuMAeCZNTjJ4IHE13+yZFmuOTWmjRDwg2K/4j+bqKLTP6RzHvrO7PQskzjNg
         DaCrjKkgqcpb3oBTGU2zz/ie+bH/w2TIS2HF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hatpAC/Xrh1Kamy5JT/POGCTzH2YZ/UiRP1TQWgeRqw=;
        b=dLykXYu7YpqMV4FFde2RlOlOxKy3flRCKx++gf5B+oHm/3u2mB+iYjqjhqJKlHykF/
         GpUlocGaQbtcBbWSn+J70QXbNulUS+iybtARvo//yxGz0d/sn5Xp1tTn2ZF8oM6BIoz1
         aQIP5P/4+mZTqdurNiWwAFPCekWXbJ+qu1VSq+LQIkg1iunWv9pZCdVCpCF5sQb0UNlO
         n4tYHGY6QCTlf0dBWbohZoohd+LjqhT6+eKK8yaJcRTVzIbn9EoZzqNw3y+L8jWshYMu
         09pFee7mDR1Rr0NrI0mDervf/A3Te9UElX6FD+je07tHyfQQNSvZ/7Z7wy/aMh8vNsgu
         g2uw==
X-Gm-Message-State: ALKqPwcI0XtccOoMv0EfdVo4wj92vZo4zsR+AFwILmcBySg1cL4nV5e8
        iP1z/w+dGLMIpFgM201ht/EI7OLzYZxQ7NC3ImIqow==
X-Google-Smtp-Source: AB8JxZoGWKTOapyiwtO3ReWkEVQ4kQ+NQ087ppMdSh//KOXY8AM51HMG6PWas9J4PmnR+yhmMo58hF0ARXAB7AzyQs0=
X-Received: by 2002:a9d:5774:: with SMTP id x49-v6mr1272226oti.314.1525964414570;
 Thu, 10 May 2018 08:00:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3c57:0:0:0:0:0 with HTTP; Thu, 10 May 2018 08:00:14
 -0700 (PDT)
In-Reply-To: <20180510124303.6020-4-avarab@gmail.com>
References: <20180501184016.15061-10-avarab@gmail.com> <20180510124303.6020-1-avarab@gmail.com>
 <20180510124303.6020-4-avarab@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Thu, 10 May 2018 16:00:14 +0100
Message-ID: <CAE5ih7-MKQoB27MKd0jJ91O+uKm8e2X5h8OcEaaGJAoYdWL5XQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] git-p4: change "commitish" typo to "committish"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 May 2018 at 13:43, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com> wrote:
> This was the only occurrence of "commitish" in the tree, but as the
> log will reveal we've had others in the past. Fixes up code added in
> 00ad6e3182 ("git-p4: work with a detached head", 2015-11-21).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Looks good to me!

Thanks,
Luke


> ---
>  git-p4.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 7bb9cadc69..1afa87cd9d 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2099,11 +2099,11 @@ class P4Submit(Command, P4UserMap):
>
>          commits =3D []
>          if self.master:
> -            commitish =3D self.master
> +            committish =3D self.master
>          else:
> -            commitish =3D 'HEAD'
> +            committish =3D 'HEAD'
>
> -        for line in read_pipe_lines(["git", "rev-list", "--no-merges", "=
%s..%s" % (self.origin, commitish)]):
> +        for line in read_pipe_lines(["git", "rev-list", "--no-merges", "=
%s..%s" % (self.origin, committish)]):
>              commits.append(line.strip())
>          commits.reverse()
>
> --
> 2.17.0.410.g4ac3413cc8
>
