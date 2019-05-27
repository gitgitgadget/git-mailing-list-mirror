Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38EAD1F462
	for <e@80x24.org>; Mon, 27 May 2019 19:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfE0Thd (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 15:37:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:54497 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfE0Thd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 15:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558985832;
        bh=BgPVxVFBBVuUM/ZNMpzjhkV3fhQiNM3OrjVukQ7iK00=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XoeyQaCv4TeHJZ9AwWpiaWT7d99yveM2ElxNfL+eE6yQx84tduUnGmxMZg6Y2sU1Y
         hl+nUVhxI8xZuCsI85nn6BOFsF64fuR8mBLM47wmsdy/tBiGpxjKWjAMJiQP1bKMWv
         UYK3sOt8WkPedaXiRxN659cAbCTIywFfPkRXSIJY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MS5Dm-1h3K9C1u6U-00TA2L; Mon, 27
 May 2019 21:37:12 +0200
Date:   Mon, 27 May 2019 21:37:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Ismael Luceno <ismael@iodev.co.uk>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH v3] git-gui: Handle Ctrl + BS/Del in the commit msg
In-Reply-To: <20190506144122.GE4920@kiki>
Message-ID: <nycvar.QRO.7.76.6.1905272135280.28524@tvgsbejvaqbjf.bet>
References: <20190408125406.16703-1-ismael.luceno@silicon-gears.com> <20190506144122.GE4920@kiki>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EgUyESsBqjvCyiWKJubHwLwjN9TL6j0cvYYYHnMfbuZ8BK2PCJ7
 7aHuWN01/PkF/2pzAOCl2cNhYCjYXUmcfWcorplAES1or40DhEP3ODCeZVRyYhVlSTHJFEz
 pIHFv7dL9pPPzxqlk3HRRtui4xO7oPd/YG7cq33XPM9qv6bEAFousQf/c4mZw9mR5gfhQtn
 ovlaIJf0LGsl2TkRCiT9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rfS3JY6Rrk4=:lPKjL5Bf1AtKcqSHOZYZKA
 cPcCjxl8oZhuVrNz2MmzlD/lFHcBN8FxxORZvVpPOQbHl32SE8b1tDDvbloDtQb5nCddb7GsB
 WgqIvk6WBsNP6Wdnb6qN2AD1F/jzejKpwjmP/qZ2XeJKH4BM88qE1cjkAIkUDEnHRexJZlt5G
 N3AOGIkhVaAH0aHKVz+qoPbU4tDQW88u9FI4BWWZ4N5XZ8PxIPmt724v6s/FZeiB5LmZUfpFh
 ObUZFXwwuWheyTrJFAdU3G3+wYHcv/qaQe2ubku0Dm9FOP8/hu777GtMXh/yFMqNEBWoZw+Pi
 S+rAeClZyYGXkcYCJWe5Z9KLhdp8cOg2A4O4qosdbDZ/JN+yy6tQJBxb5vPKa+UxHpl/onIrs
 f3byv9iZwgcZlDtFdtwbYXau7A0Ber844yZY63tkcCXijnJJ0ohXDsn3KuJ9Qfp5LxeB8poTA
 39bGdcMRvaEgyS2Sr/1MV+/zFTrFPwCXceW0IJYrEHMBzEoMDwuVHqLzIBVwZbQDW7lVyXwbo
 enkJUPGCIlocQ2LqeKgIAzajxTMz4u7QEg5XV5z5Ata/TzQjFw0Otzv0LsTfIksPRCZj+MM0W
 0lYYrlC6ve81bLbTPV3nSp5K9zgFAHzbbjN+Cc/k3MXMzAp3luLfLPF8LHLD64bOpuja8jpuD
 bYnMnGNMzwOO03dodE/HQUpwFkFtbr/FkF4kCftiCFW0+7OXnT7mtTADLkmeXldqh81PBHtpG
 hVMQrg3qEZ5ybySLgpx9tjzOkrCMD25EiSwnj5TKhbsNRS7JlGvQCom7kVDeqTs1AHAzIBQce
 f9GN0RoW3KTMwRJfXFv3Tpv4bTJth9EQvxV/Y9y2y8uEU/5SP02DxFvGdbQuVkxQ1E+f8Ds8O
 7jnv13P6bQjuBBZnMPl4wFedpMEkEb/0KD9GztIf7W8PzPEWn6yEJlq3D3F73+q7ba2i+WYm6
 tr7e89Z/nHyqrkZ7HW3NqBIzJ9KIGoZB7Dyp5D2aUfF18cFqpX1rW
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 6 May 2019, Ismael Luceno wrote:

> On 08/Apr/2019 12:54, Ismael Luceno Cortes wrote:
> > - Control+BackSpace: Delete word to the left of the cursor.
> > - Control+Delete   : Delete word to the right of the cursor.
> >
> > Originally introduced by BRIEF and Turbo Vision between 1985 and 1992,
> > they were adopted by most CUA-Compliant UIs, including those of: OS/2,
> > Windows, Mac OS, Qt, GTK, Open/Libre Office, Gecko, and GNU Emacs.
> >
> > In both cases Tk already implements the functionality bound to other k=
ey
> > combination, so we use that.
> <...>
>
> Ping.

FWIW I am in favor of this patch. It is simple enough, and the commit
message does a good job explaining why it is a good idea to do it.

It's too bad that we do not have any active Git GUI maintainer... :-(

Ciao,
Johannes
