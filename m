From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC 3/4] git-mw: Adding git-mw.perl script
Date: Sun, 16 Jun 2013 21:59:33 +0200
Message-ID: <vpq1u81hlne.fsf@anie.imag.fr>
References: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
	<1371118039-18925-4-git-send-email-benoit.person@ensimag.fr>
	<vpq4nd2rwq1.fsf@anie.imag.fr>
	<CAETqRCidQpBu-Ws7wQ3xx73ozu0OQeeM7atptYg=ei8ZUXRbsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>,
	Jeff King <peff@peff.net>
To: =?iso-8859-1?Q?Beno=EEt?= Person <benoit.person@ensimag.fr>
X-From: git-owner@vger.kernel.org Sun Jun 16 22:00:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoJ7J-0006rT-Gp
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 22:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459Ab3FPT7o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Jun 2013 15:59:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36684 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755451Ab3FPT7n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 15:59:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5GJxVh9010708
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 16 Jun 2013 21:59:32 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UoJ6s-0003cC-5Q; Sun, 16 Jun 2013 21:59:34 +0200
In-Reply-To: <CAETqRCidQpBu-Ws7wQ3xx73ozu0OQeeM7atptYg=ei8ZUXRbsA@mail.gmail.com>
	(=?iso-8859-1?Q?=22Beno=EEt?= Person"'s message of "Sat, 15 Jun 2013
 15:22:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 16 Jun 2013 21:59:33 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228023>

Beno=EEt Person <benoit.person@ensimag.fr> writes:

>> I think you need an equivalent of Git's toplevel bin-wrappers/git, o=
r
>> perhaps use the same bin-wrapper/git but let "make install" in
>> contrib/mw-to-git/ install GitMediawiki.pm in perl/blib/lib
> Typo s/make install/make/ ?

Yes.

> For that one, I am not really sure Git::Mediawiki makes more sense
> than GitMediawiki. The point of the GitMediawiki.pm package is to
> contain all the stuff for the bidirectionnal-thingy. So they are not
> really Git-related, nor Mediawiki-related.

I'd say they are related to both, not to neither.

> Making it part of a "Git" directory / namespace does not really feels
> right, even if it's how it's done for SVN :/ .

Well, it's the part of Git's perl library which deals with SVN
interaction, so it makes sense to have it be a subdirectory of Git. I'd
say it makes as much sense for Mediawiki interaction.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
