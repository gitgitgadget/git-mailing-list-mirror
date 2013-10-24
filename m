From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v2 00/14] Officially start moving to the term 'staging
 area'
Date: Thu, 24 Oct 2013 02:57:15 +0200
Message-ID: <5268706B.4040303@gmail.com>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com> <1381789769-9893-4-git-send-email-felipe.contreras@gmail.com> <5261C42E.4050208@gmail.com> <8FC260D94D1A4711AAA8A0DE7477791B@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Miles Bader <miles@gnu.org>
To: Philip Oakley <philipoakley@iee.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 24 02:57:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ9Em-0006fF-3n
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 02:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545Ab3JXA5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 20:57:16 -0400
Received: from mail-ee0-f45.google.com ([74.125.83.45]:40121 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475Ab3JXA5O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 20:57:14 -0400
Received: by mail-ee0-f45.google.com with SMTP id c50so954527eek.18
        for <git@vger.kernel.org>; Wed, 23 Oct 2013 17:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8ETUMylCt6TYS6W73RH0jvXBQdN87J8QR2oTOzK5TSI=;
        b=iHU2qxFzltmI7y7I4NgqEtmFirwzrcShUpZFL7KNg+0Pa46z28Y9V6hr2YlBVO06kL
         hNPxaFavzRe41RdgMMlCCwEIWzvpt2OLd2kWITew0eoNMjS64U801YCmssQNMgg3klam
         rYTYZBB4OAhNKEj/gRTP6f0VTqnTMGCdx6QiHUaOLA/p5Glxlcq2ZcZe9xaOYJJsMn1v
         2hAnwgPlbPV73+cVYoQyEPJxWdRNjTGkQ95k8LswHe53zZrcAgCjrbG1uPLZT1dIQqwu
         l+vNP8bD0yNagBBa6nsgOro1qIvyG/UDTagYlOEsPjXPHC4XGdtB/FWi+HbOXY5mTrIm
         Dw3A==
X-Received: by 10.14.2.200 with SMTP id 48mr110052eef.88.1382576233448;
        Wed, 23 Oct 2013 17:57:13 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id h45sm76671309eeg.5.2013.10.23.17.57.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Oct 2013 17:57:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <8FC260D94D1A4711AAA8A0DE7477791B@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236558>

Am 19.10.2013 16:08, schrieb Philip Oakley:
> From: "Karsten Blees" <karsten.blees@gmail.com>
>> Am 15.10.2013 00:29, schrieb Felipe Contreras:
>>> tl;dr: everyone except Junio C Hamano and Drew Northup agrees; we
>>> should move
>>> away from the name "the index".
>>>
>>> It has been discussed many times in the past that 'index' is not an
>>> appropriate description for what the high-level user does with it,
>>> and
>>> it has been agreed that 'staging area' is the best term.
>>>
>>
>> I haven't followed the previous discussion, but if a final conclusion
>> towards 'staging area' has already been reached, it should probably be
>> revised.
> 
> Do you mean that how that conclusion was reached should be summarised,
> or that you don't think it's an appropriate summary of the broader
> weltanschauung?
> 

The latter. I don't know about 'broader', but I'll try to summarize _my_ world view:

(1) Audience matters

For actual users, we need an accurate model that supports a variety of use cases without falling apart. IMO, a working model is more important than simplicity. Finally, its more important to agree on the actual model than on a vague term that can mean many things (theater stage vs. loading dock...).

For potential users / decision makers, we need to describe git's features in unmistakable terms that don't need extra explanation. In this sense, the index / cache / staging area is not a feature in itself but facilitates a variaty of broader features:
- fine grained commit control (via index (add -i), but also commit -p, commit --amend, cherry-pick, rebase etc.)
- performance
- merging


(2) Index

An index, as in a library, maps almost perfectly to what the git index is _and_ what we do with it. No, I don't mean .so/.dll/.lib files, I'm talking about the real thing with shelves of books and a big box with index cards (aka the index).

The defining characteristic of a book (or publication in general) is its content, not its physical representation (paper). There are typically many indistinguishable copies of the same book. An author can continue working on the manuscript without affecting the copy at the library at all.

When a new or updated publication is submitted to the library, it is first added to the index and placed on a cart at the reception desk. Some time later, the librarian commits the content of the cart to the shelves. A user of the library will typically consult the index to lookup information or to check if his personal copy of a publication is up to date. The index can be thrown away and rebuilt from the content of the shelves. A big library may have a central repository and several local branches (aka field offices) that can be synchronized by comparing their indexes card by card.

Granted, a library is typically not versioned, and its unlikely that any one user will have checked out a full copy of the library's content. But otherwise, its pretty similar to git...


(3a) Staging area (logistics)

A staging area, as in (military) logistics / transportation, is about moving physical goods around. You move an item from your stock to the staging area, then onto the truck and finally deliver it to the customer.

The defining characteristic of a physical good is its physical existence. Each item is uniquely identifiable by a serial number. There may be many of the same kind, but there are no exact copies.

Problem #1: If an item in the staging area is broken, you fix it directly in the staging area, because that's where it _is_. Thus you also don't need to stage the item again. That's how conventional SCMs work: they track the identity (serial number, file name) of things.

Problem #2: The transportation model only supports additions. You cannot add an item to your staging area that, upon delivery, will magically remove itself from the possession of the customer. Let alone that you'd have to steal it first to be able to physically place it into your staging area.

This can be fixed by slightly modifying our mental model: instead of real things, lets think about "staging changes" (or deltas, or patches). Again, that's what conventional SCMs do and what git exactly does _not_ do.

Problem #3: In logistics, the state / inventory of the customer is irrelevant. If a customer orders an item he already has, its his problem. There's no need for core commands like status, diff or reset, and there's no way to explain what they do with a staging area model. What if a customer buys at another shop without telling us, effectively changing his inventory (git reset --soft)? This shouldn't affect our staging area at all, right? But with git it does...ooops.

(3b) Staging area (other meanings)

I don't see how a stage (as in a theater) is in any way related to the git index.

Data staging (as in loading a datawarehouse or web-server) fits to some extent, as its also about copying information, not moving physical things.

[...]
>>
>> 1.) Recording individual files to commit in advance (instead of
>> specifying them at commit time). Which isn't that hard to grasp.
> 
> For many, that separation of preparation(s), from the final action, is
> brand new and difficult to appreciate - it's special to computer systems
> (where copying is 100% reliable, essentially instantaneous, and in Git's
> case, 100% verifiable via crypto checksums).
> 

I'll try to remember that next time I write a shopping list... :-)

[...]
> Even 'native' speakers don't have a single consistent term for the
> concept. Terms are stolen from many varied industries and activities
> that have to prepare and package items (Ships, Trains, Theaters)
> (see http://en.wikipedia.org/wiki/Shipping_list, for a shortish list, which doesn't mention an Index)

All true, but we don't need to steal terms from unrelated fields if information science provides us with the terms we need.

[...]
> 
> In one sense even that is not the right term - If compared to a book /
> pamphlet / monograph (being placed in a Library / repository)  it's more of a contents list (by chapter and verse / directory and file), with various bits of front matter such as author, publisher, previous editions, introductory preface, dates, contents list, and finally content. A book's 'index' is a supplementary mini grep of useful terms that the reader may wish to find.
> 

Yes, a book's index is not the right meaning, as is stock market index or index finger. However, a library index seems to fit quite well.

By the same logic, I could argue that a file in git is not used as a tool to shape metal, therefore its not a file. Lets call it "costume", because a costume in a theater wraps an actor just like a file wraps content.</irony>

> All in all it's difficult to undo this Gordian knot of confusions.
> 
>>
>> Just my 2 cents
>> Karsten
>>
> The key is probably to separate the devlopers concerns over implementation details from the user's big picture view, in an arena that is short of well (commonly) understood terms.
> 

Yes, see my point about audience. Its probably also helpful to distinguish between unbiased SCM newbies and "braindamaged" VSS/CVS/SVN folks like me :-)

> Philip
> 
