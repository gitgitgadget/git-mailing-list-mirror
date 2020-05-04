Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDC3C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 20:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F00206A5
	for <git@archiver.kernel.org>; Mon,  4 May 2020 20:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgEDUmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 16:42:01 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:59357 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgEDUmA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 16:42:00 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49GFCB4zTYz1qsb5;
        Mon,  4 May 2020 22:41:58 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49GFCB4HlCz1qqlD;
        Mon,  4 May 2020 22:41:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id RGgyfHEZzA2l; Mon,  4 May 2020 22:41:57 +0200 (CEST)
X-Auth-Info: hM9peFQA8ztNoR6thnymKJCU/oF+bPRNUvKhOgJ+WC6UrvEaMb6Jk7v9iavtGtEw
Received: from igel.home (ppp-46-244-166-96.dynamic.mnet-online.de [46.244.166.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  4 May 2020 22:41:57 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id E57A62C0B3F; Mon,  4 May 2020 22:41:56 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Ewa =?utf-8?B?xZpsaXdpxYRza2E=?= <kreska07@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        git@vger.kernel.org
Subject: Re: file is showing as modified even that it was never commited
References: <CAEoQP9iY-0+=ETA0vrHL0HngccwtNA_3KX4WSSokJpOgJDGUeA@mail.gmail.com>
        <20200504055530.GA13290@konoha>
        <CAEoQP9hyMi=oj18atTJo+dR3ve_zzrLQoOja0CKAAVHei6rA0g@mail.gmail.com>
        <20200504120024.GA3372@konoha>
        <CAEoQP9gs-a1NanNpYiFQgTs0C+CeYhbD8rMjoFVat1ZSijNA2A@mail.gmail.com>
        <874ksvei1r.fsf@osv.gnss.ru>
        <CAEoQP9guAWg8E95Pi4MOih7z5rPg7OCB+_jZ6EMhJxpFsM3A1A@mail.gmail.com>
X-Yow:  Today, THREE WINOS from DETROIT sold me a framed photo of
 TAB HUNTER before his MAKEOVER!
Date:   Mon, 04 May 2020 22:41:56 +0200
In-Reply-To: <CAEoQP9guAWg8E95Pi4MOih7z5rPg7OCB+_jZ6EMhJxpFsM3A1A@mail.gmail.com>
        ("Ewa =?utf-8?B?xZpsaXdpxYRza2EiJ3M=?= message of "Mon, 4 May 2020 20:39:10
 +0200")
Message-ID: <871rnz4eln.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mai 04 2020, Ewa Śliwińska wrote:

> Changes to be committed:
>
>   (use "git reset HEAD <file>..." to unstage)
>
>
> new file:   .idea/.gitignore
>
> new file:   .idea/compiler.xml
>
> new file:   .idea/encodings.xml
>
> new file:   .idea/jarRepositories.xml
>
> new file:   .idea/libraries/Maven__commons_codec_commons_codec_1_11.xml
>
> new file:   .idea/libraries/Maven__commons_io_commons_io_2_6.xml
>
> new file:   .idea/libraries/Maven__commons_logging_commons_logging_1_2.xml
>
> new file:   .idea/libraries/Maven__commons_net_commons_net_3_6.xml
>
> new file:   .idea/libraries/Maven__net_sourceforge_htmlunit_htmlunit_2_39_1.xml
>
> new file:   .idea/libraries/Maven__net_sourceforge_htmlunit_htmlunit_core_js_2_39_0.xml
>
> new file:   .idea/libraries/Maven__net_sourceforge_htmlunit_htmlunit_cssparser_1_5_0.xml
>
> new file:   .idea/libraries/Maven__net_sourceforge_htmlunit_neko_htmlunit_2_39_0.xml
>
> new file:   .idea/libraries/Maven__org_apache_commons_commons_lang3_3_10.xml
>
> new file:   .idea/libraries/Maven__org_apache_commons_commons_text_1_8.xml
>
> new file:   .idea/libraries/Maven__org_apache_httpcomponents_httpclient_4_5_12.xml
>
> new file:   .idea/libraries/Maven__org_apache_httpcomponents_httpcore_4_4_13.xml
>
> new file:   .idea/libraries/Maven__org_apache_httpcomponents_httpmime_4_5_12.xml
>
> new file:   .idea/libraries/Maven__org_brotli_dec_0_1_2.xml
>
> new file:   .idea/libraries/Maven__org_eclipse_jetty_jetty_client_9_4_27_v20200227.xml
>
> new file:   .idea/libraries/Maven__org_eclipse_jetty_jetty_http_9_4_27_v20200227.xml
>
> new file:   .idea/libraries/Maven__org_eclipse_jetty_jetty_io_9_4_27_v20200227.xml
>
> new file:   .idea/libraries/Maven__org_eclipse_jetty_jetty_util_9_4_27_v20200227.xml
>
> new file:   .idea/libraries/Maven__org_eclipse_jetty_jetty_xml_9_4_27_v20200227.xml
>
> new file:   .idea/libraries/Maven__org_eclipse_jetty_websocket_websocket_api_9_4_27_v20200227.xml
>
> new file:   .idea/libraries/Maven__org_eclipse_jetty_websocket_websocket_client_9_4_27_v20200227.xml
>
> new file:   .idea/libraries/Maven__org_eclipse_jetty_websocket_websocket_common_9_4_27_v20200227.xml
>
> new file:   .idea/libraries/Maven__xalan_serializer_2_7_2.xml
>
> new file:   .idea/libraries/Maven__xalan_xalan_2_7_2.xml
>
> new file:   .idea/libraries/Maven__xerces_xercesImpl_2_12_0.xml
>
> new file:   .idea/libraries/Maven__xml_apis_xml_apis_1_4_01.xml
>
> new file:   .idea/misc.xml
>
> new file:   .idea/modules.xml
>
> new file:   .idea/sonarlint/issuestore/2/2/22a598feccb13c958ecc8eff5c53a9a7f9470a72
>
> new file:   .idea/sonarlint/issuestore/4/4/442292b8a7efeabbe4cc176709b833b1792140ec
>
> new file:   .idea/sonarlint/issuestore/c/0/c02b58f69e810278d2d423bdee557628145ed943
>
> new file:   .idea/sonarlint/issuestore/f/b/fb31951790c271e26d568f9ac5b7681e7f0804ec
>
> new file:   .idea/sonarlint/issuestore/index.pb
>
> new file:   .idea/vcs.xml

That means you have explicitly staged all these files with git add.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
