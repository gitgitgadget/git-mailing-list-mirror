Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DFBC433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 19:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353910AbiBCT7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 14:59:14 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:54094 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231187AbiBCT7N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 14:59:13 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        (Authenticated sender: jn.avila@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 4E1B019F4C8;
        Thu,  3 Feb 2022 20:59:09 +0100 (CET)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <avila.jn@gmail.com>
To:     rsbecker@nexbridge.com, Junio C Hamano <gitster@pobox.com>
Cc:     =?ISO-8859-1?Q?=27=C6var_Arnfj=F6r=F0?= Bjarmason' 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [Question] Translation Dictionary
Date:   Thu, 03 Feb 2022 20:59:08 +0100
Message-ID: <11498572.Kui42GGras@cayenne>
In-Reply-To: <xmqqwnibvmtf.fsf@gitster.g>
References: <016401d81547$728834e0$57989ea0$@nexbridge.com> <02f101d81901$c1ac8400$45058c00$@nexbridge.com> <xmqqwnibvmtf.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, 3 February 2022 19:15:24 CET Junio C Hamano wrote:
> <rsbecker@nexbridge.com> writes:
> 
> > I would even suggest that gitglossary(7) might ultimately be
> > deprecated particularly on systems without 'man(1)'.
> 

I'd rather gitglossary and `git glossary` did not compete and they could share 
their translations.


> Yes, I think the entries in the "git help -w glossay" are good
> things to have in the dictionary.  I thought there are folks who are
> already translating our manual pages (perhaps with po4a if I recall
> correctly but I may be misremembering)?
> 
> Thanks.
> 

Yes, there are. You can find the project at 
https://github.com/jnavila/git-manpages-l10n

The Portuguese is fully translated, gitglossary included.

This makes me think that translating gitglossary should come first, in order to 
set the standard for the other manpages.



