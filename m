From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Color support added to git-add--interactive.
Date: Sat, 13 Oct 2007 22:36:55 +0200
Message-ID: <8DDFBF9A-2C68-404B-843C-BE63C52F0DAF@wincent.com>
References: <471045DA.5050902@gmail.com> <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com> <20071013172745.GA2624@coredump.intra.peff.net> <20071013175127.GA3183@coredump.intra.peff.net> <47112491.8070309@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 22:38:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgnkH-0004NQ-A2
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 22:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757999AbXJMUht convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Oct 2007 16:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756967AbXJMUht
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 16:37:49 -0400
Received: from wincent.com ([72.3.236.74]:47022 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472AbXJMUht convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Oct 2007 16:37:49 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9DKbLOY021911;
	Sat, 13 Oct 2007 15:37:22 -0500
In-Reply-To: <47112491.8070309@gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60776>

El 13/10/2007, a las 22:03, Dan Zwell escribi=F3:

> The importance of the diff coloring pales in comparison to the =20
> prompt coloring. Diff coloring is useful, but prompt coloring is a =20
> basic usability concern (if people can't easily tell where a hunk =20
> begins, the tool becomes annoying). Perhaps we could split this =20
> into two patches, merging the first after a few small changes can =20
> be taken care of, while the second may need more discussion and =20
> testing. The coloring of the prompts is relatively low risk. It =20
> just needs to be modified to take color settings from .git/config. =20
> I was thinking that this might be the example that I would take =20
> settings from:
>
> [color]
>         add-interactive =3D auto
> [color "add-interactive"]
>         prompt =3D bold blue
>         header =3D bold
>         help =3D blue

Or could you just piggy-back on the settings for color.diff.<slot>?

And if a separate group for git-add is necessary, perhaps "add" would =20
be enough, rather than "add-interactive".

Wincent
