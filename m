From: David Kastrup <dak@gnu.org>
Subject: Re: WIP: asciidoc replacement
Date: Wed, 03 Oct 2007 16:01:44 +0200
Message-ID: <85bqbgthyv.fsf@lola.goethe.zz>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site>
	<7vprzwhkgd.fsf@gitster.siamese.dyndns.org>
	<39F3EE1B-7BD4-4927-AB90-2EB4BBAF05D0@wincent.com>
	<85abr0y5ua.fsf@lola.goethe.zz>
	<1D18C52E-BB96-49EC-97A9-F802D56CAFF5@wincent.com>
	<85k5q4v6jb.fsf@lola.goethe.zz> <20071003134741.GQ21675@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 16:01:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id4n7-0006BB-2y
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 16:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761AbXJCOBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 10:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbXJCOBY
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 10:01:24 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:51268 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbXJCOBX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 10:01:23 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1Id4m6-0002co-TS; Wed, 03 Oct 2007 10:00:31 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id B7BDA1C4CE11; Wed,  3 Oct 2007 16:01:44 +0200 (CEST)
In-Reply-To: <20071003134741.GQ21675@fieldses.org> (J. Bruce Fields's message of "Wed\, 3 Oct 2007 09\:47\:41 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59840>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Wed, Oct 03, 2007 at 12:25:44PM +0200, David Kastrup wrote:
>
>> The problem is that we are not editing plain text, but Docbook
>> source masquerading as plain text.
>
> I do a fair amount of editing of the asciidoc source, but 99% of it
> is done by just blind imitation of what's already there.

But not everything is already there, and when something surprising
happens, there is little chance to see how it came about.

> Maybe my experience would be the same with Docbook--I have no idea,
> never having worked with it--but if you're suggesting that knowledge
> of Docbook is a prerequisite for working with asciidoc, that
> certainly hasn't been my experience.

"making use of" and "working with" are two different things.

>> But it is not all _all_ easily writeable the moment you try to do
>> something with _structural_ impact.  In fact, it is pretty much
>> impossible for anybody except wizards to do that.  And when the
>> wizards do it, they can't actually document what they have been
>> doing since that would mean cluttering the purported "plain text
>> documentation" with formatting comments.
>
> I'm not sure what you're talking about here.  Example?

Try including the manual pages as a (properly linked when man pages
are referenced) appendix in the user manual, so that the printed form
(or PDF) of the user manual is a single coherent document with all
information inside.  That's what I tried for about a week, digging
into the various available (and unavailable) documentation and then
postponing the project indefinitely because it both exceeded my
current capability as well as demonstrating that there was no
reasonably outlined path for acquiring the necessary skills.

In Texinfo, this takes few commands, all of which are well-documented
and in a reasonable place in the Texinfo manual (which is all you need
to consult in order to write Texinfo documents).

But with git's AsciiDoc information, not only is the required
information scattered through half a dozen of different manuals all
describing completely different systems, but the necessary other
documentation is, at best, only mentioned in passing in every single
relevant document.  So while you may know where you want to start and
end your journey, there is nothing which would tell you how to get
from start to end.  You have to randomly pick your road until you may
or may not find something closer to the end.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
