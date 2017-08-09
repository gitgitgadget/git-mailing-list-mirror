Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C236208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 22:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbdHIWQr (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 18:16:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:51673 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752174AbdHIWQq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 18:16:46 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbdiB-1dC28f0aTL-00lFuj; Thu, 10
 Aug 2017 00:16:26 +0200
Date:   Thu, 10 Aug 2017 00:16:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Martin Koegler <martin.koegler@chello.at>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] Convert size datatype to size_t
In-Reply-To: <1502222450-20815-1-git-send-email-martin@mail.zuhause>
Message-ID: <alpine.DEB.2.21.1.1708100015460.11175@virtualbox>
References: <1502222450-20815-1-git-send-email-martin@mail.zuhause>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rHYlevnBF3NiKEDH2LY1lgHVI2lBi9iRd+5C3rrVk/Q2bDPSV5S
 FXDvHCkTZ7D5v4AjH7f5xsvXCItCHT4OmfukhavMuB9BrrBToGwW9tN3grBD0Qhr1u4JTQS
 RRxPqhFhwZiQU0aBUlc2EGy9NNrobgOX2HHWer+llRbbFrM5qY71Z+bUYUVhXS3mTDqFZPK
 fyFrcNslnh5xyavkbvuBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5xH3kzaY7zo=:W5zDocpjqc6xildr1vRaQ6
 6VToUfFBFpqC6/PsfPVxLyR1rfhOy3mqu5+QAuEKXBpqQ/M6l2MUiDqwMkzUV7JrOmYJZ6UpW
 52x0zAnfQN1mxrABf8M+I0hQiTcl+7TwGu32LRGyvyDzjl2VBMzsqxcHARgwnDOMXAxtga1T1
 2nslfzAr5DYCyVKU2AQw2sbTRZvVMYmwH0q5luJ1wUwS6SfGlk2AuUoFSRlXQLt3xILhaO2r8
 y0WBiI4++vgBjI1dYw7+H0Ga/MKt/q634xIZzmRGfSzB/cEX1TAqb9Lpv3rSP32I4ytJH7/2D
 Tjq2pApnc1mNys4kdwctDR3JgnyEqUjUxcvQTPFq+09cTtufDA+H0R2XuyMvXrCm4ULUneM9w
 f8I+60zgydm6w9Hiekm2Ke9KSKyVkqrCl6kLxgVaEdN2wjoce90Tyq8WLSY2xQ4Ud9WJIKoYQ
 Tc1occXdPDONyUlqIlLv/35HEYhbstdN9bYJevCNZZikBLtSLNUQR/kT/juvl7LH3dgwrpwE5
 V+SNsK38B/JVCYEMGpUZi1JPmb5i1+gkSg0n/zJniJ0H1asy4M3d88+PllVaXTGb6B7pkdvcs
 Ft/AOQVlCcDwd5Ds1ymxUfTEb89t2iHOGwvywoBFpDMgmS9Bldyj/4zPnsgqmDOH9GacizBoM
 M12PrJQxlbNX6eU7M7t/76bsM8kARhLVmJNkSpYtHB3mWdzOz/ZgXqJ4EH2MtMkjBBEdIm7DV
 fG1G0kSnH0UPNQEMQwYasffxBh1h+yTc0EVht8ENudcRGbX2x1lV7PZr6rJAngjTKXvweYJY6
 oo4VLRDCYW6Nea7Xw9gXGAqm18pkhhe1VFQov3OoXinhLtxI4w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

On Tue, 8 Aug 2017, Martin Koegler wrote:

> From: Martin Koegler <martin.koegler@chello.at>
> 
> It changes the signature of the core object access function
> including any other functions to assure a clean compile if
> sizeof(size_t) != sizeof(unsigned long).
> 
> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> ---

Thank you for working on this!

Much appreciated,
Dscho
