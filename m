From: Wincent Colaiuta <win@wincent.com>
Subject: Re: WIP: asciidoc replacement
Date: Wed, 3 Oct 2007 12:05:29 +0200
Message-ID: <1D18C52E-BB96-49EC-97A9-F802D56CAFF5@wincent.com>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site> <7vprzwhkgd.fsf@gitster.siamese.dyndns.org> <39F3EE1B-7BD4-4927-AB90-2EB4BBAF05D0@wincent.com> <85abr0y5ua.fsf@lola.goethe.zz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 12:06:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id17B-0000SX-Ip
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 12:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbXJCKFx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 06:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753013AbXJCKFx
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 06:05:53 -0400
Received: from wincent.com ([72.3.236.74]:46879 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026AbXJCKFw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2007 06:05:52 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l93A5WHa014945;
	Wed, 3 Oct 2007 05:05:32 -0500
In-Reply-To: <85abr0y5ua.fsf@lola.goethe.zz>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

El 3/10/2007, a las 10:12, David Kastrup escribi=F3:

> What with output in print, HTML, info?

Yes, that's still a problem...

> Personally, I think it might make sense to just step away from the
> AsciiDoc documentation to Docbook: plain text (without cutified
> formatting control like in AsciiDoc) can be generated _from_ Docbook.

Yes, but editing DocBook (XML) is relatively painful compared to =20
editing plain text. You either have to rely on a bloated XML-=20
validating editor or instead ask your doc authors to manually write =20
valid XML (and I totally agree with Terrence Parr that, "XML makes a =20
lousy human interface
"; see <http://www.ibm.com/developerworks/xml/library/x-sbxml.html> =20
for his full take).

I know that Linus has argued for AsciiDoc because the source *is* the =20
plain text documentation and is therefore easily readable, but for me =20
the real benefit lies in the fact that *because* the source is plain =20
text it is easily edited (ie. that the source is easily *writeable*), =20
and things like documentation patches are very neat with AsciiDoc.

Cheers,
Wincent
