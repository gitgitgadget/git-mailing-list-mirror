From: mkraai@beckman.com
Subject: Re: Email address from username and hostname preferred over $EMAIL
Date: Thu, 5 Jul 2007 13:48:41 -0700
Message-ID: <OFFAD14F99.03920E32-ON8825730F.006FFB5F-8825730F.00725068@beckman.com>
References: <20070705202140.GA24349@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_mixed 007250608825730F_="
Cc: git@vger.kernel.org
To: "Pierre Habouzit" <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jul 05 22:48:50 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6YFu-0004L7-0U
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 22:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760266AbXGEUsr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 16:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760543AbXGEUsr
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 16:48:47 -0400
Received: from svfulbcimail.beckman.com ([134.217.237.26]:34786 "EHLO
	mailgateful1.beckman.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758480AbXGEUsq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jul 2007 16:48:46 -0400
X-WSS-ID: 0JKQ4NF-04-066-01
Received: from mailgateful2.beckman.com (unknown [10.12.37.100])
	by mailgateful1.beckman.com (Tumbleweed MailGate) with ESMTP id 3D72C1005A60F;
	Thu,  5 Jul 2007 13:52:26 -0700 (PDT)
X-WSS-ID: 0JKQ4MI-01-NUL-02
Received: from svfulnotes1.beckman.com (svfulnotes1.beckman.com [10.12.38.60]) by
 mailgateful2.beckman.com (Tumbleweed MailGate) with ESMTP id 2FB5C3809F29C; Thu, 5 Jul 2007
 13:51:54 -0700 (PDT)
In-Reply-To: <20070705202140.GA24349@artemis.corp>
X-Mailer: Lotus Notes Release 6.5.4 March 27, 2005
X-MIMETrack: Serialize by Router on SVFULNOTES1/BII(Release 6.5.5|November 30, 2005) at 07/05/2007
 01:54:28 PM
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51693>


--=_mixed 007250608825730F_=
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Yes, ec563e8153cba89728a271a26c8a94e7a42d8152 made user.email take=20
precedence over $EMAIL, but it also made the constructed email address=20
take precedence over $EMAIL.  It made fmt_ident prefer git_default_email=20
to $EMAIL, and git_default_email is set to the constructed email address=20
by setup_ident if it's not already set by user.email.




Pierre Habouzit <madcoder@debian.org>=20
07/05/2007 01:21 PM

To
mkraai@beckman.com
cc
git@vger.kernel.org
Subject
Re: Email address from username and hostname preferred over $EMAIL






On Thu, Jul 05, 2007 at 10:57:37AM -0700, mkraai@beckman.com wrote:
> Howdy,
>=20
> Git prefers to use an email address constructed from the username and=20
> hostname to the value of the EMAIL environment variable.  I think it=20
> should prefer the latter to the former.  This problem was introduced by=20
> ec563e8153cba89728a271a26c8a94e7a42d8152.

  no, ec563e8153cba89728a271a26c8a94e7a42d8152 is about making the
emails and usernames be taken from EMAIL iff there is none specified in
the different .gitconfig's (which is sane as $EMAIL is a system wide
default setting and that .git/config is definitely meant as an ovveride
of that setting).


--=20
=B7O=B7  Pierre Habouzit
=B7=B7O                                                madcoder@debian.org
OOO                                                http://www.madism.org


The server made the following annotations=20
---------------------------------------------------------------------------=
------
This message contains information that may be privileged or confidential an=
d=
 is the property of Beckman Coulter, Inc. It is intended only for the perso=
n=
 to whom it is addressed. If you are not the intended recipient, you are no=
t=
 authorized to read, print, retain, copy, disseminate, distribute or use =
this message or any part thereof. If you receive this message in error, =
please notify the sender immediately and delete all copies of this message.

---------------------------------------------------------------------------=
------

--=_mixed 007250608825730F_=
Content-Type: application/octet-stream;
 name=atttv2u2.dat
Content-Disposition: attachment;
 filename=atttv2u2.dat
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NClZlcnNpb246IEdudVBHIHYxLjQuNiAoR05V
L0xpbnV4KQ0KDQppRDhEQlFCR2pWTFV2R3I3VzZIdWRod1JBaStPQUtDYmRTTHg4ODhzNWZTMWZ1
TTF4QVBndElTSnF3Q2doaDRCDQoweVJNZHFmbk1UZWE5am1QNmpqWlNMcz0NCj1oWVVvDQotLS0t
LUVORCBQR1AgU0lHTkFUVVJFLS0tLS0NCg==

--=_mixed 007250608825730F_=--
