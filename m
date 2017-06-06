Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAE4F209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 19:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdFFTFV (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 15:05:21 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34371 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbdFFTFT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 15:05:19 -0400
Received: by mail-it0-f67.google.com with SMTP id d68so28697179ita.1
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 12:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o9KN5/bgqTaGVhkg2sSD35jtmIe1ka/iL13d2gVN9d8=;
        b=KXHhzZrkXrWcuj0UP6LBehdxN/l85HS84Bc2YYUF5w/V2lxdyV67+rNyF90W1Kymwi
         kj7X6RHcrYs9UsTZ9t2aTST27ouKfnZviyvqFy57lcn1P0sV+rFMWaNQEQ2X5EtmC5cv
         qnuecpgm3/djSdCi2ljI6RkULRTXzweOIoNHDPmySz/e9Rigs3yKrsW5+2VC8LkrxKyz
         rfY8iE6VknXJGLvmlHzX+DBbKXxpPq/fR030VNqoSl8KteFbTufyW4gCXAU/TmLFY+JD
         +K1ub1xUlM5AkJywHE/If8ikufyj2DttVId3T/oDB6gfthJS/weyMUPkodKvgS+QHbDi
         aLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o9KN5/bgqTaGVhkg2sSD35jtmIe1ka/iL13d2gVN9d8=;
        b=tPV3ciOt9nyeQEnQwVQtkRu5K3TcnQktSyuhW7pEk413VYHXuYzBf9vvt3fJqYVuXV
         vPxLDt/tb6C3Ra9r8JT0ZNRezSl+hRJwp7nwECnhQrPY6VUn+ZHspr6zfqkojoEHnP6j
         7uDF3D8KVDCkG5tp9/XsDZWBWg5YVfYBUKUNNHRDBQ0CM+O+xpkT2slSxe6z4HpXH1qh
         hpZXGdAiO5Bp0ThTBTnv4zIICX0MEVpLt+0M+O1iMvwpgfohC3tOhy/jDzHGTwKCBiZw
         NuU4LeDLbQRbAUcK2eXNbWsVpKHvMdE6fCOAuLXIIw7O7lXHvccHZMN50XgNSDYr6Plr
         pBzQ==
X-Gm-Message-State: AODbwcCiOkIhfxfbQwjMgCZxGn1aIHFuccMkFhpatkncxoOiDFoVc5ir
        aZVwGLa7b10GIBmRBM9c/HZF/o8zWw==
X-Received: by 10.36.138.131 with SMTP id v125mr18494146itd.66.1496775919032;
 Tue, 06 Jun 2017 12:05:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Tue, 6 Jun 2017 12:04:58 -0700 (PDT)
In-Reply-To: <20170606190111.xm4nzvjhbpsw3qbg@sigill.intra.peff.net>
References: <20170606124323.GD25777@dinwoodie.org> <20170606151231.25172-1-avarab@gmail.com>
 <CAGZ79kaaRsUBAxRKLPxjuk=oRrw2zBdoHWd9iNDmTbY9MpqN-w@mail.gmail.com>
 <CACBZZX485+W99mRspDTf09LjP-C26PaAi+vNSBkW_aVyXAsQJg@mail.gmail.com> <20170606190111.xm4nzvjhbpsw3qbg@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 6 Jun 2017 21:04:58 +0200
Message-ID: <CACBZZX4FsGHha_Nuw=Tbw86Ghh5Mm7ocbmVXNVS7iXnGWT0bdQ@mail.gmail.com>
Subject: Re: [PATCH] sha1dc: ignore indent-with-non-tab whitespace violations
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Michael Kebe <michael.kebe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2017 at 9:01 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 06, 2017 at 08:51:35PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> On Tue, Jun 6, 2017 at 8:23 PM, Stefan Beller <sbeller@google.com> wrote=
:
>> > On Tue, Jun 6, 2017 at 8:12 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> > <avarab@gmail.com> wrote:
>> >> This updates sha1dc fixing the issue on Cygwin introduced in 2.13.1,
>> >> and hopefully not regressing elsewhere. Liam, it would be much
>> >> appreciated if you could test this on SPARC.
>> >>
>> >> As before the "sha1dc: update from upstream" patch is what should
>> >> fast-track to master/maint and be in 2.13.2, the other two are the
>> >> cooking submodule use, that's all unchanged aside from of course the
>> >> submodule pointing to the same upstream commit as the code import
>> >> itself does.
>> >>
>> >> Junio: There's a whitespace change to sha1.h that am warns about, but
>> >> which it applies anyway that you didn't apply from my previous
>> >> patch. I think it probably makes sense to just take upstream's
>> >> whitespace shenanigans as-is instead of seeing that diff every time w=
e
>> >> update. I guess we could also send them a pull request...
>> >
>> > I would suggest the pull request.
>>
>> Looking at this again it's not a bug, just upstream choosing to indent
>> a comment with spaces, not a bug.
>>
>> So it makes sense to just apply as-is so we don't have that diff with
>> them / different sha1s on the files etc.
>
> Agreed. Maybe we'd also want this patch:

Great, that makes perfect sense for prepending to the series.

> -- >8 --
> Subject: sha1dc: ignore indent-with-non-tab whitespace violations
>
> The upstream sha1dc code indents some lines with spaces.
> While this doesn't match Git's coding guidelines, it's better
> to leave this imported code untouched than to try to make it
> match our style. However, we can use .gitattributes to tell
> "diff --check" and "git am" not to bother us about it.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  sha1dc/.gitattributes | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 sha1dc/.gitattributes
>
> diff --git a/sha1dc/.gitattributes b/sha1dc/.gitattributes
> new file mode 100644
> index 000000000..da53f4054
> --- /dev/null
> +++ b/sha1dc/.gitattributes
> @@ -0,0 +1 @@
> +* whitespace=3D-indent-with-non-tab
> --
> 2.13.1.664.g1b5a21ec3
>
