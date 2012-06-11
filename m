From: nguyenhu@minatec.inpg.fr
Subject: Re: [PATCHv6 4/4] Write to $XDG_CONFIG_HOME/git/config file
Date: Tue, 12 Jun 2012 01:45:13 +0200
Message-ID: <20120612014513.Horde.cXfsRXwdC4BP1oMJ5-cA9zA@webmail.minatec.grenoble-inp.fr>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-4-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <CAJDDKr6sCrwy99-5-sOaAuNjYmnw73CicF3PyYMe8hvf38oFvg@mail.gmail.com>
 <7vipf1aty2.fsf@alter.siamese.dyndns.org> <vpqmx4bmhem.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=";";
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 12 01:45:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeEIY-0001xK-21
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 01:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917Ab2FKXpR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 19:45:17 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:57682 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752906Ab2FKXpP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 19:45:15 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 0E41F1A02F6;
	Tue, 12 Jun 2012 01:45:14 +0200 (CEST)
Received: from etu-190-212.vpn-inp.grenoble-inp.fr
 (etu-190-212.vpn-inp.grenoble-inp.fr [147.171.190.212]) by
 webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Tue, 12 Jun
 2012 01:45:13 +0200
In-Reply-To: <vpqmx4bmhem.fsf@bauges.imag.fr>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199754>



Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> a =C3=A9crit=C2=A0:

> I don't really have opinion on what Git should do on windows, but in =
any
> case, the current patches only changes the behavior if the XDG file
> exists, so it may be suboptimal on windows, but shouldn't harm window=
s
> users.

Yes, if the XDG file doesn't exist, there is no change, and the behavio=
ur is
the same, with Linux, OSX or Windows. But it is true that, although =20
windows users
will not have problems with the current patches even if they use the XD=
G file,
it is not opimized for Windows, and it would be nice to optimize the ca=
se of
Windows. For the time being, it is not the goal of this series of patch=
es.
Another patch will certainly add this optimization, I hope.
