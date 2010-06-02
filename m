From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH/RFC v4 1/7] Add infrastructure for translating Git with
  gettext
Date: Wed, 2 Jun 2010 12:31:17 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1006021224170.4751@ds9.cixit.se>
References: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com> <1275440764-26153-2-git-send-email-avarab@gmail.com> <alpine.DEB.2.00.1006021006590.23247@ds9.cixit.se> <AANLkTilClUTkrpnMhBTlcBZC-r2OemT4m22bDnc6fRPy@mail.gmail.com>
 <alpine.DEB.2.00.1006021109010.23247@ds9.cixit.se> <AANLkTinzZUaFBzNHzxBA94ECeUKdejVGqSQF1TUtOrrk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 02 13:31:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJmAP-0005UG-Az
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 13:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757891Ab0FBLbV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 07:31:21 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:38771 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751860Ab0FBLbU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 07:31:20 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o52BVHVN010148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 2 Jun 2010 13:31:17 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o52BVHB8010144;
	Wed, 2 Jun 2010 13:31:17 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <AANLkTinzZUaFBzNHzxBA94ECeUKdejVGqSQF1TUtOrrk@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 02 Jun 2010 13:31:17 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148246>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:

> But maybe that's counter-productive. Just making the English strings=20
> translatable as-is is still going to make most of Git translatable, a=
nd it=20
> isn't going to be that bad for languages like German and French.

I think this is the best approach. Without actually making *everything*=
=20
available for translation it is impossible to weed out the problems. So=
me of=20
the easier "hack" strings (plural word%s, sentence %s%s building, etc) =
can=20
be fixed during conversion, the rest can be done later as complai^Wcomm=
ents=20
come in.

> It would be useful to have an example of a message that could use=20
> pluralization, even better examples in all of C, Perl and Shell.

There is the "Your branch is ahead of..." messages, they were introduce=
d in=20
commit b0030db331141bedfaf02f34a83f18712c0ae011, and are currently usin=
g a=20
"commit%s" form, where the %s either maps to an empty string or "s". Sh=
ould=20
be fairly trivial to fix. I think there are other examples as well, but=
=20
that's the first one I came to think of. :-)

--=20
\\// Peter - http://www.softwolves.pp.se/
