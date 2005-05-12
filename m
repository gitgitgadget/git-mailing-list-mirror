From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 19:41:03 -0500
Message-ID: <200505111941.04104.dtor_core@ameritech.net>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com> <1115854733.22180.202.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu May 12 02:33:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW1dx-0008Co-EG
	for gcvg-git@gmane.org; Thu, 12 May 2005 02:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVELAlJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 11 May 2005 20:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVELAlJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 20:41:09 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:16823 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261221AbVELAlH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2005 20:41:07 -0400
Received: from unknown (HELO core.corenet.prv) (dtor?core@ameritech.net@68.23.10.155 with plain)
  by smtp812.mail.sc5.yahoo.com with SMTP; 12 May 2005 00:41:06 -0000
To: git@vger.kernel.org, tglx@linutronix.de
User-Agent: KMail/1.8
In-Reply-To: <1115854733.22180.202.camel@tglx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wednesday 11 May 2005 18:38, Thomas Gleixner wrote:
> On Wed, 2005-05-11 at 16:14 -0700, H. Peter Anvin wrote:
> > I would like to suggest a few limiters are set on the repoid. =C2=A0=
In=20
> > particular, I'd like to suggest that a repoid is a UUID, that a fil=
e is=20
> > used to track it (.git/repoid), and that if it doesn't exist, a new=
 one=20
> > is created from /dev/urandom.
>=20
> Which is complety error prone due to rsync. Some of the repositories =
on
> kernel.org keep identical copies of .git/description already. Why sho=
uld
> they preserve an unique .git/repoid ?

I think that an unique repoid should be created automatically every tim=
e
you clone. It is ok for it to go away when you discard a tree, it will =
just
identify a line (set) of changes originating from some place.

--=20
Dmitry
