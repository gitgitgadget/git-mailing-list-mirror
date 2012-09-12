From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: [PATCH 3/3] sha1: use char type for temporary work buffer
Date: Wed, 12 Sep 2012 22:42:29 +0200
Organization: OPTEYA
Message-ID: <1347482549.1961.9.camel@test.quest-ce.net>
References: <cover.1347442430.git.ydroneaud@opteya.com>
	 <a8c30a998cad6a7b38bd983e7689a628567a8176.1347442430.git.ydroneaud@opteya.com>
	 <7v8vcfccbn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 22:42:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBtlg-0001eQ-D6
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 22:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217Ab2ILUmc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Sep 2012 16:42:32 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:59719 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab2ILUmb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Sep 2012 16:42:31 -0400
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Sep 2012 16:42:31 EDT
Received: from [127.0.0.1] (helo=localhost)
	by mx-out.ocsa-data.net with esmtp (Exim - FreeBSD Rulez)
	id 1TBtlW-00030u-7Z; Wed, 12 Sep 2012 22:42:30 +0200
Received: from mx-out.ocsa-data.net ([127.0.0.1])
	by localhost (node2-2.ouvaton.local [127.0.0.1]) (amavisd-new, port 10028)
	with ESMTP id mQV5w0bKZWTT; Wed, 12 Sep 2012 22:42:30 +0200 (CEST)
Received: from [82.233.246.172] (helo=[192.168.0.25])
	by mx-out.ocsa-data.net with esmtpsa (Exim - FreeBSD Rulez)
	id 1TBtlV-00030m-9S; Wed, 12 Sep 2012 22:42:30 +0200
In-Reply-To: <7v8vcfccbn.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.4.4 (3.4.4-1.fc17) 
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-20 required=2
	tests=[ALL_TRUSTED=-1.44]
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205333>

Le mercredi 12 septembre 2012 =C3=A0 11:42 -0700, Junio C Hamano a =C3=A9=
crit :
> Yann Droneaud <ydroneaud@opteya.com> writes:
>=20
> > The SHA context is holding a temporary buffer for partial block.
> >
> > This block must 64 bytes long. It is currently described as
> > an array of 16 integers.
> >
> > Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> > ---
>=20
> As we do not work with 16-bit integers anyway, 16 integers occupy 64
> bytes anyway.
>=20

It's unclear why this array is declared as 'int' but used as 'char'.

> What problem does this series fix?
>=20

The question I was hoping to not see asked :)
This is mostly some cosmetic fixes to improve readability and
portability.

Regards

--=20
Yann Droneaud
OPTEYA
