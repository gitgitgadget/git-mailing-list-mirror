Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA891C433F5
	for <git@archiver.kernel.org>; Wed, 11 May 2022 08:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243556AbiEKIWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 04:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243548AbiEKIV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 04:21:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CF6140FE
        for <git@vger.kernel.org>; Wed, 11 May 2022 01:21:52 -0700 (PDT)
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
        id 4Kynv04KQnz4ySb; Wed, 11 May 2022 18:21:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
        s=201707; t=1652257308;
        bh=fHw2E+8XMnTbmj4Qoqm9nINHo3i+Cos8u5n17gysTeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M2lywZPyPJnLKOsRWeCD/WDGlddujPANogdxLdKGiOUAQyqToth6JzrjCnjxmlBuj
         nM9O4HadbgQb1o+yWrGkA8q8crTlNpIj5LMEme14FSOD+Ua1AkBhZ07P6kOLDzgDU6
         QJU5nmpkmX8f57Yqf5cihERjaxNx9uhHeViSrTWOtZNLLX2bwyI3YVcCiKo4Ru4nBR
         pklKqiy88nVgOCavNpxIQpH0x8FYUqwd0d8K1OmsZtNzBVGA77MOaOYPyqQ/eiW5Ri
         w6qgT9WEuEouX2ECZCPEuDXBysThyoncr2fvcCuX+TS0dBx2lR3jkUjnr4rFORYn8U
         cfBZ/Es5ad4jg==
Date:   Wed, 11 May 2022 18:21:43 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Halil SEN <halilsen@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthias =?iso-8859-1?Q?A=DFhauer?= <mha1993@live.de>,
        Christian =?iso-8859-1?Q?Gr=FCn?= <christian.gruen@gmail.com>,
        git@vger.kernel.org,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: Resizing panels in the gitk window
Message-ID: <YntyF+dHp2WEpI8v@cleo>
References: <CAP94bnOyrx6hCmWSjmejVfopUydk10ga42wJzm1M4nk_OXn9Mg@mail.gmail.com>
 <CAP94bnMHggYR=FOh8462tncFAxOUJ-db=yj7YPoTJRS-VwjEgw@mail.gmail.com>
 <AM0PR04MB6019000A6C54CF97447E7B6EA5C59@AM0PR04MB6019.eurprd04.prod.outlook.com>
 <xmqqzgjuocjk.fsf@gitster.g>
 <CAOeUTuufDgsyp7FgJj4T+h=JOMaWYVBkMx8S6fNRQ3cdVo6tOw@mail.gmail.com>
 <xmqqtu9yd42d.fsf@gitster.g>
 <CAOeUTusOW1=cDKNhrBCzdzfbVLmY_qb7yg114ukRfy904S34uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOeUTusOW1=cDKNhrBCzdzfbVLmY_qb7yg114ukRfy904S34uA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 09, 2022 at 10:19:21PM +0200, Halil SEN wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > It seems to be related to the topic you are working on?
> 
> It indeed is related. Sorry for troubling you with the repo, I don't
> remember exactly how I failed before, thanks for sharing it.
> 
> > Again, I wonder if Paul's been too busy for (or no longer interested
> > in) maintaining it and perhaps he can use a replacement maintainer?
> 
> I guess I should rebase my patch and resubmit it nevertheless.
> I'll do it within the next few days. Now that I thought about it,
> I think I had trouble creating and e-mailing the patch to the mail
> list and the gitgitgadget was available only for the main repo.
> I shall ask for help if I fail to do so again.

No need to rebase, I have manually applied your patches.

Junio, could you do a pull from my repository to get them?

Thanks,
Paul.
