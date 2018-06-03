Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 940321F403
	for <e@80x24.org>; Sun,  3 Jun 2018 17:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbeFCRqe (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 13:46:34 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41064 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbeFCRqd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 13:46:33 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w53HkU0K004704
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 3 Jun 2018 19:46:30 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w53HkUJ1004703;
        Sun, 3 Jun 2018 19:46:30 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w53HkIi6011187;
        Sun, 3 Jun 2018 19:46:18 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w53HkHES011186;
        Sun, 3 Jun 2018 19:46:17 +0200
Date:   Sun, 3 Jun 2018 19:46:17 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE>
 <87y3hlecod.fsf@evledraar.gmail.com>
 <20180603092736.GA5510@helen.PLASMA.Xg8.DE>
 <87vab087y2.fsf@evledraar.gmail.com>
 <20180603112557.GA6564@helen.PLASMA.Xg8.DE>
 <87tvqk81qp.fsf@evledraar.gmail.com>
 <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
 <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 03, 2018 at 04:28:31PM +0100, Philip Oakley wrote:
> In most Git cases that legal/legitimate purpose is the copyright licence,
> and/or corporate employment. That is, Jane wrote it, hence X has a legal
> rights of use, and we need to have a record of that (Jane wrote it) as
> evidence of that (I'm X, I can use it) right. That would mean that Jane
> cannot just ask to have that record removed and expect it to be removed.

Re corporate employment:

For sure nobody would dare to quesion that a company has a right to 
keep an internal record that Jane wrote it.

The issue is publishing that information. This is an entirely different 
story.

I already stressed that from the very beginning.

Re copyright license:

No, a copyright license does not provide a legitimization.

- copyright is about distributing the program, not about distributing 
version control metadata.

- Being named is a right, not an obligation of the author. Hence, if 
the author doesn't want his name published, the company doesn't have 
legitimate grounds based in copyright for doing it anyway, against his 
or her will.

> From a personal view, many folk want it to be that corporates (and open
> source organisations) should hold no personal information with having
> explicit permission that can then be withdrawn, with deletion to follow.
> However that 'legal' clause does [generally] win.

Let's be honest: We do not know what legitimization exactly in each 
specific case the git metadata is being distributed under.

It may be copyright, it may be employment, but it may also be revocable 
consent. This is, we cannot safely assume that no git user will ever 
have to deal with a legitimate request based on the right to be 
forgotten.

> In the git.git case (and linux.git) there is the DCO (to back up the GLP2)
> as an explicit requirement/certification that puts the information into the
> legal evidence category. IIUC almost all copyright ends up with a similar
> evidentail trail for the meta data.

This makes things more complicated, not less. You have yet more meta 
data to cope with, yet more opportunities to be bitten by the right to 
be forgotten. Since I proposed a list of metadata where each entry can 
be anonymized independently of each other, it would be able to deal 
with this perfectly.

> The more likely problem is if the content of the repo, rather than the meta
> data, is subject to GDPR, and that could easily ruin any storage method.
> Being able to mark an object as <Lost/Deleted> would help here(*).

My proposal supports any part of the commit, including the contents of 
individual files, as eraseable, yet verifiable data.

> Also remember that most EU legislation is 'intent' based, rather than
> 'letter of', for the style of legal arguments (which is where some of the UK
> Brexit misunderstandings come from), so it is more than possible to get into
> the situation where an action is both mandated and illegal at the same time,
> so plent of snake oil salesman continue to sell magic fixes according to the
> customers local biases.

This may be true. I am not trying to sell snake oil, however. To have 
erasure and verifiability at the same time is a highly generic feature 
that may be desirable to have for a multitude of reasons, including but 
not limited to legal ones like GDPR and copyright violations.

> I do not believe Git has anything to worry about that wasn't already an
> issue.

Yes, but it definitely had and still does have something to worry about.

git should provide technical means to deal with this. I provided a 
proposal based on anonymization that does not in any way have any 
drawback compared to the status quo, except a slight increase in 
metadata size and various degrees of backwards incompatibility, 
depending on how it is implemented.

What do you think about my proposal as a solution for the problem?

You provide a lot of arguments about why it is not a necessity to have 
this, but let's assume it is; is there any actual problem you see with 
the proposal, except that someone would have to implement it?

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
