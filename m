Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 644A51F453
	for <e@80x24.org>; Fri,  8 Feb 2019 10:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfBHKzz (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 05:55:55 -0500
Received: from mout.gmx.net ([212.227.15.18]:52567 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfBHKzz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 05:55:55 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVvB2-1gcaIN1fr6-00X69U; Fri, 08
 Feb 2019 11:55:39 +0100
Date:   Fri, 8 Feb 2019 11:55:37 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [Breakage] Git v2.21.0-rc0 - t5403 (NonStop)
In-Reply-To: <000d01d4bf9b$d5d48da0$817da8e0$@nexbridge.com>
Message-ID: <nycvar.QRO.7.76.6.1902081155000.41@tvgsbejvaqbjf.bet>
References: <000d01d4bf9b$d5d48da0$817da8e0$@nexbridge.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Kg6AFl9GdJTQGD7akNYDa4n8xFbwEZI9xPW3qqw42NLgyYHArF7
 tijI7Og3YFrXWzr0EZbCid7DteeJ7t/1skZ86Ozzk09RVcNg4A1ieUfZz4V1/fYjnXEYauy
 3L7I8gMMuWEC7N2aKnW+p7X15vVbtFHyxnz99voU8JIqEl0YNu1Xh19PVybWCO7zKsYY+Nm
 Y9CXYJ5v1E8TNxe45LQ4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1Ok+frzr8E0=:25Rd6Vgncd0LpxQepBTelB
 Zh1WreCTRwO2jwJ4vf7DzDb4fJGu2EPbbsGmoPVbjqC3J6y1zbrIVSd/WRR1Uyml5gDatca8i
 I6ixxr88YOgNSK0/UjizJ71VP3x1pYGjQOwJfUpdnoNqoiLTJgk4nlJkNzG0uI6YMrHYq/Oy1
 l/ob43U+y04j358sU8h/xdTuB5/eV4U2UWU43oMjsX/oBF4avLN/qILfwVpwrQftNzC8Zhi4U
 Fjp5kXVFfASfOvulv5fn5jH0xphF/DNl1Pzv1BLPGq1W5USga94WllVgpfaEi/y7rF/aFY6ZV
 uMwapEe0EGDv/rPvarYgpdI7WSausAfxQj1EvNrGAbB38h0fKGP/SIO8nJEUMfoeVoxjlUfD9
 ZwPHYgX6A2dnErXxCJuWyTL1QUPFR6/Hc0v/J72RiJNhRAzRedAoM0QNGvHv3RTIF8OC82nmw
 a4Aa+GM5I+in0PKtvOtsOljdwZ3cLPlciNvFhUZAwyjdioMX/N4M1YZy9yN4YRVB3NbpT7pi2
 SEOJN7Mbb3bsqxm8M14jN/OQbW29+BC3i2eORE/KpwUq7ior7WGPPYZN+IHOWCtjiQeV9ZjEt
 JX673mcYqgr4E4/iSla1QpyoA6OJXSvNW+TkbOKsfqtl3iGwopsQIbFwB6nHdXDokOgR64PGh
 7VvaTQXPXy/YNOMxnfmpljjhWnurdzmRhKzqDzpynsij5rrLnqUv6p7qog783iEyXhfxoaXJq
 puy/u2swVHVZfb2qql4PczUr51LugP9/aia+pP04YFtps8ec5BFlCeNhF7QZFU2uM9nvWfWCr
 ZvjIpT2VZLF9dh8V9MwCvym/cHmHba1muAHJLjYSP2GUXFKyv/IAD9s0ADFybbwERbfeKofeN
 cUYt2JcplBVIk10N43IIijZCfZPKVbTdkm5jXLAD6opg2vsA6/bJ8uXmdHjBcaeyb+pZRTYHp
 3eJkcGPQDng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

On Fri, 8 Feb 2019, Randall S. Becker wrote:

> This looks like it is a "bash thing" and $GIT_DIR might have to be in
> quotes, and is not be specific to the platform. If I replace 
> 
> echo "$@" >$GIT_DIR/post-checkout.args
> 
> with
> 
> echo "$@" >"$GIT_DIR/post-checkout.args"
> 
> The test passes. I wonder I should provide this patch or whether the
> author would like to do so.

It is the correct fix, you came up with it, why not simply provide a
patch yourself?

Thanks,
Dscho
