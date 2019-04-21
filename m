Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF9D120248
	for <e@80x24.org>; Sun, 21 Apr 2019 13:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfDUN11 (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 09:27:27 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36039 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725963AbfDUN11 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 21 Apr 2019 09:27:27 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 525CC20A3C;
        Sun, 21 Apr 2019 09:27:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 21 Apr 2019 09:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=qLI/OSrYkXBsPj4AXtn0hOwMpF3nIH89IAitiMb+r
        bg=; b=zU7NS6xAiKz2CIPu9JsVMP9ZefUpefvH2HeOW+bRE0xHFch5hjhqn3erT
        rb5yp5Joh72YtdkeTXoRawCy4Lb0iinzjHisNamOmOaaLY/IFtZ+wqLH1ohq9Cm1
        D8UkGTsLskjm8aXpzQ/IBwWrTJsGCvyA6oDjBRjvlKYA+aGNC94I2GAwpm/t3U6V
        nPsIbSDkkvOs1b5zk8sPhZBiEl4a7sY9h86alMgE3/zvxPFEgwH5HRh52dRcd7Tp
        G8NpIby077Himo3e6EAnzfQw5EQy2gysISqrODi9nACKM4aR4wJCfLH2veK1JU9m
        54o52KNmAk/Bu3Y9IQwd0+HvotAtA==
X-ME-Sender: <xms:vW-8XGxyuFPJRPtnKLV-wdaFdHdrQYt-NVwqcPL6f9mCBSJSyZoBgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrgeeggdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeetnhgurhgv
    ficulfgrnhhkvgcuoehflhhoshhssegrphhjrghnkhgvrdhnvghtqeenucffohhmrghinh
    epghhithhhuhgsrdgtohhmpdhpuhgslhhitgdqihhnsghogidrohhrghenucfkphepieej
    rddvgeehrddvvdeirdeffeenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesrg
    hpjhgrnhhkvgdrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:vW-8XJSAFOM8uRjeuCYzT3rZpecqkdK6RxXtw-cki8Ljj8ObQHKH-A>
    <xmx:vW-8XNXEmWmAg1jUV0unk9mFioLp_ZdKf3CCi5pmNr9YtPm5hH_ohw>
    <xmx:vW-8XLY6zCAL7nzjijBgO2l-IJCXd8ssWHIYH7vz_h3KfcQpbvZFkQ>
    <xmx:vm-8XCQqflOgoKfTXRs1cPjlsfMyAjjM-K_S6g_j9sLuECgMxDoEKw>
Received: from angharad.local (cpe-67-245-226-33.nyc.res.rr.com [67.245.226.33])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8B146E432B;
        Sun, 21 Apr 2019 09:27:25 -0400 (EDT)
Subject: Re: gettext, multiple Preferred languages, and English
To:     Philip Oakley <philipoakley@talktalk.net>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>
References: <d001a2b5-57c3-1eb3-70fd-679919bb2eb6@apjanke.net>
 <bd5ee770-a213-b663-208c-c9980a738fe9@talktalk.net>
From:   Andrew Janke <floss@apjanke.net>
Openpgp: preference=signencrypt
Autocrypt: addr=floss@apjanke.net; prefer-encrypt=mutual;
 keydata= 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
Message-ID: <ffac5d4b-190c-16d6-497c-4b0f1f12115c@apjanke.net>
Date:   Sun, 21 Apr 2019 09:27:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bd5ee770-a213-b663-208c-c9980a738fe9@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 4/21/19 8:59 AM, Philip Oakley wrote:
> Hi Andrew,
> 
> On 21/04/2019 12:08, Andrew Janke wrote:
> https://public-inbox.org/git/d001a2b5-57c3-1eb3-70fd-679919bb2eb6@apjanke.net/
> 
>> I don't think it would even have
>> to be actively maintained, because for new message strings that aren't
>> included in the .po file, it would fall back to the non-translated input
>> strings, which are in English anyway, which is the desired behavior.
> Given the above comment, could the en.po file
> (https://github.com/apjanke/git/blob/english-dummy-translation/po/en.po)
> be some very very short version with only one 'translated' string?

Yes, I believe so. I only provided a full translation file because it
was trivial for me to create using the "msginit" instructions I found in
po/README. Since all the translations are just identity relationships, I
believe that is effectively the same as their not being there in the
first place.

I tested your approach locally, and it seems to work for me.

> This
> may be a way-off comment, but if it could be such a simple maintenance
> free file then that sounds sensible.
> 
> also adding in Jiang Xin <worldhello.net@gmail.com>, the coordinator for
> extra comment.
> 
> Philip
