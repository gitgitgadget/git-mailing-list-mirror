Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718CDC4321E
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 23:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5666161100
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 23:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhJ1X1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 19:27:43 -0400
Received: from elephants.elehost.com ([216.66.27.132]:15145 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhJ1X1m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 19:27:42 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 19SNPArF023214
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 28 Oct 2021 19:25:11 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Nicholas Bransby-Williams'" <nbransby@gmail.com>
Cc:     <git@vger.kernel.org>
References: <CAGyLXMBWyfcBVFDRbYJMk+-RjjNBQDvoDeaBtEPiXpUDDTqfOA@mail.gmail.com>        <xmqq5ytgrkku.fsf@gitster.g>        <CAGyLXMA93qQw_h97bMd14O26hSxn4xn+AzemVyrf6pn53qO3UQ@mail.gmail.com>        <xmqqilxgpywf.fsf@gitster.g>        <CAGyLXMBe2qj8mT+gA2skQr=+bteV9E0nKZ=u-5akCQtTU7AfKA@mail.gmail.com> <xmqqilxgoicq.fsf@gitster.g>
In-Reply-To: <xmqqilxgoicq.fsf@gitster.g>
Subject: RE: conflict markers in markdown files
Date:   Thu, 28 Oct 2021 19:25:04 -0400
Organization: Nexbridge Inc.
Message-ID: <00c601d7cc53$0ce58800$26b09800$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIAwvb8js3HpWn2JDqANqW34Y4VlgKNTEK2AUZyaBEB/caDwQJt+8AOAh7dSD6rRCx6AA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Junio C Hamano <gitster@pobox.com>
On October 28, 2021 7:11 PM, 
> To: Nicholas Bransby-Williams <nbransby@gmail.com>
> Cc: git@vger.kernel.org
> Subject: Re: conflict markers in markdown files
> 
> Nicholas Bransby-Williams <nbransby@gmail.com> writes:
> 
> > Thanks, I didn't miss that.
> >
> > I have no control over the content in the file so I don't know what an
> > appropriate number is.
> 
> Those who are editing the file would be able to adjust the attributes
themselves,
> no?

It sounds like we might need an attribute like:

*.md	conflict-marker-size=32,conflict-marker-separator='~'

to stick 32 ~ characters as a separator, if going down that path. I'm not
sure how hard this would be, but tooling other systems, like JGit and every
client on the planet would be painful.

-Randall

