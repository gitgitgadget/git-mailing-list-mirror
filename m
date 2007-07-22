From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sun, 22 Jul 2007 19:59:14 +0200
Message-ID: <85tzrwiakt.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<851wf2bcqy.fsf@lola.goethe.zz>
	 =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.07072=0402135450?= =?ISO-8859-1?Q?.27249?=
	=?ISO-8859-1?Q?@woody.linux-fou?= =?ISO-8859-1?Q?ndation.org>?=
	<alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org>
	<85odi69vgt.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707210832180.27249@woody.linux-foundation.org>
	<85tzrxslms.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707211650190.3607@woody.linux-foundation.org>
	<85644dqoig.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707211737090.3607@woody.linux-foundation.org>
	<85r6n1p7sb.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707211840000.3607@woody.linux-foundation.org>
	<85fy3hp3f2.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707212040340.3607@woody.linux-foundation.org>
	<85abtpoydg.fsf@lola.goethe.zz>
	<Pine.LNX.4.64.0707212332530.6350@asgard.lang.hm>
	<851wf0pzyt.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707221029160.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 19:59:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICfiD-0000YK-AS
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 19:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756266AbXGVR7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 13:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755753AbXGVR7S
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 13:59:18 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:40486 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753362AbXGVR7R (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 13:59:17 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 28AA524B41B;
	Sun, 22 Jul 2007 19:59:16 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 0C25613ED00;
	Sun, 22 Jul 2007 19:59:16 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-022-107.pools.arcor-ip.net [84.61.22.107])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id B8600212F82;
	Sun, 22 Jul 2007 19:59:15 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id CCB7C1D1E182; Sun, 22 Jul 2007 19:59:14 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0707221029160.3607@woody.linux-foundation.org> (Linus Torvalds's message of "Sun\, 22 Jul 2007 10\:30\:06 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3729/Sun Jul 22 18:10:33 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53282>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 22 Jul 2007, David Kastrup wrote:
>>
>> Sigh.  No, I don't want to track every directory.  I want to have
>> every directory _trackable_.
>
> And they already are.

Their contents are.

> Your point is pointless. You don't understand the git data
> structures, and you are trying to do something that makes no sense.

That makes no sense to you and apparently quite a few other people,
after a lot of explaining.  That does not mean that it wouldn't work,
but it does mean that it is going nowhere: it is irrelevant whether I
consider the concept easy to understand and explain when nobody else
does: that makes it unmaintainable.

Fortunately, a few other participants, notably Junio and Jakub, have
focused a bit more on technical details rather than my sanity in their
somewhat more nuanced feedback, and thus I have (in a separate thread)
made a new proposal that addresses a few technical shortcomings and
that does no longer require splitting tree-ness/directory-ness into
separate concepts and records, something which I considered elegant
and others gibberish.

It boils down to encoding the "don't-evaporate-when-empty" or "I told
you to keep track of it" property in the directory access permissions:
if those are zero, git does not track the corresponding directory and
will attempt a remove-on-empty.  If they are non-zero (probably 755 as
long as git stores only a sanitized version of the actual state
there), this means that git has been told to track the directory and
will not attempt to delete it until it is told to stop tracking it
again.

The proposal of allowing "." "!." as a gitignore pattern to specify
the tracking/non-tracking indicator does still stand, but its
semantics are now so much decoupled from that of
"don't-evaporate-when-empty" that the code would not actually overlap
with that of the tracking, and so discussing it is orthogonal to the
actual proposal and can be postponed separately, and an implementation
proferred separately once the rest is in place.

So do both of us a favor and skip the rest of the mail queue with
"Empty directories..." in its title.

Actually, the code (and later comments for it) you produced matches
the areas of work and what I think needs to be done quite closer now
than with my original proposal.

So while the discussion with you has not really been much of a help
except to show without reasonable doubt that my original approach
would have been unmaintainable by other persons, the code _is_ very
helpful.

Thanks,

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
