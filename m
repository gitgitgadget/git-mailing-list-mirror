From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC 00/17] Begin gettextizing Git
Date: Tue, 31 Aug 2010 14:02:35 +0200
Message-ID: <vpqk4n7rnvo.fsf@bauges.imag.fr>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
	<alpine.DEB.2.00.1008311205280.28446@ds9.cixit.se>
	<AANLkTikuQZpOjddgHtpSpw-P4AeL1swsrzJzd5cE7e8F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 14:02:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqPY9-0001xP-Bn
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 14:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab0HaMCo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 08:02:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44322 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800Ab0HaMCn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 08:02:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o7VBx47R020197
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 31 Aug 2010 13:59:04 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OqPXv-0002NM-FQ; Tue, 31 Aug 2010 14:02:35 +0200
In-Reply-To: <AANLkTikuQZpOjddgHtpSpw-P4AeL1swsrzJzd5cE7e8F@mail.gmail.com>
 (=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Tue\, 31
 Aug 2010 11\:42\:38 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 31 Aug 2010 13:59:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7VBx47R020197
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1283860745.71292@Jkk6hjzSCTko6qQBjj4fbw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154895>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> I've used Launchpad somewhat for translating and it's friendly to
> contributors & has an active community, but it seems to require that
> we BSD-license our translations[1], which would be a showstopper sinc=
e
> we'd have to contact everyone who's been submitting GPL-2-only string=
s
> to Git for the last 5 years.

I don't think so:

,----[ https://help.launchpad.net/Translations/LicensingFAQ ]
| I have no problem with BSD myself, but I also uploaded translations
| from upstream. What do I do?
|=20
| As long as the uploads were marked as translations that were publishe=
d
| elsewhere, they fall under a separate copyright regime: those imports
| will retain their original copyright license. The BSD licence only
| applies to translations that are (as far as the system knows) origina=
l
| to Launchpad.
`----

So, my understanding is: Git's code, and strings, would remain what
they are, but things contributed _through launchpad_ would be BSD.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
