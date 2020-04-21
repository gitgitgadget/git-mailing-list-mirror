Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BABC54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 21:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DCCD2072D
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 21:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgDUV0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:26:13 -0400
Received: from elephants.elehost.com ([216.66.27.132]:38094 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgDUV0N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 17:26:13 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 03LLQ2hU060787
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 21 Apr 2020 17:26:03 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Shourya Shukla'" <shouryashukla.oo@gmail.com>,
        <git@vger.kernel.org>, <sandals@crustytoothpaste.net>,
        "'Derrick Stolee'" <dstolee@microsoft.com>,
        "'Elijah Newren'" <newren@gmail.com>,
        "'Christian Couder'" <christian.couder@gmail.com>
References: <20200421131223.29337-1-shouryashukla.oo@gmail.com>        <20200421131223.29337-4-shouryashukla.oo@gmail.com>        <xmqqy2qomwwl.fsf@gitster.c.googlers.com>        <011001d6181d$97301fc0$c5905f40$@nexbridge.com> <xmqq1rogmu9e.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rogmu9e.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH v3 3/4] gitfaq: shallow cloning a repository
Date:   Tue, 21 Apr 2020 17:25:57 -0400
Message-ID: <011501d61823$764f5180$62edf480$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHpLdAtq0iMdH6Skp6VrcJJkheEYQHcqM4+Amj3/YMBvPD8QAENDmwAqCVtvRA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 21, 2020 4:58 PM, Junio C Hamano wrote:
> Subject: Re: [PATCH v3 3/4] gitfaq: shallow cloning a repository
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> >> I have a feeling that --depth/shallow is deprecated/frowned upon
> >> these
> > days
> >> and more people recommend partial/blob-less clones instead (a few
> >> random people added to Cc: to see if they want to say something here).
> >
> > I rather hate to chime in as a dissenting opinion,...
> 
> Oh, don't hate anything.  It is greatly appreciated so that we can cover
"in
> such and such use case, this solution is good" variants for
similarly-sounding-
> but-fundamentally-different classes of problems.  We do not want to give a
> spinal-reflex answer of "use shallow" (or "use partial", for that matter)
to
> "too large a repo"
> question without contexts that guide the readers to a better choice.
> 
> That is where a well-organized FAQ list shines.

I have spoken on this topic and can probably share some of it.

