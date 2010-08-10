From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: wiki "abuse"
Date: Tue, 10 Aug 2010 08:38:11 +0200
Message-ID: <vpqvd7jq8fg.fsf@bauges.imag.fr>
References: <AANLkTimyyh+MyS6zpJp1_RfCOoj6yr4LHXXM_7ZiWgzf@mail.gmail.com>
	<AANLkTi=wxre8pEDPQBeA4FvGcFHKS-kBdCqDv11o=x1c@mail.gmail.com>
	<AANLkTi=GmOokrPoevARoxe16ZLpHKzaBy0tBfycJM5J2@mail.gmail.com>
	<alpine.DEB.1.00.1008091820320.8314@intel-tinevez-2-302>
	<AANLkTinEEpvJv6z1WNgoMujoZyhU8zON597mY+Bp7nV8@mail.gmail.com>
	<AANLkTin5q5WZFUXkZQ3V5Z1fQjYU2QOi5mFpn-Rb7m04@mail.gmail.com>
	<4C606E1B.6020800@lsrfire.ath.cx>
	<AANLkTikNDdi1gDaoWdHsiUPLW2CtZMP0J2c94DpLA=AV@mail.gmail.com>
	<AANLkTi=dhmxBpTehFFMZGnbTVccbMJLmzKy2V0uj9R6r@mail.gmail.com>
	<AANLkTi=dGWaRa3HR4nb6Ka1+0CovrBMnyZts5d8RZW1c@mail.gmail.com>
	<AANLkTimb4gp1azHd-r8MiQqeWC0OJhQLOUjsw2x=vA=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Git List <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 08:38:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiiTp-0007TK-BM
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 08:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381Ab0HJGi2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 02:38:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52455 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117Ab0HJGi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 02:38:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o7A6ZkJO032427
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 10 Aug 2010 08:35:46 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OiiTT-0005yT-M0; Tue, 10 Aug 2010 08:38:11 +0200
In-Reply-To: <AANLkTimb4gp1azHd-r8MiQqeWC0OJhQLOUjsw2x=vA=g@mail.gmail.com>
 (=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Mon\, 9
 Aug 2010 23\:02\:27 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 10 Aug 2010 08:35:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7A6ZkJO032427
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1282026951.08738@yrDTVBhcArf2MZFViSgScA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153078>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> If we turn on nofollow on the wiki we remove the wiki from the link
> tree on the web, and turn it into a leaf node.

nofollow are enabled by default, and if I read the page sources
correctly, they _are_ enabled on Git's wiki (and yes, that includes
user pages).

(in case someone wants to change that, it's this in LocalSettings.php:
$wgNoFollowLinks =3D False;
)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
