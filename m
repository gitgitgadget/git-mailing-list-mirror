Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AA6220281
	for <e@80x24.org>; Fri, 15 Sep 2017 20:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbdIOUmV (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 16:42:21 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:58128 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbdIOUmU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 16:42:20 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id sxRId20jHAp17sxRIdlXOC; Fri, 15 Sep 2017 21:42:19 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=YzBbbjn3AAAA:20 a=Ye9q-bpsAAAA:8 a=yMTatn1YAAAA:8 a=5rxgeBVgAAAA:8
 a=X3Svibix7opi2ghGLigA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=wPNLvfGTeEIA:10
 a=R_9YxD2RDK4A:10 a=B7vsfmneXZoA:10 a=2GAyGHvkCUYA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=bl047TfUSv69RyYXCcQJ:22 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <12CC12FA3A034D6A9B91695BE1A04641@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jonathan Nieder" <jrnieder@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     "Brandon Williams" <bmwill@google.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Git Mailing List" <git@vger.kernel.org>,
        "Stefan Beller" <sbeller@google.com>, <jonathantanmy@google.com>,
        "Jeff King" <peff@peff.net>, "David Lang" <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com> <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com> <20170307001709.GC26789@aiede.mtv.corp.google.com> <xmqqa828733s.fsf@gitster.mtv.corp.google.com> <xmqq1snh29re.fsf@gitster.mtv.corp.google.com> <20170911185913.GA5869@google.com> <alpine.DEB.2.21.1.1709131340030.4132@virtualbox> <20170913163052.GA27425@aiede.mtv.corp.google.com> <alpine.DEB.2.21.1.1709141119140.4132@virtualbox> <20170914184915.GC78683@aiede.mtv.corp.google.com>
Subject: Re: RFC v3: Another proposed hash function transition plan
Date:   Fri, 15 Sep 2017 21:42:18 +0100
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
X-Antivirus: AVG (VPS 170915-2, 15/09/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfEbPcLdkV1U7iPKWU+bGYq2hjHh1K3Nt4X3badDmbGlCdH5w/ni6uTBdC4sGh5fmglw5q3W/cU4PbfSnkPtKIScyW+qQNMEhhTJloXLPXbXIW7qeI6sb
 8G3prBZkagaKXwNBBIZBaKOUc4LcEXzc0LYVu3fhagMUJ6YN1RSnF+o824LJJyLYC5QYsfdQ/dT1tYmpgaTjXt363q9cBbLFL3lxoXvyMmy5t9AzUleNOPBO
 nOpsbNNFFN+0KChci/Z1qDUYxSGoHhSUwO3bSdOrLett0eQsKbFiRgtdNhHjOvUBpYI7ec/2N+/jO5IEkvapu+RxD6Rq3xFDKMCsPMxuqNUFSZ9F/amnKWJg
 gO6N6ufuM/6lDmG259DLfcwMhm4JfyuGMW2I4yU9g2EKeR3s7V4LebrE3CGG7yBKhmIf7Tzw0bvqgpjcFx2dekiPQu5j7uJGO3ScDqXEfifcORlB4FPQdB0j
 m1vlWNC+osBW/yH0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

"Jonathan Nieder" <jrnieder@gmail.com> wrote;
> Johannes Schindelin wrote:
>> On Wed, 13 Sep 2017, Jonathan Nieder wrote:
>
>>> As a side note, I am probably misreading, but I found this set of
>>> paragraphs a bit condescending.  It sounds to me like you are saying
>>> "You are making the wrong choice of hash function and everything else
>>> you are describing is irrelevant when compared to that monumental
>>> mistake.  Please stop working on things I don't consider important".
>>> With that reading it is quite demotivating to read.
>>
>> I am sorry you read it that way. I did not feel condescending when I 
>> wrote
>> that mail, I felt annoyed by the side track, and anxious. In my mind, the
>> transition is too important for side tracking, and I worry that we are 
>> not
>> fast enough (imagine what would happen if a better attack was discovered
>> that is not as easily detected as the one we know about?).
>
> Thanks for clarifying.  That makes sense.
>
> [...]
>> As to *my* opinion: after reading https://goo.gl/gh2Mzc (is it really
>> correct that its last update has been on March 6th?), my only concern is
>> really that it still talks about SHA3-256 when I think that the
>> performance benefits of SHA-256 (think: "Git at scale", and also hardware
>> support) really make the latter a better choice.
>>
>> In order to be "ironed out", I think we need to talk about the
>> implementation detail "Translation table". This is important. It needs to
>> be *fast*.
>>
>> Speaking of *fast*, I could imagine that it would make sense to store the
>> SHA-1 objects on disk, still, instead of converting them on the fly. I am
>> not sure whether this is something we need to define in the document,
>> though, as it may very well be premature optimization; Maybe mention that
>> we could do this if necessary?
>>
>> Apart from that, I would *love* to see this document as The Official Plan
>> that I can Show To The Manager so that I can ask to Allocate Time.
>
> Sounds promising!
>
> Thanks much for this feedback.  This is very helpful for knowing what
> v4 of the doc needs.
>
> The discussion of the translation table in [1] didn't make it to the
> doc.  You're right that it needs to.
>
> Caching SHA-1 objects (and the pros and cons involved) makes sense to
> mention in an "ideas for future work" section.
>
> An implementation plan with well-defined pieces for people to take on
> and estimates of how much work each involves may be useful for Showing
> To The Manager.  So I'll include a sketch of that for reviewers to
> poke holes in, too.
>
> Another thing the doc doesn't currently describe is how Git protocol
> would work.  That's worth sketching in a "future work" section as
> well.
>
> Sorry it has been taking so long to get this out.  I think we should
> have something ready to send on Monday.

I had a look at the current doc  https://goo.gl/gh2Mzc and thought that the 
selection of the "NewHash" should be separated out into a section of it's 
own as a 'separation of concerns', so that the general transition plan only 
refers to the "NewHash", so as not to accidentally pre-judge that selection.

I did look up the arguments regarding sha2 (sha256) versus sha3-256 and 
found these two Q&A items

https://security.stackexchange.com/questions/152360/should-we-be-using-sha3-2017

https://security.stackexchange.com/questions/86283/how-does-sha3-keccak-shake-compare-to-sha2-should-i-use-non-shake-parameter

with an onward link to this:
 https://www.imperialviolet.org/2012/10/21/nist.html

"NIST may not have you in mind (21 Oct 2012)"

"A couple of weeks back, NIST announced that Keccak would be SHA-3. Keccak 
has somewhat disappointing software performance but is a gift to hardware 
implementations."

which does appear to cover some of the concerns that dscho had noted, and 
speed does appear to be a core Git selling point.

It would be worth at least covering these trade offs in the "select a 
NewHash" section of the document, as at the end of the day it will be a 
political judgement about what the future might hold regarding the 
contenders.

What may also be worth noting is the fall back plan should the chosen 
NewHash be the first to fail, perhaps spectacularly, as having a ready plan 
could support the choice at risk.

>
> Thanks,
> Jonathan
>
> [1] 
> https://public-inbox.org/git/CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com/

--
Philip 

