From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/3] Add a function skip_prefix_if_present()
Date: Wed, 05 Feb 2014 07:55:09 +0100
Message-ID: <52F1E04D.3090208@alum.mit.edu>
References: <1391581517-8586-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Kent R. Spillner" <kspillner@acm.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 05 07:55:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAwOK-000715-28
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 07:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbaBEGzQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Feb 2014 01:55:16 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:44837 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752144AbaBEGzP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Feb 2014 01:55:15 -0500
X-AuditID: 12074411-b7fc86d000000969-1f-52f1e0522089
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id B2.AD.02409.250E1F25; Wed,  5 Feb 2014 01:55:14 -0500 (EST)
Received: from [192.168.69.148] (p57A24DEA.dip0.t-ipconnect.de [87.162.77.234])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s156tAHa021091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 5 Feb 2014 01:55:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1391581517-8586-1-git-send-email-mhagger@alum.mit.edu>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsUixO6iqBv04GOQwfPDahZdV7qZLBp6rzBb
	rPxZY/Fgx08mizNb+5ktbq+Yz2zRPeUto8WPlh5mBw6Py1e8Pf6+/8DksXPWXXaPZ717GD0u
	XlL2+LxJzuPu/51MHrefbWMJ4IjitklKLCkLzkzP07dL4M54c/IvS0EvT8XH28sYGxhfcXYx
	cnJICJhIbP30kQnCFpO4cG89WxcjF4eQwGVGid1dL1ggnHNMEm2vZ7CDVPEKaEssu/qdGcRm
	EVCV+HOoESzOJqArsainGWySqECwxOrLD1gg6gUlTs58AmaLAPV+27gDbCizwH4miTfrtrOC
	JIQFHCRu3LzBCGILCThLzJ5/CGwop4CLxN/fN4FsDqDzxCV6GoNATGYBdYn184RAKpgF5CWa
	t85mnsAoOAvJtlkIVbOQVC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuql5tZopeaUrqJ
	ERIxgjsYZ5yUO8QowMGoxMNrIPwxSIg1say4MvcQoyQHk5Io7847QCG+pPyUyozE4oz4otKc
	1OJDjBIczEoivIndQDnelMTKqtSifJiUNAeLkjgv3xJ1PyGB9MSS1OzU1ILUIpisDAeHkgSv
	BMhQwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFD8xhcDIxgkxQO01/0eyN7igsRc
	oChE6ylGXY4VGz79YRRiycvPS5US5xW7C1QkAFKUUZoHtwKWHl8xigN9LMzbBjKKB5ha4Sa9
	AlrCBLRknet7kCUliQgpqQZGQZmDOp+VEo7GLnvy9NqZ/XKGL08tzuSxLikQ+D3b 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241598>

On 02/05/2014 07:25 AM, Michael Haggerty wrote:
> These patches apply on top of gitster/nd/more-skip-prefix.
>=20
> I noticed that Duy's new function skip_prefix_defval() was mostly
> being called with its first and third arguments the same.  So
> introduce a function skip_prefix_if_present() that implements this
> pattern.

I see I should have read the whole previous thread [1] before firing of=
f
this patch series.  What I learned when I read it just now:

* Johannes Sixt didn't think changes like the following improve
  readability:

> -		if (starts_with(arg, "--upload-pack=3D")) {
> -			args.uploadpack =3D arg + 14;
> +		if ((optarg =3D skip_prefix(arg, "--upload-pack=3D")) !=3D NULL) {
> +			args.uploadpack =3D optarg;

* Ren=C3=A9 Scharfe submitted a patch to use a function parse_prefix()
  (originally suggested by Peff) instead of Duy's suggested approach:

      http://article.gmane.org/gmane.comp.version-control.git/239569

  His patch appears to have been overlooked.

* Duy seemed to offer to rewrite his patch series, but I don't think
  that it has happened yet.

And then the conversation was drowned by Christmas eggnog.

I don't have a strong feeling about (Duy's proposal plus my patches) vs=
=2E
(Ren=C3=A9's parse_prefix() approach).  But I definitely *do* like the =
idea
of getting rid of all those awkward magic numbers everywhere.

Michael

[1]
http://thread.gmane.org/gmane.comp.version-control.git/239438/focus=3D2=
39569

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
