From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Using kdiff3 to compare two different revisions of a folder
Date: Sun, 17 Feb 2008 11:51:13 +0100
Message-ID: <20080217105113.GC13178@efreet.light.src>
References: <b8bf37780802121744i62849a53rfa71cc0571aec3a@mail.gmail.com> <200802132338.18449.robin.rosenberg.lists@dewire.com> <b8bf37780802131636q698ebb21kc415328c04d8425d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?QW5kcsOp?= Goddard Rosa <andre.goddard@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 11:52:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQh8S-0003dV-18
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 11:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756042AbYBQKva convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Feb 2008 05:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756070AbYBQKva
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 05:51:30 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:36806 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756024AbYBQKvX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 05:51:23 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 955E557A46;
	Sun, 17 Feb 2008 11:51:21 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id KMNUWIztqbh2; Sun, 17 Feb 2008 11:51:19 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id B031057486;
	Sun, 17 Feb 2008 11:51:17 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1JQh73-0004kn-WC; Sun, 17 Feb 2008 11:51:14 +0100
Content-Disposition: inline
In-Reply-To: <b8bf37780802131636q698ebb21kc415328c04d8425d@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74116>

On Wed, Feb 13, 2008 at 22:36:34 -0200, Andr=C3=A9 Goddard Rosa wrote:
> > >     Is there a better way to do this kind of comparison?
> >
> > Yes.
> >         git diff <whatever options> | kompare -
> >
>=20
> Thanks, Robin! It works too.

It should be noted, that kompare seems to be the only graphical tool wi=
lling
to accept patch instead of two trees. Unfortunately it does not seem po=
ssible
to install it without KDE, not to speak about Windows (where kdiff3 wor=
ks
quite well).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
