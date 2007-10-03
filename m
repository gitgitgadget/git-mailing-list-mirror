From: David Kastrup <dak@gnu.org>
Subject: Re: [msysGit] Re: WIP: asciidoc replacement
Date: Wed, 03 Oct 2007 14:02:10 +0200
Message-ID: <854ph8v22l.fsf@lola.goethe.zz>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site>
	<7vprzwhkgd.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0710031239410.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 14:03:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id2vg-0007PQ-9F
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 14:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713AbXJCMCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 08:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755120AbXJCMCH
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 08:02:07 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:51326 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803AbXJCMCG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 08:02:06 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1Id2uf-0006wO-5l; Wed, 03 Oct 2007 08:01:13 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id D79961C4CE11; Wed,  3 Oct 2007 14:02:10 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0710031239410.28395@racer.site> (Johannes Schindelin's message of "Wed\, 3 Oct 2007 12\:50\:01 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59830>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 2 Oct 2007, Junio C Hamano wrote:
>
>> 
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > So here it is: a perl script that does a good job on many .txt files 
>> > in Documentation/, although for some it deviates from "make man"'s 
>> > output, and for others it is outright broken.  It is meant to be run 
>> > in Documentation/.
>> >
>> > My intention is not to fix the script for all cases, but to make 
>> > patches to Documentation/*.txt themselves, so that they are more 
>> > consistent (and incidentally nicer to the script).
>> 
>> How you spend your time is up to you, but I need to wonder...
>> 
>>  - Is "man" format important for msysGit aka Windows
>>    environment?  I had an impression that their helpfile format
>>    were closer to "html" output.
>
> I wanted something that can output both "man" and "html" output (and
> if some suck^Wlos^Wtexi-fan wants to provide it, also a "texi" or
> even "info" backend).

And you have not even talked about print.  The thing is that high
quality output is a lot of work (including design and design
decisions) for _every_ _single_ backend.  If the only target were
"man" and text, then one would be better off writing as groff source
and be done.

We really can't afford another time sink.  That nobody can actually
solve structural problems ("how do we include the man pages as an
appendix in the user manual?") also implies a waste of time, but at
some point of time people just throw up their hands and give up in
disgust.

You propose a larger time sink where people won't be forced to give
up.  But we really don't want to waste time reinventing the wheel.  It
would be better spent communicating with the wheelbuilders.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
