From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] git-fetch: more terse fetch output
Date: Sun, 4 Nov 2007 10:56:40 +0100
Message-ID: <EB9F9DF7-0D71-4542-9049-5C0942304076@zib.de>
References: <alpine.LFD.0.9999.0711030101340.21255@xanadu.home> <alpine.LFD.0.999.0711031229470.15101@woody.linux-foundation.org> <alpine.LFD.0.9999.0711031627000.21255@xanadu.home> <20071103204000.GA24959@glandium.org> <alpine.LFD.0.9999.0711031645350.21255@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=WINDOWS-1252;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 10:56:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IocDv-0003Wm-1U
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 10:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbXKDJ4N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 04:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754622AbXKDJ4L
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 04:56:11 -0500
Received: from mailer.zib.de ([130.73.108.11]:34556 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754428AbXKDJ4J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 04:56:09 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA49tLdH023360;
	Sun, 4 Nov 2007 10:55:21 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1be86.pool.einsundeins.de [77.177.190.134])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA49tJpS010868
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 4 Nov 2007 10:55:19 +0100 (MET)
In-Reply-To: <alpine.LFD.0.9999.0711031645350.21255@xanadu.home>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63373>


On Nov 3, 2007, at 9:50 PM, Nicolas Pitre wrote:

> On Sat, 3 Nov 2007, Mike Hommey wrote:
>
>> On Sat, Nov 03, 2007 at 04:30:27PM -0400, Nicolas Pitre wrote:
>>> On Sat, 3 Nov 2007, Linus Torvalds wrote:
>>>
>>>>
>>>>
>>>> On Sat, 3 Nov 2007, Nicolas Pitre wrote:
>>>>>
>>>>> Receiving objects: 100% (5439/5439), 1.60 MiB | 636 KiB/s, done.
>>>>
>>>> I mostly like this, but can we please just use "MB/kB" instead of
>>>> "MiB/KiB"?
>>>>
>>>> I hope it was some kind of joke on crazy EU bureaucrats that =20
>>>> just wasn't
>>>> caught in time.
>>>
>>> I don't care either ways.  In fact my own preference is for MB/=20
>>> kB, but
>>> if I had used that first I'm sure someone else would have asked =20
>>> for the
>>> purist notations.
>>
>> As far as you don't claim 1MB is 1024KB, it's okay.
>
> [ heh, I knew someone would say something ]
>
> Yes, to me, 1MB is 1024 KB.  Always been, until those idiotic hard =20
> disk
> manufacturers decided to redefine the common interpretation of what
> everyone else used to consider what a MB is just to boost their
> marketing claims.

I believe it doesn't matter what prefix we use for a
_progress indicator_, as long as we use the same prefix for
the the amount already transferred and the bandwidth. A precise
language doesn't matter here.

Here is a short excerpt from a discussion of the standard.
I haven't downloaded the full document "IEEE Trial-Use Standard
for Prefixes for Binary Multiples" but copied from Wikipedia <http://=20
en.wikipedia.org/wiki/Binary_prefix>:


=93This standard is prepared with two goals in mind: (1) to
preserve the SI prefixes as unambiguous decimal multipliers and
(2) to provide alternative prefixes for those cases where binary
multipliers are needed. The first goal affects the general
public, the wide audience of technical and nontechnical persons
who use computers without much concern for their construction
or inner working. These persons will normally interpret kilo,
mega, etc., in their proper decimal sense. The second goal
speaks to specialists=97the prefixes for binary multiples make
it possible for persons who work in the information sciences
to communicate with precision.=94


Binary multiplier make it possible to communicate with
precision. If you use the binary prefixes it is absolutely
clear what you are talking about. The meaning of the old
prefixes depend on the context.

But all this does not matter here. We are talking about a
progress indicator. Precision doesn't matter. The user wants
to be sure that something is happening and get an idea of how
much longer it will take to finish the fetch. An approximation
is sufficient.

What matters though is saving two characters, because the line
width is limited. So lets take "MB, kB".

	Steffen
