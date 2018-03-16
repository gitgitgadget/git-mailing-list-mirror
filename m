Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A2BE1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 14:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbeCPOa0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 10:30:26 -0400
Received: from fallback6.mail.ru ([94.100.181.147]:53412 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751576AbeCPOaF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 10:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=05xzw5uNam0uha8PAnkJ8DF3oyyyzGRLbhIr7K6QYBY=;
        b=RMhsnvgunAxKJhfcldINsFzJyyfu0VuM4PoSdgMRTvfbK4wTyOwZpy0NW+aiL4jhBw5a3OzD0Pml8pdUn/8YpHfRQgHD5Oi59hHqHizcpeKaEbYtzHuUmhXM/L1frZltzeppDjtwPw8eGvO+XaVkvtQA45fr7QDB95NObLJNHU8=;
Received: from [10.161.64.44] (port=53888 helo=smtp36.i.mail.ru)
        by fallback6.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
        id 1ewqMs-0001j0-Sk
        for git@vger.kernel.org; Fri, 16 Mar 2018 17:30:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=05xzw5uNam0uha8PAnkJ8DF3oyyyzGRLbhIr7K6QYBY=;
        b=RMhsnvgunAxKJhfcldINsFzJyyfu0VuM4PoSdgMRTvfbK4wTyOwZpy0NW+aiL4jhBw5a3OzD0Pml8pdUn/8YpHfRQgHD5Oi59hHqHizcpeKaEbYtzHuUmhXM/L1frZltzeppDjtwPw8eGvO+XaVkvtQA45fr7QDB95NObLJNHU8=;
Received: by smtp36.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1ewqMq-0005Sc-Qz; Fri, 16 Mar 2018 17:30:01 +0300
Date:   Fri, 16 Mar 2018 17:29:59 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     JYOTIK MAYUR <jyotikmayur7@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Help...!
Message-ID: <20180316142959.gsuxmwobqgnu4l3u@tigra>
References: <CAHotnZWvtfKxmJii9g3K2OHBEBkh-AiRSXbc7tfZiyNGuXk6jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHotnZWvtfKxmJii9g3K2OHBEBkh-AiRSXbc7tfZiyNGuXk6jA@mail.gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
X-7FA49CB5: 0D63561A33F958A5377F8FF4AFCFE81153FDDD2845A81FADA88E226A7A726124725E5C173C3A84C332C16DEEF88469492D41F2BB729FF4F30555CCFDA08FA3FAC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA43FE94EDA2273E6948C3AA81C4D5D4B97BAC7ED26ADC47234FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 07:38:07PM +0530, JYOTIK MAYUR wrote:

> i am working on a project that is git hosting website like GitHub. I
> am a student so i don't know much on how to make a website like GitHub
> so could please tell me what can be the appropriate steps to make a
> website like that(mostly the server part).

Sure, just study the code of the following projects:

- Go: https://gitea.io/
- C#: https://bonobogitserver.com/
- Java: http://gitblit.com/

Still, please note that this list deals with the development of Git,
so your question clearly is off-topic here, so please refrain from
asking such questions here.

You could try https://www.reddit.com/r/git/ for a start.

