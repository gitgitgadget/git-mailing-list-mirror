Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D4641F404
	for <e@80x24.org>; Tue, 17 Apr 2018 23:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeDQXZV (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 19:25:21 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:39510 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeDQXZU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 19:25:20 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w3HNPH0x020907
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 18 Apr 2018 01:25:17 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w3HNPHSb020906;
        Wed, 18 Apr 2018 01:25:17 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w3HNP5Hv004997;
        Wed, 18 Apr 2018 01:25:05 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w3HNP4kw004995;
        Wed, 18 Apr 2018 01:25:04 +0200
Date:   Wed, 18 Apr 2018 01:25:04 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180417232504.GA4626@helen.PLASMA.Xg8.DE>
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE>
 <87y3hlecod.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y3hlecod.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 17, 2018 at 11:38:26PM +0200, Ævar Arnfjörð Bjarmason wrote:
> I've been loosely following a similar discussion around blockchains and
> my understanding of the situation is that for a project such as say
> Linux the GDPR gives you this potential out for that[1]:
> 
>     "the personal data are no longer necessary in relation to the
>     purposes for which they were collected or otherwise processed"
> 
> I.e. you understand that when you submit a patch to linux.git how it's
> going to get used, and that it's in a storage system that isn't going to
> be pruned just because you ask for it.
> [...]
> You can make a compelling case that for say submitting your data to the
> Bitcoin blockhcain the above quote from article 17 overrides it

Well, you're quoting from lit. a but there's also lit. b to f! It says 
"one of the following grounds applies", not "all of ...".

> This is very different from you say joining a company, committing to its
> internal git repo, and your name being there in perpetuity, or choosing
> to submit a patch to linux.git or git.git.
>
> I'd think that would be handled the same way as a structural engineering
> firm being able to record in perpetuity who it was that drew up the
> design for some bridge.

Internal repo is entirely unproblematic, since you don't need consent 
for doing that. It is covered by Art. 6 (1) lit. f.

The problem is public repos. Publishing employee information is 
generally considered not to be covered by Art. 6 (1) lit. f. After all, 
you can easily publish the software but not the repo.

> I don't think it's plausible that the GDPR,
> which is probably mainly going to be about consumer protection, is going
> to concern itself with that in practice.

Oh, no, GDPR is about privacy in general. It's not only about consumer 
protection. It applies in the same way to employees in relation to 
their employer and to citizens in relation to the authorities, and to 
open source contributors in relation to the projects, or to any other 
data processing outside family and friends (Art. 2 (2) lit. c).

I am inclined to assume that Art. 6 (1) lit. b might be the solution, 
since the licenses typically demand a history of changes to be 
distributed with the program (for example, GPLv3 section 5 a). After 
all, the author generally wants to be given credit for his changes and 
it can be assumed that this one of the conditions for licensing the 
work in the first place.

On the other hand, of course, the author could waive the condition at 
any time, which means Art. 6 (1) lit. b wouldn't apply anymore and 
you'd have the same issue as with consent-based processing of the 
information (lit. a).

Best wishes
Peter


-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
