Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.8 required=3.0 tests=AWL,BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MIME_CHARSET_FARAWAY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62694207B3
	for <e@80x24.org>; Thu,  4 May 2017 07:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751622AbdEDH4p (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 03:56:45 -0400
Received: from m12-13.163.com ([220.181.12.13]:57928 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752619AbdEDH4n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 03:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=7E32n
        cj7AV+CWNver4xlHV9g+UevlbNSiD5Dm71hC1k=; b=ms4Kxhb4cE8zr6Ded8oJL
        /Jf+mErmoAxGnR57yS1TyHlgbN4xuK/5bXW/amC4zNBYhI9xdUgaodkW58HFRT6e
        ZKmHjCUT8O/SMm6fpJGJuga+bZPtWiFt3mDP57B46SZH3rc+Md+olv6Ur6I3gmn1
        ACt8KuC562FDvKxJf0rlOQ=
Received: from [192.168.30.179] (unknown [118.187.28.42])
        by smtp9 (Coremail) with SMTP id DcCowAD3ElWF3gpZ1aFVCQ--.28995S2;
        Thu, 04 May 2017 15:55:49 +0800 (CST)
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] send-email: new option to walkaround email server limits
From:   =?GB2312?B?1dTQoce/?= <zxq_yx_007@163.com>
X-Mailer: iPhone Mail (14E304)
In-Reply-To: <6bef306b-0bfb-2314-50fd-9c152888b344@redhat.com>
Date:   Thu, 4 May 2017 15:55:49 +0800
Cc:     git@vger.kernel.org, viktorin@rehivetech.com, mst@kernel.org,
        mina86@mina86.com, artagnon@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B2190B3-714D-4B22-857C-EBFC5F48A563@163.com>
References: <20170429122632.7122-1-zxq_yx_007@163.com> <6bef306b-0bfb-2314-50fd-9c152888b344@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-CM-TRANSID: DcCowAD3ElWF3gpZ1aFVCQ--.28995S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcPEfUUUUU
X-Originating-IP: [118.187.28.42]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/xtbB0gXNxlUMDwh5vwAAsE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



=D4=DA 2017=C4=EA5=D4=C22=C8=D5=A3=AC17:32=A3=ACPaolo Bonzini <pbonzini@redh=
at.com> =D0=B4=B5=C0=A3=BA

>> On 29/04/2017 14:26, xiaoqiang zhao wrote:
>> Some email server(e.g. smtp.163.com) limits a fixed number emails to be s=
end per
>> session(connection) and this will lead to a send faliure.
>> With --split <num> option, a auto reconnection will occur when number of s=
ended
>> email reaches <num> and the problem is solved.
>>=20
>> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
>=20
> I think you should also add a matching configuration option, or you are
> going to forget it on the command line sooner or later!
>=20
> Paolo

Good idea=A3=A1=


