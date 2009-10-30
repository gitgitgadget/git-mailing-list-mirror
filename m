From: Klaus Ethgen <Klaus@Ethgen.de>
Subject: Re: Bug#553296: gitignore broken completely
Date: Fri, 30 Oct 2009 21:08:25 +0100
Message-ID: <20091030200824.GF10671@ikki.ethgen.de>
References: <20091030194333.GA4551@coredump.intra.peff.net> <20091029233458.GA32764@ikki.ethgen.de> <20091030162857.26604.qmail@67b7e3b41a17c8.315fe32.mid.smarden.org> <20091030165903.GA10671@ikki.ethgen.de> <20091030173838.GB18583@coredump.intra.peff.net> <20091030182331.GC10671@ikki.ethgen.de> <20091030184155.GC19901@coredump.intra.peff.net> <20091030190552.GA3528@coredump.intra.peff.net> <20091030200148.GD10671@ikki.ethgen.de> <20091030200500.GA24831@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; x-action=pgp-signed
Cc: 553296@bugs.debian.org, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 21:08:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3xly-00082q-57
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 21:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbZJ3UIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 16:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbZJ3UIY
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 16:08:24 -0400
Received: from toomai.ethgen.de ([85.10.201.50]:56658 "EHLO toomai.ethgen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932576AbZJ3UIX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 16:08:23 -0400
Received: from home.ethgen.de ([94.247.217.2] helo=ikki.ket)
	by toomai.ethgen.de with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <klaus@ethgen.de>)
	id 1N3xlp-0007AW-IV; Fri, 30 Oct 2009 21:08:25 +0100
Received: from klaus by ikki.ket with local (Exim 4.69)
	(envelope-from <klaus@ikki.ethgen.de>)
	id 1N3xlp-0004X4-2d; Fri, 30 Oct 2009 21:08:25 +0100
Content-Disposition: inline
In-Reply-To: <20091030200500.GA24831@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131746>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Am Fr den 30. Okt 2009 um 21:05 schrieb Jeff King:
> > > +	test_cmp expect output
[...]
> No, because it is building on the previous tests. The point of the test
> is:
> 
>   - we already have 'file' tracked and in gitignore (from previous
>     tests in the series)
>   - we add other-file to have some other file which is tracked but not
>     in gitignore
>   - we check the output of "ls-files -i" to make sure that "file" is
>     there, but "other-file" is not

Aha, now I get it, the "test_cmp" do check the _content_ of the file
expect and not the file expect itself.

Regards
   Klaus

Ps. Uh, oh, maybe I should truncate the Cc ;-) Ok, hoping that is ok so
too.
- -- 
Klaus Ethgen                            http://www.ethgen.de/
pub  2048R/D1A4EDE5 2000-02-26 Klaus Ethgen <Klaus@Ethgen.de>
Fingerprint: D7 67 71 C4 99 A6 D4 FE  EA 40 30 57 3C 88 26 2B
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQEVAwUBSutHuJ+OKpjRpO3lAQoL2gf8DixaPjnEkLhOZUK4VVsXU7zJ/bB3qWnP
71yq3sPA3Fi9Bq51d06YnxAQe/WqJWnOtSzgw8V5QquTaEM5Lqp6bgY49jynj6mf
wRSL+L4y+jpuerIQ/SK3yVcNw837URfQNDGFPNVSJAwGYfeMWiYh52fqwPVxO37p
wsNryc2CqpviaiqK12XwyEn7NHxPROdIRm0K8uezsw1fzWUcx4hN8IVbl8i8z0ss
brgyuMsT+R0GnazT/IndLkGniuBFBF2pdyD5uYv/lqF+q8TOC+iQzhxuA0cj/EC6
y5FuVCOTLA938bmclvhnl1hfzg4+6c5xoqqtWI2DzJoXkm2zJpvlLQ==
=VEYC
-----END PGP SIGNATURE-----
