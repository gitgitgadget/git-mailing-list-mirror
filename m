From: David Kastrup <dak@gnu.org>
Subject: Re: WIP: asciidoc replacement
Date: Wed, 03 Oct 2007 10:12:29 +0200
Message-ID: <85abr0y5ua.fsf@lola.goethe.zz>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site>
	<7vprzwhkgd.fsf@gitster.siamese.dyndns.org>
	<39F3EE1B-7BD4-4927-AB90-2EB4BBAF05D0@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 10:41:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icznj-000630-TV
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 10:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbXJCIlm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 04:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbXJCIlm
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 04:41:42 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:37887 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbXJCIll convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2007 04:41:41 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1Iczmi-0004YE-2h; Wed, 03 Oct 2007 04:40:48 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 381BA1C4CE11; Wed,  3 Oct 2007 10:12:29 +0200 (CEST)
In-Reply-To: <39F3EE1B-7BD4-4927-AB90-2EB4BBAF05D0@wincent.com> (Wincent Colaiuta's message of "Wed\, 3 Oct 2007 08\:34\:25 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59808>

Wincent Colaiuta <win@wincent.com> writes:

> El 3/10/2007, a las 6:48, Junio C Hamano escribi=F3:
>
>>  - Does it make sense in the longer term for us to maintain
>>    in-house documentation tools?  Can we afford it?
>>
>> It appears that we heard about breakages for every minor docbook
>> updates, and it is really appealing if we do not have to rely on
>> xsl toolchain for manpage generation.
>
> Indeed, especially seeing as asciidoc and the xsl toolchain are the =20
> trickiest build dependencies to install. If all that could be =20
> replaced by a single simple script like this one then that would be =20
> awesome, and probably more maintainable in the long run seeing as it =
=20
> would eliminate those intermittent breakages caused by changes in =20
> third-party tools.

What with output in print, HTML, info?  The advantage of a toolchain
in that it is flexible.  I am the first to admit that getting the
AsciiDoc/Docbook/Docbook2X toolchain to get it to do what one wants to
is like baking cake in a lightless kitchen.  But it is not like we go
through that pain without any reason.

Personally, I think it might make sense to just step away from the
AsciiDoc documentation to Docbook: plain text (without cutified
formatting control like in AsciiDoc) can be generated _from_ Docbook.

And AsciiDoc keeps us from documenting the formatting: Docbook, which
is a source format and looks it, can easily admit comments that won't
get through to the formatted versions.  Sure, the first version would
likely be generated with AsciiDoc and thus basically uncommented.

--=20
David Kastrup, Kriemhildstr. 15, 44793 Bochum
