Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="B/7eBWZ3"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EF5173B
	for <git@vger.kernel.org>; Fri, 17 Nov 2023 17:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1700270078; x=1700874878; i=johannes.schindelin@gmx.de;
	bh=/5SUCRLS1D3iOPeKswAhYgX0IET9DyAC2ea8Dd6EcQ8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=B/7eBWZ3Pbu5jsVI6ZmP/pI8099lDRRx4VKHzK1ZmmY1rgAWuWpcgLLC+g0cw5sz
	 JadAS9FYoFfjhSxtAj52eqwL2USX0dcyeOSyBDzT0JGSW30ZBhixSaw3qNFg/M7BE
	 4w84sSihf61ACYvZTBcRlarLnYbsmlDGEt+jq/4nMmxqf8HsfUfZCmGKwJpi2zZIn
	 A3Wg++r9G3LvqpA1fOWHaBrbqLfc02gANt5M5VjXi+MDf9kvHihvq3/DS/2pwwm0N
	 B1svlyYcWEqh/jcP7HcHDfJIQTv4jImFzLulzd/O6/h3BWJtd+GY4uvXyxeSSvy5a
	 8uRCsEpLDZJu3wmtXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.165]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhUK-1rj2Z03FR6-00nfSl; Sat, 18
 Nov 2023 02:14:38 +0100
Date: Sat, 18 Nov 2023 02:14:37 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Todd Zullinger <tmz@pobox.com>
cc: git@vger.kernel.org, Matt Burke <spraints@gmail.com>, 
    Victoria Dye <vdye@github.com>, 
    =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: Migration of git-scm.com to a static web site: ready for
 review/testing
In-Reply-To: <ZVeUQEG5jIzKbvmT@pobox.com>
Message-ID: <4dd9b45d-b352-d8ba-3314-96ab48f7abf7@gmx.de>
References: <6f7d20b4-a725-0ef9-f6d3-ff2810da9e7a@gmx.de> <ZVeUQEG5jIzKbvmT@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2000277744-1700270078=:482"
X-Provags-ID: V03:K1:5JoUtx8g2ptk702aCkZmhJqzbNzfbIG894X0JgJebHo+9tpy+ET
 pWwos07HvidZWpYVrUFCOyi5r5zCMsliECNzQbWPMEuWnAB7JvL3nqlukRsH6G5gjregD6u
 481JDOeEMqqYzv6QhrURzblSSHx/nLnvpweumUSdGyF9nIvXD7Hib1kxlejbiX+XVkQvGjr
 eojT+sfzPmE0xpGeqSi4A==
UI-OutboundReport: notjunk:1;M01:P0:p9I0tpVe3CA=;7O+We/Vgab48LtxDEjyL0vNEZL1
 MjxNKkD6dBUtNpYSKSUooBTtZuXSFbpYTfFq/P/dslzcDWiFzcixfogGfHKjiIl/cckAMH4GZ
 1I8+Kjh2t1JBPsMwustNeuAlmutgx5/gp1TLPfSzNeterBPvcAHL60hhgLlHfVzjMOFFM1w2K
 mOpgEzi2C5rYf23HpnXuWg10gOvvzFL96akz5Iqxkiy4poHR14NGYG1AmsUrYRt5tNLB+2CjD
 kVSazIaSHNY5NrM9OjN0uKcnN/7WXq8B7zdiaYgvc7o/WRr9NYWQbCVbOSh7mhBCleufniHLL
 nWzuQidkrrNYV1IU7iQbALfUhGRCwEpG8QJ3NvWWJqHrR41gZNKmY4eUJbV9Rs1mqLfKgxkGa
 rqYzVPDlVDPHmAqxz5m2u3R59NpBYRvZf05tmO30/vjLn1SPNKXbTEutnBykm3Ej1XXwTsyof
 f4hGPO3w+a60wKDqKV3Ji3dwpRPdLbuv0OfejLDiaHDxvZeZ7ILWPLS3bocgEXxMHcXPAHr7t
 4SHKCV4DmFDhtx+6Ib0T+IqPClFEqXWT6M12gUEJ+5kiuve3o7wWhwLSqZWZeCsMfSLNLlDz+
 ChtsueNMRg49izTSIf4g29LQkvviMw3FLgP1wdMUbqSdnRwOZYZXaTuVjJDRKtIAupraIBm4V
 lCYwBIKoBjpHQRXuqEVWS75jAoO886w6+I2lce3KypeVuQtBvoQCsCpeFxNjcjBOq4myWTkln
 nEzWoJmasB8DBX4Z7s3PNzMsRNqKflgfOTo4J3GBWj2sPX2vlO808DfebygQCPe3TdggrPhUA
 XbMQUD94Xpxzp4HZPePVXaEAno9ZSjdR01PE+hLRoVLM6ra1h+G08+mo64NY7C+tZ0FUPvN55
 qHxpbKgbWWC0wSRdcuwyjmOJxKtALcT14TqcTmEvmVP5d58Y7CAEOO9lz/Uz7lEbdZdDWZ2na
 tIvBFg==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2000277744-1700270078=:482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Todd,

On Fri, 17 Nov 2023, Todd Zullinger wrote:

> Johannes Schindelin wrote:
> > At this point, the patches are fairly robust and I am mainly hoping fo=
r
> > help with verifying that the static site works as intended, that exist=
ing
> > links will continue to work with the new site (essentially, find obscu=
re
> > references to the existing website, then insert `git.github.io/` in th=
e
> > URL and verify that it works as intended).
> >
> > To that end, I deployed this branch to GitHub Pages so that anyone
> > interested (hopefully many!) can have a look at
> > https://git.github.io/git-scm.com/ and compare to the existing
> > https://git-scm.com/.
>
> This is nice.  Thanks to all for working on it!

=F0=9F=98=8A

> For checking links, a tool like linkcheker[1] is very handy.
> This is run against the local docs in the Fedora package
> builds to catch broken links.

Hmm, `linkchecker` is really slow for me, even locally.

> I ran it against the test site and it turned up _a lot_ of
> broken links.  [...]
>
>   URL        `ch00/ch10-git-internals'
>   Name       `Git Internals'
>   Parent URL https://git.github.io/git-scm.com/book/tr/v2/Ek-b%C3%B6l%C3=
%BCm-C:-Git-Commands-Plumbing-Commands/, line 106, col 1318
>   Real URL   https://git.github.io/git-scm.com/book/tr/v2/Ek-b%C3%B6l%C3=
%BCm-C:-Git-Commands-Plumbing-Commands/ch00/ch10-git-internals
>   Check time 3.303 seconds
>   Size       1KB
>   Result     Error: 404 Not Found

Good catch. I totally forgot to take care of the cross-references!

This is now fixed, as of
https://github.com/dscho/git-scm.com/commit/e599a57b2fadf8cb01e57af23fcb92=
9b32e94bcb

I kicked off the GitHub workflow to re-generate the books, and the updated
GitHub Pages look fine (see e.g. the parent URL mentioned above and follow
the "Pull Request Refs" link).

> Running it against a local directory of the content would be
> a lot faster, if that's an option.  It's also worth bumping
> the default number of threads from 10 to increase the speed
> a bit.
>
> [1] https://linkchecker.github.io/linkchecker/

Unfortunately it is actually quite slow.

Granted, the added cross-references now increase the number of hyperlinks
to check, but after I let the program run for a bit over an hour to look
at https://git-scm.com/ (for comparison), it is now running on the local
build (i.e. the `public/` folder generated by Hugo, not even an HTTP
server) for over 45 minutes and still not done:

=2D- snip --
[...]
10 threads active, 112977 links queued, 206443 links in 100001 URLs checke=
d, runtime 48 minutes, 46 seconds
10 threads active, 113455 links queued, 206689 links in 100001 URLs checke=
d, runtime 48 minutes, 52 seconds
10 threads active, 113829 links queued, 206874 links in 100001 URLs checke=
d, runtime 48 minutes, 57 seconds
10 threads active, 114230 links queued, 207136 links in 100001 URLs checke=
d, runtime 49 minutes, 3 seconds
10 threads active, 114731 links queued, 207498 links in 100001 URLs checke=
d, runtime 49 minutes, 9 seconds
=2D- snap --

Maybe something is going utterly wrong because the number of links seems
to be dramatically larger than what the https://git-scm.com/ reported;
Maybe linkchecker broke out of the `public/` directory and now indexes my
entire harddrive ;-)

Ciao,
Johannes

--8323328-2000277744-1700270078=:482--
