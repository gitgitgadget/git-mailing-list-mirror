Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D71C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 23:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356051AbiBCXpW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 3 Feb 2022 18:45:22 -0500
Received: from elephants.elehost.com ([216.66.27.132]:55630 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbiBCXpV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 18:45:21 -0500
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 213NjIhT074950
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Feb 2022 18:45:18 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "=?UTF-8?Q?'Jean-No=C3=ABl_AVILA'?=" <avila.jn@gmail.com>
Cc:     "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, <git@vger.kernel.org>
References: <016401d81547$728834e0$57989ea0$@nexbridge.com>        <02f101d81901$c1ac8400$45058c00$@nexbridge.com>        <xmqqwnibvmtf.fsf@gitster.g> <11498572.Kui42GGras@cayenne> <xmqq1r0jskhr.fsf@gitster.g>
In-Reply-To: <xmqq1r0jskhr.fsf@gitster.g>
Subject: RE: [Question] Translation Dictionary
Date:   Thu, 3 Feb 2022 18:45:13 -0500
Organization: Nexbridge Inc.
Message-ID: <032501d81958$19f67bb0$4de37310$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHny4N9HGuOldLgj1yDpZlahXxp4QKGIb1VAWtCCwUCxbIKfQIR2SK8rBzRifA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 3, 2022 4:34 PM, Junio C Hamano wrote:
> Jean-Noël AVILA <avila.jn@gmail.com> writes:
> 
> > On Thursday, 3 February 2022 19:15:24 CET Junio C Hamano wrote:
> >> <rsbecker@nexbridge.com> writes:
> >>
> >> > I would even suggest that gitglossary(7) might ultimately be
> >> > deprecated particularly on systems without 'man(1)'.
> >>
> >
> > I'd rather gitglossary and `git glossary` did not compete and they
> > could share their translations.
> >
> >
> >> Yes, I think the entries in the "git help -w glossay" are good things
> >> to have in the dictionary.  I thought there are folks who are already
> >> translating our manual pages (perhaps with po4a if I recall correctly
> >> but I may be misremembering)?
> >>
> >> Thanks.
> >>
> >
> > Yes, there are. You can find the project at
> > https://github.com/jnavila/git-manpages-l10n
> >
> > The Portuguese is fully translated, gitglossary included.
> >
> > This makes me think that translating gitglossary should come first, in
> > order to set the standard for the other manpages.
> 
> Yup, and if we can come up with a way to mechanically share the list of items (i.e.
> what to include and not include in the glossary) and their translations between
> "git glossary" and "git help glossary", that would be great.

I thin that should be part of my goal, yes.
-Randall

