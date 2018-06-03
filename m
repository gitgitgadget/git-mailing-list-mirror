Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB3CE1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 23:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbeFCXBx (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 19:01:53 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41128 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeFCXBx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 19:01:53 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w53N1opL005765
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 4 Jun 2018 01:01:50 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w53N1o0B005764;
        Mon, 4 Jun 2018 01:01:50 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w53N1cdq015208;
        Mon, 4 Jun 2018 01:01:38 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w53N1cQV015207;
        Mon, 4 Jun 2018 01:01:38 +0200
Date:   Mon, 4 Jun 2018 01:01:38 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180603230138.GA14956@helen.PLASMA.Xg8.DE>
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE>
 <87y3hlecod.fsf@evledraar.gmail.com>
 <20180603092736.GA5510@helen.PLASMA.Xg8.DE>
 <87vab087y2.fsf@evledraar.gmail.com>
 <20180603112557.GA6564@helen.PLASMA.Xg8.DE>
 <87tvqk81qp.fsf@evledraar.gmail.com>
 <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
 <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <5F80881E35F941E88D9C84565C437607@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F80881E35F941E88D9C84565C437607@PhilipOakley>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 03, 2018 at 11:28:43PM +0100, Philip Oakley wrote:
> It is here that Article 6 kicks in as to whether the 'organisation' can
> retain the data and continue to use it.

Article 6 is not about continuing to use data. Article 6 is about 
having and even obtaining it in the first place.

Article 17 and article 21 are about continuing to use data.

> For an open source project with an open source licence then an implict DCO
> applies for the meta data. It is the legal  basis for the the release.

Neither article 6 nor 17 or 21 have anything remotely like an "implicit 
DCO" as a legitimization for publishing employee data.

The GDPR is very explicit about implicit stuff never being a basis for 
consent, if you want to imply that is your basis. And consent can be 
withdrawn at any time anyway.

An open source license has nothing whatsoever to do with the question 
of version control metadata. A public version control system is not 
necessary to publish open source software.

> > - copyright is about distributing the program, not about distributing
> > version control metadata.
> It is specificaly about giving that right to copy by Jane Doe (but git gives
> no other information other than that supposedly globally unique 'author
> email'.

I don't get what you are saying. As I said, a public version control 
system is not necessary to publish open source software. The two things 
may be intimately related in practice, but not in theory.

> > - Being named is a right, not an obligation of the author. Hence, if
> > the author doesn't want his name published, the company doesn't have
> > legitimate grounds based in copyright for doing it anyway, against his
> > or her will.
> Git for Open Source is about open licencing by name. I'd agree that a closed
> corporate licence stays closed, but not forgotten.

Again I don't get what you are saying. The author has a right to be 
named as the author, not an obligation. This has nothing whatsoever to 
do with the question of Open Source vs. closed corporate licenses.

> > Let's be honest: We do not know what legitimization exactly in each
> > specific case the git metadata is being distributed under.
> 
> We should know, already. A specific licence [or limit] should be in place.
> We don't really want to have to let a court decide ;-)

It is insufficient to have a license for distributing the program. The 
license is not a GDPR legitimization for git metadata. Distributing the 
program can be done without distributing the author's identity as part 
of the metadata of his commits.

> The law is never decided by technical means, unfortunately.

It is. The GDPR refers to the state of the art of technology without 
defining it. Thus, technical means are very important in the GDPR. This 
may be something new for lawyers. If technology changes tomorrow, even 
without anything else changing, you may be breaking the GDPR by this 
simple fact tomorrow, while not breaking it today.

Again: Technology is very important in the GDPR.

> Regular git users should have no issues - they just need to point 
> their finger at the responsible authority.

If git users are putting commits online for global download, they are 
the responsible authority.

> The DCO/GPL2 are the legitimate data record that recipients should have for
> their copy. There is no right to be forgotten at that point.

What do you mean by "should have for their copy"? Why shouldn't there 
be a right to be forgotten? Open Source Software has been distributed a 
lot without detailed version control history information. Having this 
information as a record is certainly in the interest of the recipient, 
but it is very very questionable that it is an overriding legitimate 
grounds as per Art. 17 for keeping that data.

> I see the solution to be elsewhere, and that it is in some ways a strawman
> discussion: "if someone has the right to be forgotten, how do we delete the
> meta data", when that right (to delete the meta data in a properly licence
> repo) does not exist.

See, this kind of shady legal argument is what lawyers are selling you. 
Why not put the energy into designing a technical solution.

They tell you: "Ignore the GDPR. I will give you backup by giving you 
lots of disclaimers and excuses for doing so. Just give me a lot of 
money."

Having the ability to validate yet erase data form repositorys is 
desirable from a technical point of view. It has a lot of uses, not 
necessarily only legal ones. The objection of efficiency raised by Ted 
is a valid one. The strawman argument is not.

Best wishes
Peter
-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
