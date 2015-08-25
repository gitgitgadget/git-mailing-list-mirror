From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: OS X Yosemite make all doc fails
Date: Tue, 25 Aug 2015 01:04:28 +0000
Message-ID: <20150825010428.GA428718@vauxhall.crustytoothpaste.net>
References: <CAJD5XByPQASzYpyTFdKo83RJ0QwPFHg-nPWyusDCucMRFbor4g@mail.gmail.com>
 <CAJD5XBy=skwogN+kbqHipa3poUt-EjSxMABxRZKoEk0J+2TM3w@mail.gmail.com>
 <CAJD5XBy+RnM7ZYt9_SGXgoE2gOKaiM=rmUv=Tkn3Ndi4S4-atQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Cc: git@vger.kernel.org
To: Jeff S <acornblue@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 03:04:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU2fG-0005Vu-R6
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 03:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbbHYBEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 21:04:34 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:46039 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751672AbbHYBEd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2015 21:04:33 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 26E4528094;
	Tue, 25 Aug 2015 01:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1440464672;
	bh=fKR2QfMgw3kDvfbB4rHnyIbX99SeozlYuKa0FbS0jw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLK+9RLn9dbBLDVFk9/1GghdFlCVPMCIoemk7pZUIfgJg6O14QjGk0DY4uWKqmSgV
	 ZoI0g2lG/JXHvaGLAuiXUGGJVMc9s3qzWFm4bP/Rr+9xXaqKWT9EZTFWGc+ymKUBuO
	 A0X5tU+Q2WvtaIGN3aTPMKKQN1akLShaZEod+RXZ8iFfW5iy4GRPZPyTMlCgCWFKPy
	 I+nCBKQJ+KVSYXWqB+WnyPIXZvFbv5/Wkukf0zMndf6dLmf4Oxnb1VzGqrViW/l616
	 Qy0LDPnegpYNDYuIAOO6PKMBfH/8J5DfyT7tVWjaFkiLA4FfG3q8pMrNPX9jzmS9bV
	 JqLocmlQSfqxWYCXG2Zv5yHkyvMCABnaXfOlPz3zzjC9E5rbeUYIkC1THdwMtNapJZ
	 gsdnAAjMty2XK6tXvbUG6rnyG0wL/mTLBmoElAA7h2883NYZKh2up1WSmy2dXzFIYw
	 PR8UvJdYD9rje6h8U/e7ttrhDO3oIpj2LtMqhDDPEHBXyQwudAP
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff S <acornblue@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAJD5XBy+RnM7ZYt9_SGXgoE2gOKaiM=rmUv=Tkn3Ndi4S4-atQ@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.1.0-1-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276500>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2015 at 02:30:39AM -0700, Jeff S wrote:
> XSLTPROC user-manual.html
> warning: failed to load external entity
> "http://docbook.sourceforge.net/release/xsl/current/common/l10n.xsl"
> compilation error: file
> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl line =
29
> element include
> xsl:include : unable to load
> http://docbook.sourceforge.net/release/xsl/current/common/l10n.xsl
> warning: failed to load external entity
> "http://docbook.sourceforge.net/release/xsl/current/common/utility.xsl"
> compilation error: file
> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl line =
31
> element include
> xsl:include : unable to load
> http://docbook.sourceforge.net/release/xsl/current/common/utility.xsl
> warning: failed to load external entity
> "http://docbook.sourceforge.net/release/xsl/current/common/labels.xsl"
> compilation error: file
> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl line =
32
> element include
> xsl:include : unable to load
> http://docbook.sourceforge.net/release/xsl/current/common/labels.xsl
> warning: failed to load external entity
> "http://docbook.sourceforge.net/release/xsl/current/html/autotoc.xsl"
> compilation error: file
> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl line =
39
> element include
> xsl:include : unable to load
> http://docbook.sourceforge.net/release/xsl/current/html/autotoc.xsl
> warning: failed to load external entity
> "http://docbook.sourceforge.net/release/xsl/current/html/verbatim.xsl"
> compilation error: file
> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl line =
43
> element include
> xsl:include : unable to load
> http://docbook.sourceforge.net/release/xsl/current/html/verbatim.xsl
> warning: failed to load external entity
> "http://docbook.sourceforge.net/release/xsl/current/html/formal.xsl"
> compilation error: file
> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl line =
46
> element include
> xsl:include : unable to load
> http://docbook.sourceforge.net/release/xsl/current/html/formal.xsl
> warning: failed to load external entity
> "http://docbook.sourceforge.net/release/xsl/current/common/table.xsl"
> compilation error: file
> http://docbook.sourceforge.net/release/xsl/current/html/table.xsl line 11
> element include
> xsl:include : unable to load
> http://docbook.sourceforge.net/release/xsl/current/common/table.xsl
> warning: failed to load external entity
> "http://docbook.sourceforge.net/release/xsl/current/html/footnote.xsl"
> compilation error: file
> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl line =
51
> element include
> xsl:include : unable to load
> http://docbook.sourceforge.net/release/xsl/current/html/footnote.xsl
> warning: failed to load external entity
> "http://docbook.sourceforge.net/release/xsl/current/html/block.xsl"
> compilation error: file
> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl line =
65
> element include
> xsl:include : unable to load
> http://docbook.sourceforge.net/release/xsl/current/html/block.xsl
> warning: failed to load external entity
> "http://docbook.sourceforge.net/release/xsl/current/common/stripns.xsl"
> compilation error: file
> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl line =
76
> element include
> xsl:include : unable to load
> http://docbook.sourceforge.net/release/xsl/current/common/stripns.xsl
> make[1]: *** [user-manual.html] Error 5
> make: *** [doc] Error 2

It's clear from the message that your catalogs are not properly set up.
Once you get that working, the documentation should build correctly.

> <nextCatalog
> catalog=3D"file:///usr/local/Cellar/docbook-xsl/1.78.1/docbook-xsl/catalo=
g.xml"/>
> <nextCatalog
> catalog=3D"file:///usr/local/Cellar/docbook-xsl/1.78.1/docbook-xsl-ns/cat=
alog.xml"/>
> </catalog>

Unfortunately, this doesn't tell us much, since these are all references
to other catalogs.  You need to look in the other catalogs, specifically
the two mentioned above, and ensure that there are appropriate
rewriteURI and rewriteSystem entries pointing to the right place.  On my
system, that looks like the following:

  <rewriteURI uriStartString=3D"http://docbook.sourceforge.net/release/xsl/=
current/" rewritePrefix=3D"./"/>
  <rewriteSystem systemIdStartString=3D"http://docbook.sourceforge.net/rele=
ase/xsl/current/" rewritePrefix=3D"./"/>

I don't know how your system is configured, so I can't tell you what
entries would be correct.  You might ask in an appropriate user forum
for Homebrew.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.7 (GNU/Linux)

iQIcBAEBCgAGBQJV278cAAoJEL9TXYEfUvaLSFkP/RzL5F8IHTKWXYCK8MLO2jVL
WPF5Ht2ZDA1/F7ittWfXjqkX6opcP28BSbsplmbufsbqg6I2qmFMcAEq6VqUqnN3
AvorXi+MXs1Y/iTJ64kOsSAHU1a9tg1la6lSa09dyepz7wdF42dE1kbwjHR4jyc5
cdUfXz3pXgihirvtdBrTj/U5InLNK9LH468nzVev/m8apJFw+2HQelcBprJu0Btz
LxupQuAgQ3bZdEFlWqYuLI96hZpVhmPUJKcsPWjqcc1Zflr7YwNGwgMOD4tv07NB
12xuXEZIya+hubQvl7PBwSsuXBjnwV2eltdiENbXfw9eE4c3HkPQwgfHcprOeBWN
6Dr7miQj71hqBJrSNEvTCoBQQZh10JN4NLj1mzH3Zh/Fi3IPivXOSmGmZOawSOoF
oMn7SN9eF+p3o43V6Kl5f6UShG08KucYoLur4XyP32czLFltZzqQb3KHuN1Wzhnb
mET/Xn1tQMINn+2zeURftpQAFv12vMetU65qdeQHfrU1NDPtxY91yXcS2Sgn40eW
+aVQPluCYzAVHhNSMxi/g5ad+LZ7BH4HfXgt34jjg5U8l/wNQkE4kbNhXoiyvB01
nxtb/4zqCSYjHm5d68iNxHtP64eDPkCqSjnhv6WfMGa+tvULbCmBqfQmnL23kPZk
Yv/482BVbw+2j7Tm7z2d
=XPSw
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
