Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F252020248
	for <e@80x24.org>; Mon,  1 Apr 2019 20:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfDAUqL (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 16:46:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:41147 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbfDAUqL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 16:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554151569;
        bh=7fi8W0z+ilPZZVpzoVDW1wbeGSNWNXxptNThRocojmc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Vuqj6CteEpYYG3x0lDFu50ak1iwGvCfchmShwnfxmcUY6ewFdvl0o/NjNEenKR97/
         Ja2ox5eBp0Gi2XIZpQHBjawomD+oXL4iJRLHwEZsjQ3GZXYSBUGsS5p48JA5MELvh/
         fearJEkg2CYl8w47CjG/t91rtURR0UEjZkV9LUEM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LvENG-1gk9HX0a9a-010Nl6; Mon, 01
 Apr 2019 22:46:09 +0200
Date:   Mon, 1 Apr 2019 22:46:14 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git-gui: executed hooks are different from command-line git if
 hooksPath is set
In-Reply-To: <CAODFU0rSSeLReFKci_p3kjJwxD65R21syDTHoKcqWJ0wbF8jZQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904012244520.41@tvgsbejvaqbjf.bet>
References: <CAODFU0rSSeLReFKci_p3kjJwxD65R21syDTHoKcqWJ0wbF8jZQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YIFzDrJYOFivlGD0xRZr/lACKYzTbAHx0n80M9g/m8tC8rQioDq
 q7JL7imDMDJNhRZ0rDrAq/HCJvTM/8cAtsNJMGm8oGqJyHg+EJc1Qmj8UIN47tHBPJ+o4MJ
 fTjs+voPyI27oBEeYoIMiR09g6Amk1M1qXCTr2ke+J+qPIfb59YyfvgVO+C7a9hlOZv8UM8
 JjaZ+grr/vPt0wIJg3Gtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bkdxzhtoYAw=:AiWJo16TFscqKp4AFsCCS3
 jKK7mea0Hbqa2xexwbq8c3Q1RPOdQAhMdsw599SxCZNMw/nPYB1nvfSHJj6m+dPk6qWPK9ZhD
 RmwYVmt81K3K0pM6B/HtAP+o4w3izJbe+/pl2tYbr6BcH0q67RweJOovpgNOcmzcn5sx5RGEf
 8vzrv2v/1BfNzNBY6E6fARPHk8qfcSm0uwqUQvIef1ZAkMZpx+FOPd4UmNGTuqEbTJcoc8gPn
 DK4Wjsc0F/7Qo3ASUd+CDNiLFfdqIkfG7ZYNCHRSvRi710zrJX4RNRzwMXRBYMFLg2t7WFTq1
 vqbN3z82YbVX+n2BM0C69QNJsQcZdS6htiWt8KYrs+VlWF6NJkRAQ+cdcklRNLqQ4/32tAQpF
 Gy5IkvAzXFwl04aXA2PecXIQOJ1qU6DbJ2RNjcPCFhqgblNBTRh9sPkAIKivmYnsu5IM1+T3O
 6SLETOvHpFSZrcXOR/jIvz4Uv2uBBO8eLLJn+PVKoNiS/Oao6C0P31OsSdMX+4GDXqkDKWTRE
 SSM3sO8OalGmAAKxLBRrhTTlakvrD1R9Ihsq0KGQc6jQB4XjsUEnn/yaOE9CLYUFt42F+Gsft
 kmJWelksd63lEhY3IfeZDPVgig/EgvW8uHPojMLC0hfMZTlj4okMEpxCh5C4eaA4hOI9B2Q/V
 ZZO176tw+dB85JAK3Fwns1IboYW8YjFC57HVZ3GjUwr64JXcmUVK9e1pbSpszfgP5haN8edtv
 9VZGmgjFturbCLtqiIXSbaaLB4SayEPnnaMllh8wN9rzUM7VQsVFYB4MMGhmuzL6BTXPT0HcW
 9v2eVCIVIaUV6lGsudz+uGUVsBkgPCirBeRonmOkEPB8WVoudR7wklZ650C58lPPj8UXvWN2X
 oc3vBk5mQLDdUVE3xgMg297dj68n62SNud6DVyTGXK43w7SgxGaTMLpDfnBAQB8j6+B7hG2+J
 ZOY0CceOaVQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jan,

On Mon, 1 Apr 2019, Jan Ziak wrote:

> Command-line "git commit" and graphical "git gui" commit are invoking
> different hooks if hooksPath is set in $HOME/.gitconfig.
>
> Namely, in my case command-line "git commit" runs
> "/home/atom/dev/git-hooks/post-commit" - while "git gui" commit runs
> ".git/hooks/post-commit".
>
> Please run the attached shell script in an empty directory to
> reproduce this issue. The script is using strace to determine which
> hook is being executed. The script will run "git gui": the user is
> expected to simply commit changes from the gui and then close the gui
> for the script to finish.
>
> Script output:
>   command-line: access("/home/atom/dev/git-hooks/post-commit", X_OK)
>   gui: access(".git/hooks/post-commit", X_OK)
>
> $ cat ~/.gitconfig
> [core]
>     hooksPath =3D /home/atom/dev/git-hooks

Could you give `master` of https://github.com/git-for-windows/git a try?
(Despite the name, we aim to keep it functional on the same platforms as
Git itself.)

I am fairly certain that I fixed it there, and contributed a PR to the Git
GUI project, but it seems that that project is in a kind of hibernating
state right now.

Ciao,
Johannes
