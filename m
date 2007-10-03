From: David Kastrup <dak@gnu.org>
Subject: Re: WIP: asciidoc replacement
Date: Wed, 03 Oct 2007 12:25:44 +0200
Message-ID: <85k5q4v6jb.fsf@lola.goethe.zz>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site>
	<7vprzwhkgd.fsf@gitster.siamese.dyndns.org>
	<39F3EE1B-7BD4-4927-AB90-2EB4BBAF05D0@wincent.com>
	<85abr0y5ua.fsf@lola.goethe.zz>
	<1D18C52E-BB96-49EC-97A9-F802D56CAFF5@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 12:25:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id1Q7-0006t3-5d
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 12:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbXJCKZ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 06:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752672AbXJCKZ0
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 06:25:26 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:56898 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbXJCKZZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2007 06:25:25 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1Id1P6-0005Tc-Kn; Wed, 03 Oct 2007 06:24:32 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 7114D1C4CE11; Wed,  3 Oct 2007 12:25:44 +0200 (CEST)
In-Reply-To: <1D18C52E-BB96-49EC-97A9-F802D56CAFF5@wincent.com> (Wincent Colaiuta's message of "Wed\, 3 Oct 2007 12\:05\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59817>

Wincent Colaiuta <win@wincent.com> writes:

> El 3/10/2007, a las 10:12, David Kastrup escribi=F3:
>
>> What with output in print, HTML, info?
>
> Yes, that's still a problem...
>
>> Personally, I think it might make sense to just step away from the
>> AsciiDoc documentation to Docbook: plain text (without cutified
>> formatting control like in AsciiDoc) can be generated _from_ Docbook=
=2E
>
> Yes, but editing DocBook (XML) is relatively painful compared to
> editing plain text.

The problem is that we are not editing plain text, but Docbook source
masquerading as plain text.

> You either have to rely on a bloated XML- validating editor or
> instead ask your doc authors to manually write valid XML (and I
> totally agree with Terrence Parr that, "XML makes a lousy human
> interface "; see
> <http://www.ibm.com/developerworks/xml/library/x-sbxml.html> for his
> full take).
>
> I know that Linus has argued for AsciiDoc because the source *is*
> the plain text documentation and is therefore easily readable, but
> for me the real benefit lies in the fact that *because* the source
> is plain text it is easily edited (ie. that the source is easily
> *writeable*), and things like documentation patches are very neat
> with AsciiDoc.

But it is not all _all_ easily writeable the moment you try to do
something with _structural_ impact.  In fact, it is pretty much
impossible for anybody except wizards to do that.  And when the
wizards do it, they can't actually document what they have been doing
since that would mean cluttering the purported "plain text
documentation" with formatting comments.

Maybe it would help to rename *.txt to *.asciidoc and generate *.txt
in future.  That would at least make it possible to document stuff in
the AsciiDoc source, and also would make it possible to add indexing
info and other stuff without cluttering up the plain text use case.

--=20
David Kastrup, Kriemhildstr. 15, 44793 Bochum
