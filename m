Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CABFD1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 11:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbfILL3C (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 07:29:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:41635 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbfILL3B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 07:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568287739;
        bh=0djt6PfaTTe9pH5wOoe/NsnyTDEtKVUpP/Wmb3QFejE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TMqM0FKHTcsg1KpeZisPjDO1TeVUJeShglANuIcZpyL7DayOQKL+fmxxOPAIGmg3E
         jfcU/Krxzk4r+J5ccB/82GD7gNMxZcv44ey46OjsbJmFHcMLxviOkFT/raERRu45Yr
         8wc1ZEENsdzW3BwxgpikKvs8Yp0Bztxs8u/1EJZA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTCDO-1hiYvN13QM-00S5di; Thu, 12
 Sep 2019 13:28:59 +0200
Date:   Thu, 12 Sep 2019 13:28:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Castro Alvarez, Sebastian" <s.castro.alvarez@rug.nl>
cc:     git@vger.kernel.org
Subject: Re: could not fork child process rebasing required
In-Reply-To: <CAMr8YN7aa9yK3TSqVhQjn2DG7vU_zJs9SHvznPefay+Mxs_Qsg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909121327450.47@tvgsbejvaqbjf.bet>
References: <CAMr8YN58q94bnBkdfxrBR-Vw5Mk4akHzn4c1k2HjMQCXKWdWsA@mail.gmail.com> <nycvar.QRO.7.76.6.1909121044250.47@tvgsbejvaqbjf.bet> <CAMr8YN7aa9yK3TSqVhQjn2DG7vU_zJs9SHvznPefay+Mxs_Qsg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eQN1QnDnLFsRi00M632x3hjd2Ml8uvrQUucQfeoaqTqSM6nh2YO
 ZuzXzXDnETFPxRCiWTbMsvaLNil/lzgSOjW+AjKmI4c9kvgVqRDIba8ysT2uSpPfoVOTSvq
 ewOKTmrU7EkUxNNCZHc0B+49GRUrHplhDXwWzzHD3Qk1GgkuBmxMz0VfkzIoWco8VqzIs/c
 CYiTohk577wTeLjNve/0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZSRZXzvsmek=:MbeT9PqfkYMNeCgWFpnAYF
 bAQuJ4hpdc2JisNhj6OuKbOkuy6L7D1JsJ25SwDbmxFfI/MrQiNnS8+prsWlpw4ID+3CMasIK
 i4Bi7rS7pPjHrAOwsobL44c2gWMdjlb3ID1gjzioIj2ioghRM4D4P+CZgEflWJpiqnK/CZCLz
 3SINWuW+KlF2fTGBWtxe49/tvYJ3O/HsfM10U/uV8cbG6v5IT0dcyB8RAfBbOdDB9/MNlw0j0
 mHinJ4kNaFfd8ojtj7dKOZD39mNFkMEuUbabwSY9ZIjHLQ2vYuH2r+UwXYGuZ7LjrQ6Zgbemt
 LZL0dJThTSHt1CW89mE7X1Nl3aAEoT7FtzzZINZ8oLlLKIP83tO/JZsqpQBqc5edZAute3KkZ
 JH1AuHpcS7LuKnUBIiDaBuojRais56+bsb/3Knw5agDZGVRY4a90Qj2Y5doiAPIJHuEWWY8M6
 IBLz6AA/ucjsQzufknOuS9k36IcgqJ/Dn3IAW/VyHFfz3M+6FV4OzGAj7Bl6Z3AnaGpp/8Jut
 umblvd+YcjK5yFp8xrNa/YveyHjfKiFbHpZz6uzZypErLuAVlAaI/6dopQdRlbILHT6MZg0Fh
 n2FWNomuJRStdJsL/xkPO8jWx3MblXwu0WIScbwOfnoezNdEPDfRP/zVI0Vi1I13Lt3tw1/05
 Xl66ssFvGTYvQ3HCabpWN5vIJ2LU5xzTtW5R/Z1v1fpgeeP18FmUy8ytUYJ4NrDsOzL7zwiL4
 NqWenxoSNMn0r5rOEbQ20iF+C/p0U1x5Kg492/5uLtYdSu5b9YzgtIkFZWTQYOiurIPTCJszD
 NJ9olW/35mcmxiNWHgK1PQBG+Vx+FOqUH+3y1h8H5+kEx7k6VgrIDcbBCnWm5M3v+B54ma6j9
 VTq7c+JQbr1lRMm518IC2vAnTJkKNNQfw+OVkiUp0lUzkeYKXQbvenxG+KwWzoshv8sY9RaTl
 Aaw2ZUmIaydmKDib191NX84qt1cKpi3qCYx/GMLndxcpPe7nWw1wIK8M3Ghzn+G0ZyLSxeOjX
 T7gTbCHweLeO2TVSg8djVzkOzCk5+16g8uuRBmUU9DlCunGWdfuNoQL7VQ/7say8oCr72bR9J
 uV/aMwCfsOG9Pb4lYH6ncMLUfE3enC4KkD+MLxUv7frEkm6VRxEhWSHQf5DIFC0U7ovcJ5JDc
 1o0OAMx2m3RGk9bXYvG17pBbe6XPZ8ZpBJ5fNBW6ZO8MFlAnrmdx784ZHhRNo68epPe5b/Xe5
 oAU2O3wmy2ZtcdPmuG0+lRX6nuHhNJdmCdBrA3Re1r7U4dNufEoVaYeHuYmI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sebastian,

On Thu, 12 Sep 2019, Castro Alvarez, Sebastian wrote:

> I have tried with both versions 32-bit and 64-bit, none of them work
> for me, I still get the same error. :(

The most common reason for this, then, would be an overzealous
anti-malware.

Ciao,
Johannes
