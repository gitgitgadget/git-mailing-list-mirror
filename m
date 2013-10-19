From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 00/14] Officially start moving to the term 'staging area'
Date: Sat, 19 Oct 2013 15:08:44 +0100
Organization: OPDS
Message-ID: <8FC260D94D1A4711AAA8A0DE7477791B@PhilipOakley>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com> <1381789769-9893-4-git-send-email-felipe.contreras@gmail.com> <5261C42E.4050208@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-15";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Piotr Krukowiecki" <piotr.krukowiecki.news@gmail.com>,
	"Jay Soffian" <jaysoffian@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"William Swanson" <swansontec@gmail.com>,
	"Ping Yin" <pkufranky@gmail.com>,
	"Hilco Wijbenga" <hilco.wijbenga@gmail.com>,
	"Miles Bader" <miles@gnu.org>
To: "Karsten Blees" <karsten.blees@gmail.com>,
	"Felipe Contreras" <felipe.contreras@gmail.com>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 19 16:08:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXXCk-00005Z-2J
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 16:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309Ab3JSOIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 10:08:30 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:41555 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752296Ab3JSOI2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Oct 2013 10:08:28 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: An4GAOCRYlJOl3+a/2dsb2JhbABagwc4iTy1PgqBIhd0giAFAQEEAQgBAS4eAQEcBQUGAgMFAgEDFQwlFAEECBIGBxcGARIIAgECAwGHYwMJCgmsaYlFDYlrjGyBMYE/gyaBCgOPGYURgXSOO4U3gTqBazuBLA
X-IPAS-Result: An4GAOCRYlJOl3+a/2dsb2JhbABagwc4iTy1PgqBIhd0giAFAQEEAQgBAS4eAQEcBQUGAgMFAgEDFQwlFAEECBIGBxcGARIIAgECAwGHYwMJCgmsaYlFDYlrjGyBMYE/gyaBCgOPGYURgXSOO4U3gTqBazuBLA
X-IronPort-AV: E=Sophos;i="4.93,528,1378854000"; 
   d="scan'208";a="444453270"
Received: from host-78-151-127-154.as13285.net (HELO PhilipOakley) ([78.151.127.154])
  by out1.ip02ir2.opaltelecom.net with SMTP; 19 Oct 2013 15:08:25 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236400>

From: "Karsten Blees" <karsten.blees@gmail.com>
> Am 15.10.2013 00:29, schrieb Felipe Contreras:
>> tl;dr: everyone except Junio C Hamano and Drew Northup agrees; we
>> should move
>> away from the name "the index".
>>
>> It has been discussed many times in the past that 'index' is not an
>> appropriate description for what the high-level user does with it,
>> and
>> it has been agreed that 'staging area' is the best term.
>>
>
> I haven't followed the previous discussion, but if a final conclusion
> towards 'staging area' has already been reached, it should probably be
> revised.

Do you mean that how that conclusion was reached should be summarised,
or that you don't think it's an appropriate summary of the broader
weltanschauung?

>
>> The term 'staging area' is more intuitive for newcomers which are
>> more
>> familiar with English than with Git, and it seems to be a
>> straightforward mental notion for people with different mother
>> tongues.
>>
>> In fact it is so intuitive that it's used already in a lot online
>> documentation, and the people that do teach Git professionally use
>> this
>> term, because it's easier for many kinds of audiences to grasp.
>>
>
> Such online documentation often portraits the 'staging area' as some
> supposedly 'unique' git feature, which I find _very_ confusing. In
> fact, every major SCM has a staging area. E.g. you first need to
> "svn/hg/bzr/p4 add/remove/rename/move" a file, which is somehow
> recorded in the working copy. These recorded changes will then be
> picked up by a subsequent "svn/hg/bzr/p4 commit/submit".
>
> Additionally, all those systems support selectively committing
> individual files (by specifying the files on the commit command line
> or selecting them in a GUI).
>
> So git's 'unique staging area' boils down to this:
>
> 1.) Recording individual files to commit in advance (instead of
> specifying them at commit time). Which isn't that hard to grasp.

For many, that separation of preparation(s), from the final action, is
brand new and difficult to appreciate - it's special to computer systems
(where copying is 100% reliable, essentially instantaneous, and in Git's
case, 100% verifiable via crypto checksums).

>
> 2.) Recording individual diff hunks or even lines to commit. Which is
> an advanced feature that requires even more advanced commands to be
> useful (i.e. stash save --keep-index; make; test; commit; stash pop).
> It is also entirely irrelevant to binary files (i.e. for non-technical
> users that use git to track documents and stuff).
>
>> index: an 'index' is a guide of pointers to something else; a book
>> index has a list of entries so the reader can locate information
>> easily without having to go through the whole book. Git porcelain is
>> not using the staging area to find out entries quicker; it's not an
>> index.
>>
>
> The 'staging area' is a sorted list of most recently checked out
> files, and its primary purpose is to quickly detect changes in the
> working copy (i.e. its an index).
>

There is a big (human) problem here. We (humans) are able to believe
contradictory things ("He ain't heavy, he's my brother" to quote a
song). The Index (file) isn't a staging area, but we are happy to flip
flop between the two ideas depending on context - others can feel
confused.

In one sense the "Index" is an implementation detail of the concept of a
packing area where a shipment (commit) is prepared, which is most
commonly called the staging are in populist discussions (which I believe 
is the summary I mentioned above)

> Of the 28 builtin main porcelain commands, 18 read the index
> (read_index), and 11 of those also check the state of the working copy
> (ie_match_stat). Incidentally, the latter include _all_ commands that
> update the so-called 'staging area'.
>
> Subversion until recently kept the checked out files scattered in
> **/.svn/text-base directories, and many operations were terribly slow
> due to this. Subversion 1.7 introduced a new working copy format,
> based on a database in the root .svn directory (i.e. an index),
> leading to tremendous performance improvements.
>
> The git index is a major feature that facilitates the incredible
> performance we're so much addicted to...why be shy about it and call
> it something else?
>
>> stage: a 'stage' is a special area designated for convenience in
>> order
>> for some activity to take place; an orator would prepare a stage in
>> order for her speak to be successful, otherwise many people might not
>> be able to hear, or see her. Git porcelain is using the staging area
>> precisely as a special area to be separated from the working
>> directory
>> for convenience.
>>
>
> I'm not a native speaker, but in my limited understanding, 'staging'
> in computer jargon is the process of preparing data for a production
> system (i.e. until the 'stage' or 'state' of the data is ready for
> production). It has nothing to do with the 'stage' in a theater. I've
> never heard the term 'staging' beeing used for source code or software
> (that would be 'integration'). I've also never heard 'staging' for
> moving data back from a production system to some work- or development
> area.

Even 'native' speakers don't have a single consistent term for the
concept. Terms are stolen from many varied industries and activities
that have to prepare and package items (Ships, Trains, Theaters)
(see http://en.wikipedia.org/wiki/Shipping_list, for a shortish list, 
which doesn't mention an Index)

>
> In any sense, 'staging' is a unidirectional process (even in a
> theater). If I think of the index as a staging area, it covers just a
> single use case: preparing new commits. With this world view, it is
> completely counter-intuitive that e.g. changing branches overwrites my
> staging area.
>
> IMO, it is ok to use 'like a staging area' when we talk about using
> the index to prepare new commits. However, its not ok to use 'staging
> area' as a general synonym for the index.

As alluded to above, the developer viewpoint includes a perception of
how we implement the preparation of commits, and how 'we' have come to
fix on the term 'index'.

In one sense even that is not the right term - If compared to a book /
pamphlet / monograph (being placed in a Library / repository)  it's more 
of a contents list (by chapter and verse / directory and file), with 
various bits of front matter such as author, publisher, previous 
editions, introductory preface, dates, contents list, and finally 
content. A book's 'index' is a supplementary mini grep of useful terms 
that the reader may wish to find.

All in all it's difficult to undo this Gordian knot of confusions.

>
> Just my 2 cents
> Karsten
>
The key is probably to separate the devlopers concerns over 
implementation details from the user's big picture view, in an arena 
that is short of well (commonly) understood terms.

Philip
