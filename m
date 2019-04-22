Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A9A820374
	for <e@80x24.org>; Mon, 22 Apr 2019 00:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfDVA53 (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 20:57:29 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42437 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbfDVA53 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 21 Apr 2019 20:57:29 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 995C621C48;
        Sun, 21 Apr 2019 20:57:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 21 Apr 2019 20:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=X1+zQ5fTPX34mE57lhJcYXjiFB+NYx/+tBLq44T2e
        +Y=; b=yFYPLpCF3hz+iG4WsTmEKu9hZrNE9ijufl3ouCQ3A6+s3COuhR1JfBkhI
        pT9Dr0a6RIj/MnMBdCzRuqnKh4fQoJB3ZUpaJ+50ovEy05p7sEH79o/Jr2DUw733
        HpJtN8pcUMDaijif9iqspUsfalC5oGryZx5nWlF3VjcyFByFEmixuyC0aL2J2LT5
        HMtolhRByC7ph6gbLzVSb/n2hgUj+Nqu7HaMF0sxUF5MaRzzIJGlnTgBJg7qqxhl
        EHKQ0SUGh5yiV4O+dD6Fd6BAQcxdTw86B1s7xNkzXAeYKNhUMd0BtCSP1cTNontm
        sLwGWJxcTrbN6aR8xlR+u02d9Tdrg==
X-ME-Sender: <xms:eBG9XCpqd3pCuMs7Gqc3eploO9fYZ1LkggUa0Gt9q3JELDQUjXo-pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrgeehgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesthekre
    dttdefjeenucfhrhhomheptehnughrvgifucflrghnkhgvuceofhhlohhsshesrghpjhgr
    nhhkvgdrnhgvtheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpmhgrrhgtrdhinh
    hfohdpghhnuhdrohhrghenucfkphepieejrddvgeehrddvvdeirdeffeenucfrrghrrghm
    pehmrghilhhfrhhomhepfhhlohhsshesrghpjhgrnhhkvgdrnhgvthenucevlhhushhtvg
    hrufhiiigvpedt
X-ME-Proxy: <xmx:eBG9XAxxg8NGI6B0G3s13LJWt2S6pUqK8bweM6M3osFevHELDQ6ldw>
    <xmx:eBG9XPLzamOMETi5DlCVJxxfKlLQ0jjUAs8Xjhg5166j-2OpPbnt5w>
    <xmx:eBG9XKIK_I3xnGympZsXjmqwd6qYkGOmlxFAN2j7U75nFfGazbEi5Q>
    <xmx:eBG9XMZXCsTD6RIjLs7f-WQpZz3u9gXk23BJDlQlQlACT1jk6thcmw>
Received: from angharad.local (cpe-67-245-226-33.nyc.res.rr.com [67.245.226.33])
        by mail.messagingengine.com (Postfix) with ESMTPA id E630CE479F;
        Sun, 21 Apr 2019 20:57:27 -0400 (EDT)
Subject: Re: gettext, multiple Preferred languages, and English
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <d001a2b5-57c3-1eb3-70fd-679919bb2eb6@apjanke.net>
 <CACsJy8C1w0zJm71KFb21MC+c2NAGnRLDtE3KNK21hO7U4Ax7Hg@mail.gmail.com>
From:   Andrew Janke <floss@apjanke.net>
Openpgp: preference=signencrypt
Autocrypt: addr=floss@apjanke.net; prefer-encrypt=mutual;
 keydata= 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
Message-ID: <9d7a2fb4-8bab-2d28-1066-fbace688a5cc@apjanke.net>
Date:   Sun, 21 Apr 2019 20:57:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8C1w0zJm71KFb21MC+c2NAGnRLDtE3KNK21hO7U4Ax7Hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/21/19 8:35 PM, Duy Nguyen wrote:
> On Sun, Apr 21, 2019 at 6:40 PM Andrew Janke <floss@apjanke.net> wrote:
>>
>> Hi, Git folks,
>>
>> This is a follow-up to https://marc.info/?l=git&m=154757938429747&w=2.
> 
> This says the problem with "en" detection has been fixed. Would
> upgrading gettext fix it?
> 
> You would need to upgrade something (git or gettext) and if it's
> already fixed in gettext I don't see why we need a workaround in git.

From reading the bug report, that does sound like it would fix it. But
from what I can see, that fix hasn't made it out into a released version
of gettext yet. I haven't downloaded the development gettext to confirm
the fix.

Looking at the gettext ftp site at https://ftp.gnu.org/pub/gnu/gettext/,
it looks like gettext does not make frequent releases, and the last
release was two and a half years ago. Who knows when the next release
will be. And then it'll take longer to trickle down into Linux
distributions and such.

From your release history at https://github.com/git/git/releases, it
seems like Git is a lot more active in making releases than gettext. So
including this fix in Git would get it into the hands of affected users
sooner. And it seems like a pretty low-risk change to me.

Then once the new gettext release is out, their fix is confirmed, and it
makes it out into common distros, the workaround could be removed from Git.

Cheers,
Andrew
