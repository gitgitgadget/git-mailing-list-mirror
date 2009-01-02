From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: why still no empty directory support in git
Date: Fri, 2 Jan 2009 16:31:28 -0500 (EST)
Message-ID: <alpine.DEB.2.00.0901021626580.2099@rose.makesad.us>
References: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com> <alpine.DEB.2.00.0812300008060.31590@vellum.laroia.net> <alpine.DEB.2.00.0812300113050.22107@vellum.laroia.net> <9b18b3110812300043l55a42f6sd995f36bf857543e@mail.gmail.com>
 <alpine.DEB.2.00.0812300346040.19911@vellum.laroia.net> <20090101200651.GB6536@coredump.intra.peff.net> <alpine.DEB.1.00.0901021954410.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 22:33:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIrdV-00089p-Kc
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 22:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758630AbZABVbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 16:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755528AbZABVbc
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 16:31:32 -0500
Received: from rose.makesad.us ([219.105.37.19]:56088 "EHLO rose.makesad.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758573AbZABVbc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 16:31:32 -0500
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rose.makesad.us (Postfix) with ESMTP id E8B5FA0151
	for <git@vger.kernel.org>; Fri,  2 Jan 2009 16:31:28 -0500 (EST)
X-X-Sender: paulproteus@rose.makesad.us
In-Reply-To: <alpine.DEB.1.00.0901021954410.30769@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104417>

On Fri, 2 Jan 2009, Johannes Schindelin wrote:

> Hi,

Hi

*wipes the egg off his face*

> On Thu, 1 Jan 2009, Jeff King wrote:
>
>> On Tue, Dec 30, 2008 at 03:58:46AM -0500, Asheesh Laroia wrote:
>>
>>> So, let's say I take your suggestion.
>>>
>>> $ touch ~/Maildir/new/.exists
>>> $ git add ~/Maildir/new/.exists && git commit -m "La di da"
>>>
>>> Now a spec-compliant Maildir user agent will attempt to deliver this new
>>> "email message" of zero bytes into the mail spool and assign it a message
>>> UID.  Doing so will remove it from Maildir/new.
>>
>> No. The maildir spec says:
>>
>>   A unique name can be anything that doesn't contain a colon (or slash)
>>   and doesn't start with a dot.

Oops.  I never actually tried this...

> For the record, I am using Git to manage my mails, and never had any 
> problems after installing a hook which marks new empty directories with 
> .gitignore.

I'll give that a shot, and my apologies for the noise on the list with 
regard to this particular example.

I do still believe that git shouldn't rmdir() empty directories behind the 
user's back, but with this particular use case gone I'm no longer as 
adamant as before.

My apologies for not having tested this earlier; I will test it shortly, 
but there's every reason to think that Johannes and Jeff are right!

-- Asheesh.

-- 
It's interesting to think that many quite distinguished people have
bodies similar to yours.
