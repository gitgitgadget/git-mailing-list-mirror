From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: why still no empty directory support in git
Date: Wed, 7 Jan 2009 23:12:57 -0800 (PST)
Message-ID: <alpine.DEB.2.00.0901072251420.9933@vellum.laroia.net>
References: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com> <alpine.DEB.2.00.0812300008060.31590@vellum.laroia.net> <alpine.DEB.2.00.0812300113050.22107@vellum.laroia.net> <9b18b3110812300043l55a42f6sd995f36bf857543e@mail.gmail.com>
 <alpine.DEB.2.00.0812300346040.19911@vellum.laroia.net> <20090101200651.GB6536@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 08:14:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKp61-0002tl-1q
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 08:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbZAHHNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 02:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752620AbZAHHND
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 02:13:03 -0500
Received: from rose.makesad.us ([219.105.37.19]:51958 "EHLO rose.makesad.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542AbZAHHNC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 02:13:02 -0500
Received: from vellum.laroia.net (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id C452EA02BE
	for <git@vger.kernel.org>; Thu,  8 Jan 2009 02:13:00 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by vellum.laroia.net (Postfix) with ESMTPS id 650843A62BC
	for <git@vger.kernel.org>; Wed,  7 Jan 2009 23:12:57 -0800 (PST)
X-X-Sender: paulproteus@vellum.laroia.net
In-Reply-To: <20090101200651.GB6536@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104894>

On Thu, 1 Jan 2009, Jeff King wrote:

> On Tue, Dec 30, 2008 at 03:58:46AM -0500, Asheesh Laroia wrote:
>
>> So, let's say I take your suggestion.
>>
>> $ touch ~/Maildir/new/.exists
>> $ git add ~/Maildir/new/.exists && git commit -m "La di da"
>>
>> Now a spec-compliant Maildir user agent will attempt to deliver this new
>> "email message" of zero bytes into the mail spool and assign it a message
>> UID.  Doing so will remove it from Maildir/new.
>
> No. The maildir spec says:
>
>  A unique name can be anything that doesn't contain a colon (or slash)
>  and doesn't start with a dot.
>     -- http://cr.yp.to/proto/maildir.html
>
> where a "unique name" is the filename used for a message. In practice,
> every maildir implementation I have seen ignores files starting with a
> dot. Do you have one that doesn't?

My apologies. This works just fine, and I'm a dolt.

Happy new year!

(I'm still academically interested in how to avoid the rmdir(), but as I 
said before, that's a topic for someone else to pick up now.)

-- Asheesh.

-- 
English literature's performing flea.
 		-- Sean O'Casey on P. G. Wodehouse
