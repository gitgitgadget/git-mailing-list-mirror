From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: [ANNOUNCE] Java Git (aka jgit) has switched to 3-clause BSD
Date: Mon, 26 May 2008 13:22:25 +0200
Message-ID: <19f34abd0805260422m6d8c414dy746623ed609440eb@mail.gmail.com>
References: <20080526044640.GB30245@spearce.org>
	 <19f34abd0805260113w1341a26bg140d1dbb7438bf46@mail.gmail.com>
	 <alpine.DEB.1.00.0805261106470.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>,
	"Dave Watson" <dwatson@mimvista.com>,
	"Marek Zawirski" <marek.zawirski@gmail.com>, git@vger.kernel.org,
	laforge@gnumonks.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 26 13:23:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0anP-0000fO-Ge
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 13:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbYEZLW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 07:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbYEZLW1
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 07:22:27 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:16010 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377AbYEZLW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 07:22:26 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2295526rvb.1
        for <git@vger.kernel.org>; Mon, 26 May 2008 04:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=G1x2nPeXFD545bEv3LmfGmJdUjC0Y9w2nnhz9UdKYOk=;
        b=fyG7JrawPN5oZUHsG2JC4R3vICWmKFuCdMmk/f0C5kkKhxyjQAClPZdm0pun+W9Sq3klvG0EJdYz5umt5babcc/cdJ7rx5kd/vpqmYUZg+K2RAEnT2aUFFlHrGApu3gX4cpBNsI+nqChyQTDSZgDTr96i9TnAdxOyvjCkCxhhFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fqdb09subg4eqtDQMEpU1tCzWY8qi8eb/+ZftfZkNFgDKi4WeBr/vg4Yy2AMe51CKb1+5Z1DOBhfGdtspCOhT3Q2bd/EQj8QpPUm4aO4aSahVbhOKi9t84eUnDxyRjBjcMWeKJ+ozsFxG5X2YY68wZ3EyKv+YrZLeP8L42HHhgc=
Received: by 10.141.168.7 with SMTP id v7mr1022802rvo.224.1211800945982;
        Mon, 26 May 2008 04:22:25 -0700 (PDT)
Received: by 10.141.145.9 with HTTP; Mon, 26 May 2008 04:22:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805261106470.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82922>

Hi,

On Mon, May 26, 2008 at 12:08 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Mon, 26 May 2008, Vegard Nossum wrote:
>
>> On Mon, May 26, 2008 at 6:46 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
>> > As of 53a2cc3 the jgit library (a 100% pure Java implementation
>> > of git) is now licensed under a 3-clause (new-style) BSD license.
>> > The change was done with a Perl script to rewrite all source code
>> > headers within the org.spearce.jgit package.  Copyright information
>> > was updated based upon the output of git-blame.
>>
>> I previously read about this transition from GPL to BSD.
>>
>> IANAL, but isn't the current version a derivative of the older
>> version, meaning that you need to take all authors into account when
>> doing this switch, and not just the authors of the _current_ code?
>>
>> (Or did you get a consent from all previous authors as well as current
>> authors?)
>
> He did.  That is what is written in the thread that Shawn explicitely
> stated in the part that you did _not_ quote.

Hm, yes, that is the thread I read before. What Shawn writes there is this:

"As of the bleeding edge (40c5c6cb11b8cc6caf3ea6a681caf0a6b8d66f36
[*4*]) the ownership of all currently surviving lines of code is
broken down as follows:"

This seems to suggest that only authors of the "bleeding edge" are
considered, while my point was that the "bleeding edge" may be a
derivative of earlier versions which had other authors as well.

I can't find anywhere explicitly mentioned in the thread that _all_
authors have been asked about the change of license.

> I also have to wonder why you chose a total technical non-issue, that does
> not really concern you (because you are noone of said authors), for your
> first post (at least that I am aware of) to this list.

It does concern me, because I enjoy git and free software in general.
I am not trolling or trying to stop the change of license in any way,
but simply give a heads up to what I believe might potentially be a
legal issue. Maybe there are in fact no other authors that have
participated, but in that case I think it is a fact worthy of explicit
mention.

This was also not my first post to this list; you have even replied to
one of my posts yourself once upon a time :-)


Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
