From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] Documentation: remove unnecessary backslashes
Date: Fri, 22 Jan 2016 02:46:12 +0000
Message-ID: <20160122024612.GB686558@vauxhall.crustytoothpaste.net>
References: <1453310497-7971-1-git-send-email-kraai@ftbfs.org>
 <20160120182421.GA27562@sigill.intra.peff.net>
 <xmqqmvs05722.fsf@gitster.mtv.corp.google.com>
 <20160120203430.GB6092@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Matthew Kraai <matt.kraai@abbott.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 22 03:46:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMRjy-0004fn-3A
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 03:46:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbcAVCqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 21:46:18 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:59066 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751224AbcAVCqQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2016 21:46:16 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2659F282CA;
	Fri, 22 Jan 2016 02:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1453430774;
	bh=wJlU8gpquwR9vUsmLIoYmmIAbHCImGeZXnshI70+grw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c7UHFVwXbFG8/5mwtkasjjz+Oufh+90ueVA188gNnLeljej30kuzv9dqIIPZHFF9b
	 NslLtCPJ6x7SlCQEl6jVRAC4+61OdThllx4BwXVe1+KfqqzIocUsXCM/wb1WxycBC3
	 8clo779+4Y7DPV1k7t64oF054HX2yu6lZQG6leZKB9+PrbxSsjq3mBWjRxt5HTpHD+
	 DTBsuYwG6hMRlE4c9LobU7+E4cJrdSGlZzZM2qJhgsNTBCarSc19R8CwOpc4dXICz2
	 /PN79684cvU5BzXaXk9yMCBpJzpjRV6+/WC7Ap94onZ69VMZxwVP0/zK53CYMRNEwi
	 uJDD8+rQ7FtIF2GwdhoIvpLEbBGCy+6EiJ8sR8vj69YsCoMpQ7xK2YxQs2WE5kxKVk
	 lewf6g8n+TcDTQF98OPEP0zJB1Y3vSO5Oma5X4DDOlmM6YVnniKtbJa6H3lD7fJbvu
	 wwuVbjYJHaswhk0NbRp52du3LLEbnaHICFs2AQCTzFz0ymQGeLn
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org,
	Philip Oakley <philipoakley@iee.org>,
	Matthew Kraai <matt.kraai@abbott.com>
Content-Disposition: inline
In-Reply-To: <20160120203430.GB6092@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.3.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284545>


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 20, 2016 at 03:34:30PM -0500, Jeff King wrote:
> On Wed, Jan 20, 2016 at 12:28:53PM -0800, Junio C Hamano wrote:
> > On the other hand, if this line must be spelled like the above to
> > please asciidoctor, i.e. the first and the last must not have
> > backslashes and the second must have backslashes, I'd have to say
> > we have a bigger problem.  Perhaps asciidoctor needs to be fixed
> > until normal people like we can rely on it.
>=20
> Yeah, that is the "insane" part I mentioned. It _does_ make sense
> syntactically ("-1" cannot possibly be an attribute name, so it does not
> parse as one), but I do not like the degree to which writers must know
> all of the arcane syntax rules (and cannot rely on something simple like
> "{ is special, so I must escape it, and over-escaping is not a
> problem").

The underlying issue is that both AsciiDoc and Asciidoctor use regexps
to parse their data, which we all know is a bad idea.  Asciidoctor does
less forward looking because it's much faster, so it's a bit less
flexible with overescaping.

There are plans for Asciidoctor to move to a defined grammar at some
point, which should hopefully make things a bit less insane.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.10 (GNU/Linux)

iQIcBAEBCgAGBQJWoZfzAAoJEL9TXYEfUvaLujkP/RBlhVUTOrebJQqS7cl1iG71
dDwp48vjN9F22ldb0udWKaQ52ELsS91YSmqeuqVQtDAbrPanu8KAKqAMsaEVYPLf
Eop3rgHIX7lgpk1LoT2BWdBxx4eZCVZCOxIMSIgSkj8NarHDQnsmGsKPjqjOMKrn
uY60cUQjGZW4BQUXYFIrVGlQxOBamNq9wlYTUU1vVqh3Kr9SMTzGadxuFgZeLibF
r7zJb0s95cRV2Z107hT+yvJW5VphP+lW0rJCK4i3P6so3y6FnEWu5NLNo9YnCeM7
R3zsPluCzW38oqvufrRrbarLVxVySJrHGRmhG8SLgptNcXIa0lQSAZB9afAZ7gHE
BQ+SVh2ZCLqLcqggv3XginivWP+u+mZ0kvTdJ4zlMKXItwydxfzafc5HkKD7Lzbt
hhsatTLH8lubnle+mK4J3UeN1gHVJn9sBn8TcVEs+bxzh20WBY/DcofsseE60PQ7
g+eCX32hizQ6QXYOl4/SePBe9xFn19G86PbCNDb7RBpZKjVs0ZcapR0l9eFdodh7
ZOGlneO/reZJNKma8CfIFlcCjTcaICc5K89Wu4ja4x0bGvyOxFqiFHlQ1xjU21rn
AayX6UHLy3TThrcHucZU0X/vY+1s5e2zqYnDWVn5a/qo1YgAWpqFMXLMged67tKt
/niFGw7VSmqNgOVRLsgN
=tih5
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
