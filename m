From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-core: please support GSS-Negotiate authentication for http
Date: Sat, 24 Jul 2010 21:39:31 -0500
Message-ID: <20100725023930.GC18606@burratino>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tsOsTdHNUZQcU9Ye"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Martin Storsjo <martin@martin.st>,
	Tay Ray Chuan <rctay89@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 04:40:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocr91-00007q-BO
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 04:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148Ab0GYCkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 22:40:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50172 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab0GYCkf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 22:40:35 -0400
Received: by iwn7 with SMTP id 7so1624137iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 19:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=2kwK2wfkMKjbi1HIZUG/AH+1ao8ZT5KYXKawzgcjY6s=;
        b=ibpDaxvl9dpIlDycFP/HMBKwWs59+xhVbfWW9ZQOLtwdCex7P3AXg+0wgHgBRS3oGy
         zWWucv61ozk5ZpYPf2t/pyoE3ZhADhiSBWZQxrazglhyGnleaGzRHAZuNhu5g+N9R9V6
         RdSRfIS9x5hHzdrm8CkqiD8ArgfICTTnP6kGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=LY5xVsp2Uy7cQyUw/EjAQuAeVZMDGwwRQGBPWoxPf6LJ9IlfktOv0cpFZ/v0vUqcFl
         3txmeeRlp1YDIioKAQs/cjDT3x63j4wiLU2xvt+63QhkFnGC05gTlds+GWkhgw0mqU/9
         8CvJbz4+ttej3rq/NKZoyxa/plOB8a5NEmE1g=
Received: by 10.231.157.195 with SMTP id c3mr6338328ibx.155.1280025633966;
        Sat, 24 Jul 2010 19:40:33 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r3sm2000032ibk.7.2010.07.24.19.40.32
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 19:40:33 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151704>


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi transport experts,

This report came in a couple of months ago; I was thinking of trying
to reproduce it, but that was silly, since it is way over my head.  It
seems that some HTTP authentication scheme is not working well in some
circumstance. ;-)

Ideas?

--tsOsTdHNUZQcU9Ye
Content-Type: message/rfc822
Content-Disposition: inline

Delivered-To: jrnieder@gmail.com
Received: by 10.223.121.139 with SMTP id h11cs131830far;
        Fri, 28 May 2010 06:55:59 -0700 (PDT)
Received: by 10.224.96.229 with SMTP id i37mr142430qan.270.1275054958058;
        Fri, 28 May 2010 06:55:58 -0700 (PDT)
Return-Path: <sandals@crustytoothpaste.ath.cx>
Received: from qmta04.westchester.pa.mail.comcast.net (qmta04.westchester.pa.mail.comcast.net [76.96.62.40])
        by mx.google.com with ESMTP id j5si2322436qcu.26.2010.05.28.06.55.57;
        Fri, 28 May 2010 06:55:58 -0700 (PDT)
Received-SPF: neutral (google.com: 76.96.62.40 is neither permitted nor denied by best guess record for domain of sandals@crustytoothpaste.ath.cx) client-ip=76.96.62.40;
Authentication-Results: mx.google.com; spf=neutral (google.com: 76.96.62.40 is neither permitted nor denied by best guess record for domain of sandals@crustytoothpaste.ath.cx) smtp.mail=sandals@crustytoothpaste.ath.cx
Received: from omta21.westchester.pa.mail.comcast.net ([76.96.62.72])
	by qmta04.westchester.pa.mail.comcast.net with comcast
	id NyqB1e0051ZXKqc541vyJ4; Fri, 28 May 2010 13:55:58 +0000
Received: from castro.crustytoothpaste.net ([98.194.250.103])
	by omta21.westchester.pa.mail.comcast.net with comcast
	id P1vw1e0082EcKjW3h1vxNP; Fri, 28 May 2010 13:55:58 +0000
Received: from crustytoothpaste.ath.cx ([172.16.2.249])
	(authenticated bits=56)
	by castro.crustytoothpaste.net (8.14.3/8.14.3/Debian-9.1) with ESMTP id o4SDtqAY029892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 28 May 2010 13:55:55 GMT
Date: Fri, 28 May 2010 13:55:52 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: 472073@bugs.debian.org
Subject: Re: git-core: please support GSS-Negotiate authentication for http
Message-ID: <20100528135552.GB12541@crustytoothpaste.ath.cx>
References: <20080321213730.GA31810@crustytoothpaste.ath.cx>
 <20100516114533.GA12282@progeny.tock>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <20100516114533.GA12282@progeny.tock>
X-No-CC: If you CC me on this list, I will feed you to Branden Robinson.
X-Machine: Running on lakeview using GNU/Linux on x86_64 (Linux kernel
 2.6.34-1-amd64)
User-Agent: Mutt/1.5.20 (2009-06-14)


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 16, 2010 at 06:45:33AM -0500, Jonathan Nieder wrote:
> reassign 472073 git git-core/1:1.5.4.4-1
> tags 472073 + upstream
> quit
>=20
> Hi Brian,
>=20
> brian m. carlson wrote:
>=20
> > My webserver supports Kerberos 5 and DAV, but for the obvious
> > reason, DAV is only allowed with Kerberos (GSS-Negotiate)
> > authentication.  It would be nice if I could use GSS-Negotiate with
> > git, since it is supported by libcurl.
>=20
> I do not know how to check this, but could you try with version 1.7.0
> or 1.7.1?  The patch v1.7.0-rc0~108^2~2 (Add an option for using any
> HTTP authentication scheme, not only basic, 2009-11-27[1]) and its
> companion patch v1.7.0-rc0~108^2 (Remove http.authAny[2]) seem
> relevant.

It doesn't seem to work for me:

  lakeview no % git push http://bmc@castro.crustytoothpaste.net/dump/css.gi=
t master
  Password:=20
  Password:=20
  error: The requested URL returned error: 401 while accessing http://bmc@c=
astro.crustytoothpaste.net/dump/css.git/info/refs
 =20
  error: The requested URL returned error: 401 while accessing http://bmc@c=
astro.crustytoothpaste.net/dump/css.git/objects/info/packs
 =20
  Unable to create branch path http://bmc@castro.crustytoothpaste.net/dump/=
css.git/info/
  error: cannot lock existing info/refs
  fatal: git-http-push failed

Also, here's part of the log from the web server:

  172.16.2.249 - - [28/May/2010:13:44:20 +0000] "GET /dump/css.git/info/ref=
s?service=3Dgit-receive-pack HTTP/1.1" 401 720 "-" "git/1.7.1"
  172.16.2.249 - - [28/May/2010:13:44:20 +0000] "GET /dump/css.git/info/ref=
s HTTP/1.1" 401 720 "-" "git/1.7.1"
  172.16.2.249 - - [28/May/2010:13:44:24 +0000] "GET /dump/css.git/info/ref=
s?service=3Dgit-receive-pack HTTP/1.1" 401 720 "-" "git/1.7.1"
  172.16.2.249 - bmc@CRUSTYTOOTHPASTE.NET [28/May/2010:13:44:24 +0000] "GET=
 /dump/css.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 200 307 "-" "=
git/1.7.1"
  172.16.2.249 - - [28/May/2010:13:44:24 +0000] "GET /dump/css.git/HEAD HTT=
P/1.1" 401 720 "-" "git/1.7.1"
  172.16.2.249 - - [28/May/2010:13:44:25 +0000] "PROPFIND /dump/css.git/ HT=
TP/1.1" 401 720 "-" "git/1.7.1"
  172.16.2.249 - bmc@CRUSTYTOOTHPASTE.NET [28/May/2010:13:44:25 +0000] "PRO=
PFIND /dump/css.git/ HTTP/1.1" 207 767 "-" "git/1.7.1"
  172.16.2.249 - - [28/May/2010:13:44:25 +0000] "HEAD /dump/css.git/info/re=
fs HTTP/1.1" 401 205 "-" "git/1.7.1"
  172.16.2.249 - - [28/May/2010:13:44:25 +0000] "HEAD /dump/css.git/objects=
/info/packs HTTP/1.1" 401 205 "-" "git/1.7.1"
  172.16.2.249 - - [28/May/2010:13:44:25 +0000] "MKCOL /dump/css.git/info/ =
HTTP/1.1" 401 720 "-" "git/1.7.1"

Notice that only for certain requests does git use authentication.  It
needs to use authentication for every request, since access to /dump/ is
only allowed to valid users using Kerberos (for all requests).

Also note that git prompts for a password when one is not needed; this
is probably part of the curl bug noted in the manpage:

  When using this option, you must also provide a fake -u/--user option
  to activate the authentication code properly. Sending a '-u :' is
  enough as the user name and password from the -u option aren't
  actually used.

Using "bmc:@" instead of "bmc@" in the URI makes no difference.  If you
need me to do more testing, please let me know.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJL/8tZAAoJEL9TXYEfUvaL1SEQAMC7dQ/+Mi/PSHdagYdv8vOA
tw7+wnWs76qnI35d0CKvZLpIKdOQfNjjrCV+h3xehHw9pACJrb7zvmh545yJHWLs
QedfsCu92HMmQUqQeUMLCSiT5DG4kCIJerrdXcXZrVJXD+MSU7X/BgyRHOeM9q4D
pybUd9fMEK5dQdlsT867XS8RqRqQpwYVVd74NLpmQLLsvRXZ3ULX7IJDWHW2fOzb
5oPah5lhC+hDjWDD2FWXBuiCGELInNjgn9TrQufWmNu9qrs+8r4jq3gVIaYTgPge
U8cRxecZHD7wEUzX4w+MUiIXHjpGYJYPL4C2/IYv4RjAAzHsL4AjbX2tKklPRcqp
Y8vw8fysJeEDMT52tWGVZHJDTSn0VEG3e9XATdCTnXRAw1rug8oCgjYK9UwO92rR
G2vXT/XmVMbiFiWYLlIwtnEli6gE1wZPZEF6/wRuSgVggKX3xMkOfiLWfAJkhYlu
yPFM7jrgpa4iVmRRFQ786w3DqJ4z32v2Yw55LjQ0kJZCCKbkNRwjjceyKI40PB2R
aqyV9X3wbeNSLHjamRQNxzlv0oI/bbGCm1zx4hXa8LX8QVcTLR3blHyORCrakdJA
q6XDgYORwpTar4TEro6kZRAl/aSMu5JHVE5evivnEAWJmwtzkB2GZAuiDn0NkUfH
4SQS6z+AzgTAo06+Dcvo
=QgEy
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--

--tsOsTdHNUZQcU9Ye--
