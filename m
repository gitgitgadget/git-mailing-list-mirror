From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH v4 2/2] git-gui: minor spelling fix and string factorisation.
Date: Wed, 25 Mar 2009 16:34:26 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2009-03-25-16-34-26+trackit+sam@rfc1149.net>
References: <20090324230238.GQ23521@spearce.org>
	<20090324231900.GB14967@zoy.org>
	<fabb9a1e0903250604t2909e9bbg66c6dab82dcf3333@mail.gmail.com>
	<20090325152338.GD30959@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: sam@zoy.org
X-From: git-owner@vger.kernel.org Wed Mar 25 16:37:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmVA1-0003Of-TB
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 16:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761305AbZCYPeg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 11:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761561AbZCYPeg
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 11:34:36 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:37810 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759048AbZCYPef convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 11:34:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id 2C86C10E794;
	Wed, 25 Mar 2009 16:34:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from zoidberg.rfc1149.net ([127.0.0.1])
	by localhost (zoidberg.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zhEmTIsjeAjA; Wed, 25 Mar 2009 16:34:27 +0100 (CET)
Received: from mail2.rfc1149.net (willow.rfc1149.net [IPv6:2001:6f8:37a:2::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "CAcert Class 3 Root" (verified OK))
	by zoidberg.rfc1149.net (Postfix) with ESMTPS id 3282610F0EC;
	Wed, 25 Mar 2009 16:34:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 3FEB2C40C5;
	Wed, 25 Mar 2009 16:34:26 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6sXFaHo4I31k; Wed, 25 Mar 2009 16:34:26 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 1C002C40C6; Wed, 25 Mar 2009 16:34:26 +0100 (CET)
In-Reply-To: <20090325152338.GD30959@zoy.org> (Sam Hocevar's message of "Wed\, 25 Mar 2009 16\:23\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114609>

>>>>> "Sam" =3D=3D Sam Hocevar <sam@zoy.org> writes:

Sam> On Wed, Mar 25, 2009, Sverre Rabbelier wrote:
>> Heya,
>>=20
>> On Wed, Mar 25, 2009 at 00:19, Sam Hocevar <sam@zoy.org> wrote:
>> > --- > =E2=96=81=E2=96=82=E2=96=83=E2=96=84=E2=96=85=E2=96=86=E2=96=
=87=E2=96=88
>>=20
>> I'm curious, where'd this come from?

Sam>    Just a few characters from the "Block Elements" Unicode block.
Sam> For some reason, even though my locale is en_GB.UTF-8, Mutt
Sam> insists on converting my messages to iso8859-1 when doing so does
Sam> not lose information, resulting in corrupted patches, hence my
Sam> addition of the above characters.

In what way would patches get corrupted if there is no loss of
information?

Alternately, you could use

  set send_charset=3D"utf-8"

to have mutt send mails in utf-8 only (in your .muttrc).

  Sam
--=20
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
