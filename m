From: Wincent Colaiuta <win@wincent.com>
Subject: Re: asciidoc 8
Date: Mon, 18 Feb 2008 08:43:14 +0100
Message-ID: <54BC65FA-F388-458F-9610-76B7C1413AD3@wincent.com>
References: <47B8CFFF.6090902@saville.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 08:44:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR0fJ-0001Lo-Fi
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 08:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbYBRHnT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Feb 2008 02:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924AbYBRHnT
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 02:43:19 -0500
Received: from wincent.com ([72.3.236.74]:33034 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753606AbYBRHnS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Feb 2008 02:43:18 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m1I7hF35005615;
	Mon, 18 Feb 2008 01:43:16 -0600
In-Reply-To: <47B8CFFF.6090902@saville.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74238>

El 18/2/2008, a las 1:23, Wink Saville escribi=F3:

> I ran into the asciidoc 8 issue where some of the docs don't
> get generated properly on my system with asciidoc 8.2.1.
>
> Should I just downgrade? What would be the "best" version
> to use.

I ran into problems with 8 a while ago, poked around for a while, =20
couldn't find the cause of the problem, and so downgraded to the 7 =20
series (don't recall the exact version, but it was the last release in =
=20
the 7 series). I figured this was just the simplest thing to do seeing =
=20
as the official manual page archives are generated with 7, as far as I =
=20
know.

I know that later a fix for the breakage that I was seeing was checked =
=20
in (see 5162e69), so in theory 8 should be fine now (at least, the =20
latest version of it, but I see you're using an older version which =20
probably isn't affected by the link problem). What problem are you =20
seeing? What version of Git are you using?

Cheers,
Wincent
