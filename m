From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
Subject: Re: Handle HTTP error 511 Network Authentication Required (standard
 secure proxy authentification/captive portal detection)
Date: Mon, 20 Feb 2012 16:34:19 +0100
Message-ID: <e1d3ddd965eb32717163aaa87fa71e17.squirrel@arekh.dyndns.org>
References: <4b8f33ba4c870528a82ab85d6dad68bd.squirrel@arekh.dyndns.org>
    <20120220010617.GB4140@sigill.intra.peff.net>
    <9cd657a3c4960a8c496515a03bbf623e.squirrel@arekh.dyndns.org>
    <20120220135639.GA5131@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 16:34:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzVG8-0005dg-Hv
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 16:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab2BTPec convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 10:34:32 -0500
Received: from smtpout5.laposte.net ([193.253.67.230]:38087 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657Ab2BTPeb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 10:34:31 -0500
Received: from arekh.dyndns.org ([88.174.226.208])
	by mwinf8509-out with ME
	id cFaR1i0064WQcrc03FaRgX; Mon, 20 Feb 2012 16:34:26 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by arekh.dyndns.org (Postfix) with ESMTP id 42BC07032;
	Mon, 20 Feb 2012 16:34:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at arekh.dyndns.org
Received: from arekh.dyndns.org ([127.0.0.1])
	by localhost (arekh.okg [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3x9lOHteoBuP; Mon, 20 Feb 2012 16:34:20 +0100 (CET)
Received: from arekh.dyndns.org (localhost.localdomain [127.0.0.1])
	by arekh.dyndns.org (Postfix) with ESMTP;
	Mon, 20 Feb 2012 16:34:19 +0100 (CET)
Received: from 163.116.6.10
        (SquirrelMail authenticated user nim)
        by arekh.dyndns.org with HTTP;
        Mon, 20 Feb 2012 16:34:19 +0100
In-Reply-To: <20120220135639.GA5131@sigill.intra.peff.net>
User-Agent: SquirrelMail/1.4.22-4.fc17
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191078>


Le Lun 20 f=C3=A9vrier 2012 14:56, Jeff King a =C3=A9crit :
> On Mon, Feb 20, 2012 at 06:38:54AM +0100, Nicolas Mailhot wrote:
>
>> > As a non-browser client, what should git do? We can't make sense o=
f the
>> > content at http://login.corporatenetwork, which is most likely an =
HTML
>> > form asking for credentials (or even money, if the captive portal =
is
>> > something like a public wireless provider). The best we can probab=
ly do
>> > is die and say "apparently you need to go http://login.corporatene=
twork
>> > in a browser before making your request".
>>
>> Actually, the best would be to launch something capable of interpret=
ing html
>> forms on the url given by the error.
>
> Doing that portably is near impossible (keep in mind that git runs on
> things like antique versions of Solaris).

Can't the you let the user specify a browser command (firefox, elinks w=
3m) to
auto-feed the portal page to when needed ?

The main problem with captive portals is when they shut down the connec=
tion
and the user has no idea how to restore it (and error 511 is intended t=
o fix
this, but that won't do a lot of good if the user does is not shown the
captive portal url transmitted with the error)

Regards,

--=20
Nicolas Mailhot
