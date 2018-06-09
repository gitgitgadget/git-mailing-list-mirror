Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42CE71F403
	for <e@80x24.org>; Sat,  9 Jun 2018 23:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753459AbeFIW7G (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 18:59:06 -0400
Received: from e1i93.smtp2go.com ([103.36.108.93]:48747 "EHLO
        e1i93.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753434AbeFIW7F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 18:59:05 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Jun 2018 18:59:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpservice.net; s=m1fbw0.a1-4.dyn; x=1528586045; h=Feedback-ID:
        X-Smtpcorp-Track:Date:Subject:To:From:Reply-To:Message-ID:Sender:
        List-Unsubscribe; bh=LVJyZKEfPIYZVUVYqHSldP1+x8xNCw+Qt1sWsjzGUBQ=; b=UTs/rVyZ
        IQWLwips6BSykGBZ4/TBUz2VoE/zOnHQwPC63Arb70qFI7bOvfq4NUTKZNFLVoH86DFv3MDyg8MQB
        Ditc6//bGsaD6urU3z9lkyDGWNa005ofaO1vLR8oimh6Sqw+PHezDho+fvSTHjyYSAdusavLua7Un
        ebiGnkaBVd8G9fiBirdYB83TQitcCx03Ztc8wZUk/cQ+/Mt5JLLVM/KUMiVpm3fXzeENQGcLYa/hf
        +Cbt80U9Cup1i2cGrN+UXCc6/MlOFpT08/Of3zaGyaolXm80RyZdCdti00gQ00a/ZB4bV45oc7n1A
        zh0GCEqt9vkQ76XpJGvMvqhK4w==;
Message-ID: <059CBAEFB9D945EE9D54BF515E963798@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Peter Backes" <rtc@helen.PLASMA.Xg8.DE>
Cc:     "David Lang" <david@lang.hm>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>
References: <87tvqk81qp.fsf@evledraar.gmail.com> <20180603141801.GA8898@helen.PLASMA.Xg8.DE> <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley> <20180603174617.GA10900@helen.PLASMA.Xg8.DE> <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz> <20180607063225.GA28343@helen.PLASMA.Xg8.DE> <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley> <20180607223442.GA5322@helen.PLASMA.Xg8.DE> <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz> <20180607232128.GA5879@helen.PLASMA.Xg8.DE> <20180608025313.GA12749@thunk.org>
Subject: Re: GDPR compliance best practices?
Date:   Sat, 9 Jun 2018 23:50:32 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Smtpcorp-Track: 1fRXgq9EFL34V0.HHX9WJ2qE
Feedback-ID: 66524m:66524aMf6O2Y:66524sCpu4aMu9q:SMTPCORP
X-Report-Abuse: Please forward a copy of this message, including all
 headers, to <abuse-report@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Theodore Y. Ts'o" <tytso@mit.edu>
Sent: Friday, June 08, 2018 3:53 AM
> On Fri, Jun 08, 2018 at 01:21:29AM +0200, Peter Backes wrote:
>> On Thu, Jun 07, 2018 at 03:38:49PM -0700, David Lang wrote:
>> > > Again: The GDPR certainly allows you to keep a proof of copyright
>> > > privately if you have it. However, it does not allow you to keep
>> > > publishing it if someone exercises his right to be forgotten.
>> > someone is granting the world the right to use the code and you are
>> > claiming
>> > that the evidence that they have granted this right is illegal to have?
>>
>> Hell no! Please read what I wrote:
>>
>> - "allows you to keep a proof ... privately"
>> - "However, it does not allow you to keep publishing it"
>
> The problem is you've left undefined who is "you"?  With an open
> source project, anyone who has contributed to open source project has
> a copyright interest.  That hobbyist in German who submitted a patch?
> They have a copyright interest.  That US Company based in Redmond,
> Washington?  They own a copyright interest.  Huawei in China?  They
> have a copyright interest.
>
> So there is no "privately".  And "you" numbers in the thousands and
> thousands of copyright holders of portions of the open source code.
>
> And of course, that's the other thing you seem to fundamentally not
> understand about how git works.  Every developer in the world working
> on that open source project has their own copy.  There is
> fundamentally no way that you can expunge that information from every
> single git repository in the world.  You can remote a git note from a
> single repository.  But that doesn't affect my copy of the repository
> on my laptop.  And if I push that repository to my server, it git note
> will be out there for the whole world to see.
>
> So someone could *try* sending a public request to the entire world,
> saying, "I am a European and I demand that you disassociate commit
> DEADBEF12345 from my name".  They could try serving legal papers on
> everyone.  But at this point, it's going to trigger something called
> the "Streisand Effect".  If you haven't heard of it, I suggest you
> look it up:
>
> http://mentalfloss.com/article/67299/how-barbra-streisand-inspired-streisand-effect
>
> Regards,
>
> - Ted
>
Hi Ted,

I just want to remind folks that Gmane disappeared as a regular list because
of a legal challenge, the SCO v IBM Unix court case keeps rumbling on, so
clarifying the legal case for:
a) holding the 'personal git meta data', and
b) disclosing (publishing) 'personal git meta data'
under various copyright and other legal issue scenarios relative to GDPR is
worth clarifying.

I'm of the opinion that the GPL should be able to allow both holding and
disclosing that data, though it may need a few more clarifications as to
verifying that the author is 'correct' (e.g. not a child) and if a DCO is
needed, etc.

We are already looking at a change to the hash, so the technical challenge
could be addressed, but may create too many logical conflicts if 'right to
be forgotten' is allowed (one hash change is enough;-)

Philip

