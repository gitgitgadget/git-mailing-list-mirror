From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sat, 5 May 2012 20:53:36 +0100
Organization: OPDS
Message-ID: <38B7BCC61E844EAD97CC18D5D7299DD5@PhilipOakley>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com><703DFCB358F74F9D87F12C22B782EA61@PhilipOakley> <CAMP44s1isa2a=a-QLGaE9ThW1iUBj0je2NUi8FVxqA=OELLmyA@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Jeff King" <peff@peff.net>, "Scott Chacon" <schacon@gmail.com>,
	"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"Matthieu Moy" <matthieu.moy@imag.fr>,
	"Piotr Krukowiecki" <piotr.krukowiecki.news@gmail.com>
To: "Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 21:53:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQl2y-0004YA-ID
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 21:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755759Ab2EETxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 15:53:36 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:13694 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754611Ab2EETxf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 15:53:35 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgMFALiEpU9cHlGK/2dsb2JhbABEhXKFSKc5gQiCBwUBAQQBCAEBGRUeAQEcBQUGAgMFAgEDFQECAgIFIQICFAEECBIGBxcGEwgCAQIDAYdvAwYJB6dFiDgNiVOBL4hoaBmEbzVjBI16k0OFA4JqgV0
X-IronPort-AV: E=Sophos;i="4.75,536,1330905600"; 
   d="scan'208";a="371047108"
Received: from host-92-30-81-138.as13285.net (HELO PhilipOakley) ([92.30.81.138])
  by out1.ip04ir2.opaltelecom.net with SMTP; 05 May 2012 20:53:32 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197135>

From: "Felipe Contreras" <felipe.contreras@gmail.com> Sent: Saturday, May
05, 2012 6:30 PM
> On Sat, May 5, 2012 at 6:52 PM, Philip Oakley <philipoakley@iee.org>
> wrote:
>> From: "Felipe Contreras" <felipe.contreras@gmail.com> Sent: Saturday, May
>> 05, 2012 2:04 PM
>>
>>> Proposal:
>>>
>>> Avoid the terms 'cache' and 'index' in favor of 'stage'.
>>>
>>> Advantages:
>>>
>>> The term 'stage' is more intuitive for newcomers which are more
>>> familiar with English than with git, and it seems to be a
>>> straightforward mental notion for people from different mother
>>> tongues.
>>>
>>> It is so intuitive that it is used already in a lot online
>>> documentation, and the people that do teach git professionally use
>>> this term.
>>
>>
>> I've never found any of the terms to be great (as per this discussion
>> ;-).
>>
>> The term that helped me most, heard on one of the git videos, was "it's
>> like
>> a manifest", alluding to a 'shipping manifest', which then leads to both
>> the
>> "staging area" and "index" terms. Though "index" is probably too
>> technical
>> for most folk.
>>
>> The allusion to shipping a consignment or rail marshalling
>> (classification)
>> yards, and similar freight flows
>
> Perhaps, but these terms are not already used everywhere, unlike
> 'stage', and haven't been brought in past discussions. Personally the
> word 'manifest' says nothing to me (manifesto?), neither does
> consignment, or marshalling.

Useful to know..  The fact that there is such a variety of terms, usually
based on specialist transport, is an indication of our on-going
difficulties - people just don't talk about this aspect of 'work'. Usually
it (packaging)  is 'someone else's problem' ;-)  E.g. what's it called when
the post office batches up mail in the 'sorting' office? - I don't know, nor 
usually care, except when I just post 60 letters to Hawaii - should I put a 
band around them to 'help' the post office ... In the git case, unusually 
for a VCS, we do our own grouping, but need a verb.

Aside: wikipedia notes that even UK and US English railways can't agree 
their term
(http://en.wikipedia.org/wiki/Marshalling_yards) on what to call the
'staging' process we are discussing

I looked up a translation (I hope I haven't mis-chosen):
    shipping manifest (n) (bill or inventory enclosed with a consignment)
    manifiesto de carga (nm)
so (to me) it does look like "index" is the best word for our *list* of what 
we have
prepared, and the stage of preparation of those items for our next commit 
(shipment to the repo).

It probably doesn't help that the concepts and the implementation aren't 
always in alignment (a generic DVCS problem). e.g. when we `add` a file, a 
copy goes straight into our objects store, but isn't actually 'in' the repo. 
So the discussion suffers from knowing too much.

> As discussed before, we need a term that
> has a nice noun (stage), verb (to stage), and past-participle
> (staged). There have been a lot of suggestions, but nothing as good as
> 'stage', which is presumably the reason why it's so prevalent in
> online documentation.

Ooops, my note about my wording suggestions being used for *explanation* got 
lost in
the trimming. I wasn't suggesting a change to the candidate terms.

>
> Maybe you are quite familiar with ships :)
>
UK - home of the railways, and the SS Great Britain, and the Titanic ...
Philip 
