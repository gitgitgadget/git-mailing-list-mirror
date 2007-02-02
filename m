From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: How to configure your MTA [Was: [PATCH] fix some doc typos and grammar]
Date: Fri, 2 Feb 2007 12:43:29 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070202114329.GA5081@cepheus>
References: <3c6c07c20702012225v19b7aa66vc98a028f700914db@mail.gmail.com> <7vmz3xjbxv.fsf@assigned-by-dhcp.cox.net> <3c6c07c20702012326h551b9f32gb3d8238361105741@mail.gmail.com> <epv761$gc1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 12:43:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCwpY-0001eU-KE
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 12:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbXBBLnm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 2 Feb 2007 06:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbXBBLnm
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 06:43:42 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:40071 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751947AbXBBLnl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Feb 2007 06:43:41 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HCwpQ-000016-9G; Fri, 02 Feb 2007 12:43:40 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l12BhXCb010784;
	Fri, 2 Feb 2007 12:43:33 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l12BhWvi010783;
	Fri, 2 Feb 2007 12:43:32 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <epv761$gc1$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38493>

Hello,

Jakub Narebski wrote:
> > This makes git-send-email work directly, and avoids the gmail web M=
UA.
>=20
> It is fairly easy to do the same with sendmail (which is default MTA
> for many Linux distributions). I have googled the answer thanks to
> some tips on #git channel. You have to change /etc/mail/sendmail.mc
> (or the file where SMART_HOST is commented out), add your credentials
> to /etc/mail/authinfo, then compile changes using "make -C /etc/mail"
> (all of it as root, I think).
>=20
> Your credential should have the form (in /etc/mail/authinfo)
>=20
>   AuthInfo:smtp.gmail.com "U:username@gmail.com" "P:password" "M:PLAI=
N"
>   AuthInfo: "U:username@gmail.com" "P:password" "M:PLAIN"
I'd prefer a MTA that is able to do this on a per-user basis.  My wish
is something like procmail, but for sending.  Some time ago I searched
for such an MTA, but unsuccessful.  Does anyone know such a server?

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

dd if=3D/proc/self/exe bs=3D1 skip=3D1 count=3D3 2>/dev/null
