From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: subversion-perl missing
Date: Mon, 26 Sep 2011 10:17:04 -0700 (PDT)
Message-ID: <m3k48vp6l7.fsf@localhost.localdomain>
References: <4E8066AB.7000208@gjlay.de>
	<CAP8UFD0PiiA9SxvOuuh4t8P96v+iaJ0TfcBr1-xjMh4TXBEONQ@mail.gmail.com>
	<4E80AD1B.3080700@gjlay.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
To: Georg-Johann Lay <avr@gjlay.de>
X-From: git-owner@vger.kernel.org Mon Sep 26 19:17:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Enq-00053C-6x
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 19:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747Ab1IZRRI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 13:17:08 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40354 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab1IZRRG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 13:17:06 -0400
Received: by eya28 with SMTP id 28so3792098eya.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 10:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=mJJ0EzohgxMg0weQdio5ZpPWskI/hsbSWmk2QaM2ebM=;
        b=lPvwc1dRcK+qwVD/OgGS9VxC6GlW8NxCVzP++znqKnDz1Wp3EQS0dqM3ouG5zz9OSv
         qPb5saoIeE3RY2r5LNx+XrAule4yw4/BqfMq1lFYJ6Fi7bhSuxXggqgFKUmx4nhPwR+2
         09qgiMJTV2w2cx/rw9sazwvCFcyAoLkDeGTYM=
Received: by 10.213.3.19 with SMTP id 19mr2343213ebl.70.1317057424997;
        Mon, 26 Sep 2011 10:17:04 -0700 (PDT)
Received: from localhost.localdomain (abwm119.neoplus.adsl.tpnet.pl. [83.8.236.119])
        by mx.google.com with ESMTPS id z54sm62184293eef.2.2011.09.26.10.17.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Sep 2011 10:17:04 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8QHGVnH008512;
	Mon, 26 Sep 2011 19:16:36 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8QHGKdl008508;
	Mon, 26 Sep 2011 19:16:20 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4E80AD1B.3080700@gjlay.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182136>

Georg-Johann Lay writes:
> Christian Couder schrieb:
> > On Mon, Sep 26, 2011 at 1:48 PM, Georg-Johann Lay <spam@spam.com> w=
rote:

> > > Where do I have to go to get the svn+perl stuff? Couldn't locate =
anything like
> > > that in subversion.tigris.org, so that I am stuck and need some h=
ints on how to
> > > proceed.
> >=20
> > Perhaps you can try to install this module from CPAN:
> >=20
> > http://search.cpan.org/~mschwern/Alien-SVN-v1.6.12.1/
> >=20
> > or from it's github repo:
> >=20
> > https://github.com/schwern/alien-svn
>=20
> Hi Christian,
>=20
> thanks for that hint.
>=20
> After getting that piece of software, running ./Build.PL and ./Build =
I just
> don't know what to do next.  The README doesn't say anything about ho=
w to use
> the built modules or how to do an install.

If you don't have admin privileges on the box, the best solution would
be to use local::lib[1] to install Perl modules in your home directory
for you (#perl IRC channel on FreeNode, or perlmonks are really helpful=
).

I really recommend it, together with cpanm[2] (which can configure
local::lib for you, via --local-lib option), though the latter is not
necessary.

[1]: http://search.cpan.org/~apeiron/local-lib-1.008004/lib/local/lib.p=
m
[2]: http://search.cpan.org/~miyagawa/App-cpanminus-1.4008/bin/cpanm


If you have admin privileges, I think the best solution would be
either find repository which has subversion-perl that matches your
version of Subversion, or compile subversion-perl from a source
package... though this might be more difficult, it has advantage of
being in package management.
=20
> As git-svn complains
>=20
> ...Can't locate SVN/Core.pm in @INC (@INC contains: ...
>=20
> and
>=20
>  schwern-alien-svn-9298884>find . -name 'Core.pm'
> ./src/subversion/subversion/bindings/swig/perl/native/Core.pm
> ./src/subversion/subversion/bindings/swig/perl/native/blib/lib/SVN/Co=
re.pm
>=20
> the question is how to do the final trick of telling git how to use C=
ore.pm
> (and which of the two?) and do the connexion between git and alien-sv=
n.
>=20
> Sorry for the noob questions, never used perl or git before...

You have to install subversion-perl somewhere, not only build it.
Though you could fiddle with PERL5LIB (which is PATH-like environmtne
variable to specify where to search for Perl modules) to make Perl
find your built but not installed Alien::SVN.

HTH
--=20
Jakub Nar=EAbski
