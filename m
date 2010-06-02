From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH/RFC v4 1/7] Add infrastructure for translating Git with
  gettext
Date: Wed, 2 Jun 2010 11:11:51 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1006021109010.23247@ds9.cixit.se>
References: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com> <1275440764-26153-2-git-send-email-avarab@gmail.com> <alpine.DEB.2.00.1006021006590.23247@ds9.cixit.se> <AANLkTilClUTkrpnMhBTlcBZC-r2OemT4m22bDnc6fRPy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 12:12:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJkvb-0006SW-4A
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 12:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757778Ab0FBKL5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 06:11:57 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:36787 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757226Ab0FBKL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 06:11:56 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o52ABp1A004660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 2 Jun 2010 12:11:52 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o52ABpkl004656;
	Wed, 2 Jun 2010 12:11:51 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <AANLkTilClUTkrpnMhBTlcBZC-r2OemT4m22bDnc6fRPy@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 02 Jun 2010 12:11:52 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148241>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:

> Making things like wt-status.c translatable is going to be hard to do=
=20
> properly. It uses a lot of lego (sticking strings incrementally toget=
her),

However, preparing them for translation is probably going to make them=20
better anyway, as this kind of string building is incredibly brittle, e=
ven=20
for English strings.

You also have to look out for pluralisation issues, fortunately Gettext=
 does=20
have support for the various types of plural forms that are used, so it=
=20
should be possible. The problem is just identifying where they are need=
ed.

> and due to the coloring of output this'll be particularly hard to con=
vert.

Is the colouring based on knowing the contents of the actual text, or i=
s it=20
enough to know the markers? I admit not having looked at the colouring =
code=20
at all...

--=20
\\// Peter - http://www.softwolves.pp.se/
