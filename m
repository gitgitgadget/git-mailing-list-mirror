From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 3/3] config: Add --null/-z option for null-delimted output
Date: Tue, 26 Jun 2007 12:47:02 +0200
Message-ID: <20070626104701.GA12721@planck.djpig.de>
References: <200706220156.01175.jnareb@gmail.com> <11827802382221-git-send-email-frank@lichtenheld.de> <200706260129.47518.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 12:49:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I38cB-000395-4Y
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 12:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbXFZKtl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 26 Jun 2007 06:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbXFZKtl
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 06:49:41 -0400
Received: from planck.djpig.de ([85.10.192.180]:3709 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752770AbXFZKtl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 06:49:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 748D088102;
	Tue, 26 Jun 2007 12:49:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hS4hA-XGkfnQ; Tue, 26 Jun 2007 12:49:35 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 93304881B5; Tue, 26 Jun 2007 12:47:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200706260129.47518.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50957>

On Tue, Jun 26, 2007 at 01:29:46AM +0200, Jakub Narebski wrote:
> Frank Lichtenheld wrote:
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0else
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0printf("%s", key_);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0printf("%s",key_);
> > =A0=A0=A0=A0=A0=A0=A0=A0}
>=20
> That is a mistake, I think?

Indeed. I remember I saw and fixed that before sending. Must've
been a halluzination ;)

Gruesse,
--=20
=46rank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
