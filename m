Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A14C91F462
	for <e@80x24.org>; Mon, 17 Jun 2019 19:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfFQTFP (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 15:05:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:38275 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfFQTFP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 15:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560798296;
        bh=mZjF1uufxOoFeGlIFi20WxCkVvmWv5xjtKbIRg+G1cE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hA1uLAHaL4R/Il+N1ya/h7iHjEfDY/fT0faD0abgswWcTJuzuzRCJcoMLMCBmf6ov
         kOOwTU5mmaI1FrkPCgRGdj0iImkIV56heaB1VuimDGaxJvcHELX7IrfEhZjH16sIJU
         3ZCIjXDww5pei1WEZvzxWHpz6/FZwsAS0qCMJsr0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7CRe-1iWIyH3gkY-00wzVi; Mon, 17
 Jun 2019 21:04:56 +0200
Date:   Mon, 17 Jun 2019 21:05:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] t: add helper to convert object IDs to paths
In-Reply-To: <20190616185330.549436-2-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1906172102180.44@tvgsbejvaqbjf.bet>
References: <20190616185330.549436-1-sandals@crustytoothpaste.net> <20190616185330.549436-2-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YG91weJW+3/SMw28tlOSmdzQe523CI6RALpjqEMXCoKNbzMdKGl
 r5uBPIaywnaXeBEBC5L9JNxLA4qADkNAoYAZy1RFW6f/8Nm2TDkziden+ZWtGf2d+/CYom8
 yPWL+GPH2VaRX4BpbVtuuA7gnhL590tQj7fNfNOlxSbKwEr0my1Ps2+qUGWQrLGcLzop8ij
 1Fcg7p/XyDTuNFfFnETvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GxfyM8CWPOg=:RbUHvkJonNBSWovGX+oS6n
 +5gqNJE484uqjtvsUl1aph6EwLrw4ZS1XiVAm1Hn0a89dfd0QiMcrpyEWwsyxEKibrL89GKis
 9jGhtteXMtgUgPhogVCBmh0Re7Y0lOf1z3Snj0nN80xfhI2GbCVazYexBiwoJ3PDBSypEltJS
 XaoTs3nvwoNT7ojBdnQLs+ehF/uMh5N/yoBi/I1cwTSsbaz4Lg4HKte9dbRWFq+vffxeo+lW7
 bPZLaKJiEnpVdTB5LfcMB9m0liYOI47AQ4157O+q26icaRpJAXgAne8WcR5f6CUD+idJyOrWQ
 CJLfA6iq6g8vtblTWdtfaPXSfQmJr0Ro4xP9Eei49uacC5LStGix20UbuCfug71HPOW7gcn2u
 s5CWkQWly9+4nTjs285g4eDWcpaAyR59BRV3EMUUYk5hTGVuNmmKunfwxqdyUoskcHsHfT3nZ
 40wKUSEoctJmMLUz7nwM8vVX9dZpBlScSmp6s3tlCW7KyfUD5eW/0adj6ISA4OM6DkQN5ufrt
 BxPrv5Ab+uGEsVSI/KFqf8z4R3f+nabR2NFfykOdEzq4Ga+RfixFGsWiQk0uEzeZV3mVaHN5V
 myWwMoqa6JK1WyChu3+Mb3+4A9A1WHDnZmxah1DF7DQcoKp8LBKx1g2VN0sv7FRuv9ozNUZda
 VCxxhwA7On7c5uC24X1xwjr5GnH7awZ2NVAMdjCVi8fBW98Zrhg1pKAgEYzSM9l3ptLVqv8zp
 Z5Is9xE6JGtfByr0GVXyB8OhWzGBNkAg+o0Q/tfB+8CCcx7jk/5zxK97TQy6lirxU9lsKFN6V
 iwyxvovwgDLsvQRkowWaIsnrvhX6Zg+pv4euE3M8YqjT5p8aSF1oIU9nLF8Am5psvNP6c41xT
 35agrV60nJBwuTXDCJPQeZqZtI0RiWr++I6gHPJ7m/QEdq9DxUvo7D15Th8OxB36wRfoYDUz0
 TbGKV2GH7wZfDu68lY+Ga31IxQ0Ur0V9bMlwu8+n4q4VvPbWWNzNv
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Sun, 16 Jun 2019, brian m. carlson wrote:

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 8270de74be..11a6abca2e 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1314,6 +1314,12 @@ test_oid () {
>  	eval "printf '%s' \"\${$var}\""
>  }
>
> +# Insert a slash into an object ID so it can be used to reference a loc=
ation
> +# under ".git/objects".  For example, "deadbeef..." becomes "de/adbeef.=
.".
> +test_oid_to_path () {
> +	echo "$1" | sed -e 's!^..!&/!'
> +}

I guess it does not *really* matter all that much, but this does spawn a
new process (and I think it actually spawns 4 on Windows, for reasons, and
spawning processes is super expensive on Windows).

We might actually want to think about using something like this instead
(which admittedly looks a bit like gobbledygook to the uninitiated, but it
definitely avoids any spawned process):

test_oid_to_path () {
	echo "${1%${1#??}}/${1#??}"
}

Ciao,
Dscho
