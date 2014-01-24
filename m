From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] repack.c: chmod +w before rename()
Date: Fri, 24 Jan 2014 22:49:13 +0000
Message-ID: <20140124224911.GC58260@vauxhall.crustytoothpaste.net>
References: <201401242205.16313.tboegi@web.de>
 <20140124214023.GB58260@vauxhall.crustytoothpaste.net>
 <alpine.DEB.1.00.1401242318060.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, zwanzig12@googlemail.com,
	stefanbeller@googlemail.com, kusmabite@gmail.com,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDPLBYP6QEMRBAW4ROLQKGQEVUK4LHY@googlegroups.com Fri Jan 24 23:49:40 2014
Return-path: <msysgit+bncBDPLBYP6QEMRBAW4ROLQKGQEVUK4LHY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f57.google.com ([209.85.219.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDPLBYP6QEMRBAW4ROLQKGQEVUK4LHY@googlegroups.com>)
	id 1W6pZD-0000qX-Qc
	for gcvm-msysgit@m.gmane.org; Fri, 24 Jan 2014 23:49:40 +0100
Received: by mail-oa0-f57.google.com with SMTP id i4sf693172oah.2
        for <gcvm-msysgit@m.gmane.org>; Fri, 24 Jan 2014 14:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=JD1pBbzkzNfRDsLASQZZTaXLxe2yAmqkLGSN0pfyObk=;
        b=Xk+lALJFAYkgMHChEwW8NY5j2sNg4yYZq6Gqc3lGFFoPqfObKixUybT8Pg4/G5ZBaY
         yl+8Y0BJvcVN2bqhU8h1m+SaxBrwo4Joyc4XDxbSC7ssNE9Kxht5gzwiYbHpqacYarvk
         8TkKB3cqIIGgoaOb+1Cwd6Zkt5EcBBXQlVJh5fpvpKCJlpKfa2ynvIEgMvfxoVHdBEE+
         Yln5ohoRzoIIl1u1Ra9QLrNth8d4KEf1h+4UuiJ+nwpqqS5IM8Yxn66BpkG8CK86t4vd
         ngTQsSONorxh50zcFVqmBxRHfTeFLrK5nWKuxxT46lKuopchGjihmLzjTuRO4t8XSDHb
         5BKA==
X-Received: by 10.140.83.212 with SMTP id j78mr239151qgd.3.1390603778765;
        Fri, 24 Jan 2014 14:49:38 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.49.113 with SMTP id p104ls536330qga.41.gmail; Fri, 24 Jan
 2014 14:49:38 -0800 (PST)
X-Received: by 10.236.19.36 with SMTP id m24mr5018049yhm.14.1390603778272;
        Fri, 24 Jan 2014 14:49:38 -0800 (PST)
Received: from castro.crustytoothpaste.net (castro.crustytoothpaste.net. [173.11.243.49])
        by gmr-mx.google.com with ESMTP id v2si391966igb.1.2014.01.24.14.49.37
        for <msysgit@googlegroups.com>;
        Fri, 24 Jan 2014 14:49:38 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of sandals@crustytoothpaste.net designates 173.11.243.49 as permitted sender) client-ip=173.11.243.49;
Received: from vauxhall.crustytoothpaste.net (unknown [209.118.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 38D7E28074;
	Fri, 24 Jan 2014 22:49:28 +0000 (UTC)
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, zwanzig12@googlemail.com,
	stefanbeller@googlemail.com, kusmabite@gmail.com,
	msysgit@googlegroups.com
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1401242318060.14982@s15462909.onlinehome-server.info>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: sandals@crustytoothpaste.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of sandals@crustytoothpaste.net
 designates 173.11.243.49 as permitted sender) smtp.mail=sandals@crustytoothpaste.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241050>


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2014 at 11:24:36PM +0100, Johannes Schindelin wrote:
> > In general, I'm wary of changing permissions on a file to suit Windows's
> > rename because of the symlink issue and the security issues that can
> > result.
>=20
> I agree on the Windows issue.

I personally feel that if Windows needs help to change permissions for a
rename, that code should only ever be used on Windows.  Doesn't
mingw_rename automatically do this anyway, and if it doesn't, shouldn't
we put the code there instead?  Furthermore, it makes me very nervous to
make the file 666.  Isn't 644 enough?

> > Hard links probably have the same issue.
>=20
> No, hard links have their own permissions. If you change the permissions
> on a hardlink, any other hardlinks to the same content are unaffected.

Not according to link(2):

  This new name may be used exactly as the old one for any operation;
  both names refer to the same file (and so have the same permissions
  and ownership) and it is impossible to tell which name was the
  "original".

My testing confirms this.

More importantly, while one might not want to symlink a pack frequently,
git clone -l does use hard links.  This means that if a local clone is
made somewhere, and then the original repository is repacked and hits
this case, the clone is now vulnerable to tampering by a malicious user
(assuming that user can read the appropriate directory).  So unless I'm
reading this wrong, this patch would cause security problems on all Unix
systems.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS4u3mAAoJEL9TXYEfUvaL7dIP/3dGt8C5W62q6GEM701ariIO
tQy1lgpC0n0rkujs0Aal0t8mxjqq1xGx3udmgiPrgHhQThVMYkiMn2vm7HEFaozg
erV3I40k/IZ6Lkv/63q+IMc4CbzJIo1NSUQszPowMaxIVAQnPwqU8QtLetpukjHm
wW4bYYDqjPmAWIhdacFB7sQtqWBifAGJU0BhPLbVba+5cuur/QtdfzB8AWm1Qipq
ueE3GUlRAOAUj5BUco+AJ31vVrs9bnrjdA9VziPGIiUdH04ilFNmqnxeu2PGXxJ4
69+dFZc9K0Yvx+rOwJ3O/cyMSUF4A5H1DdLf0IJE8L5oN8y3IQRsaKAoTFThsN+3
m1eyHguyG8rJ2AkJnQFUMQzQ9c/jamB7GLqTVJiXfV7s4DBRoLMX1QRl2NE+hP/G
uLmFZHdkKN/kr4z0lQDnaHpsdBCK2M4ODREygoxWMCa6DXiNVJKHoGY3idxoBJRG
4SNzUnvs6NVMBe5338Ri2sStJLkOg4qvtIwlivl0eDmC2RjHE0D5tnW3iZd+RULk
BUHWMqCMXdWVTxcz4nMP5xxR60O+KyxFjAbu42KHzekkmd+WNejUtQUQfwkQTdCT
LIB+F+BM2AGCYtTzI7T0wWTY5G+Z4WjrvnbR1o5Lk8NATEahLccAPe+BPSctxORY
BVxuZ1gAF8+0+gKPiUtw
=XOuB
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
