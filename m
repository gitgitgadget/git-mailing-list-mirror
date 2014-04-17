From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3] send-email: recognize absolute path on Windows
Date: Thu, 17 Apr 2014 01:45:32 +0000
Message-ID: <20140417014532.GA579226@vauxhall.crustytoothpaste.net>
References: <1397635698-6252-1-git-send-email-kusmabite@gmail.com>
 <xmqqfvldi4ue.fsf@gitster.dls.corp.google.com>
 <xmqqbnw1i43p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, johannes.schindelin@gmx.de,
	j.sixt@viscovery.net
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDPLBYP6QEMRBRHEXSNAKGQECRVYLQY@googlegroups.com Thu Apr 17 03:45:42 2014
Return-path: <msysgit+bncBDPLBYP6QEMRBRHEXSNAKGQECRVYLQY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f58.google.com ([209.85.213.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDPLBYP6QEMRBRHEXSNAKGQECRVYLQY@googlegroups.com>)
	id 1WabOX-0004AK-Qo
	for gcvm-msysgit@m.gmane.org; Thu, 17 Apr 2014 03:45:42 +0200
Received: by mail-yh0-f58.google.com with SMTP id z6sf2598090yhz.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Apr 2014 18:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=LUjQXId/9mItun+s46BVPzc5yLOqYTa8UYaDiRYJQno=;
        b=AvpjuZZx4gdDuED6m3/o6+nIV2r8X79gmRRz3ZzgvGQcOIDrrqTrLNFSBKrbo7261Y
         o0ybBZaNI6bLbW6MKJYNzMp9cBN46HHOTQ61Rbqt5S4j4GizVcEmdTZmStbU/c78ZTSs
         uuvQb3w7BhH6sXf5VeD894FJDhsmEn95AXpAbSoYAo8S9eE6f9rdzBft9iNwHa9z7awh
         Sfo4mJCv124335pMQTtFFalG+HC/Dn31g36s3C4jjBSceyHu8eVlFtUfRuCWBQKtuMHb
         ZCQSteSz62eiJvk0RhtT85kmYhMnD/PU4VbAtaKUqQYa4t4S4JZN/1dgCVbrnmfP4iuC
         RSLg==
X-Received: by 10.140.93.103 with SMTP id c94mr269675qge.4.1397699140618;
        Wed, 16 Apr 2014 18:45:40 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.80.145 with SMTP id c17ls828239qgd.60.gmail; Wed, 16 Apr
 2014 18:45:40 -0700 (PDT)
X-Received: by 10.236.216.39 with SMTP id f37mr4594578yhp.57.1397699140202;
        Wed, 16 Apr 2014 18:45:40 -0700 (PDT)
Received: from castro.crustytoothpaste.net (sandals-pt.tunnel.tserv3.fmt2.ipv6.he.net. [2001:470:1f04:79::2])
        by gmr-mx.google.com with ESMTP id s1si321110ign.1.2014.04.16.18.45.39
        for <msysgit@googlegroups.com>;
        Wed, 16 Apr 2014 18:45:39 -0700 (PDT)
Received-SPF: none (google.com: sandals@crustytoothpaste.net does not designate permitted sender hosts) client-ip=2001:470:1f04:79::2;
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:a4ad:9eb3:4a3f:777e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7235A28087;
	Thu, 17 Apr 2014 01:45:38 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, johannes.schindelin@gmx.de,
	j.sixt@viscovery.net
Content-Disposition: inline
In-Reply-To: <xmqqbnw1i43p.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-rc7-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
X-Original-Sender: sandals@crustytoothpaste.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: sandals@crustytoothpaste.net does not designate permitted sender
 hosts) smtp.mail=sandals@crustytoothpaste.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246400>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2014 at 10:19:54AM -0700, Junio C Hamano wrote:
> Ahh, OK, if you did so, you won't have any place to hook the "only
> on msys do this" trick into.
>=20
> It somehow feels somewhat confusing that we define a sub with the
> same name as the system one, while not overriding it entirely but
> delegate back to the system one.  I am debating myself if it is more
> obvious if it is done this way:
>=20
>         use File::Spec::Functions qw(file_name_is_absolute);
>         if ($^O eq 'msys') {

You would probably want a "no warnings 'redefine'" here as well.

>                 sub file_name_is_absolute {
>                 	return $_[0] =3D~ /^\// || $_[0] =3D~ /^[A-Z]:/i;
>                 }
>         }

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTTzI7AAoJEL9TXYEfUvaLBCYP+wV4RF23+fr6aljALLshRNIR
RcPvxI7OIkwN/gWdQpICstsL8kCZbPDnWeMb+sPoNR7ZoOxs8bnhwPIRQ0VK53vG
PIHeBWHIFlEKbPQ8It0/rujxRJsRDanT2XTfiOfAMnig3jjKhNPQuaVzJRHCLCtb
UIerkJKTmNyoDMNGo7d4RykCONhk0bVMhIUh60IftA8bysAik5OmhQuYnsAblyJt
ud2eakk+OhMrjduCoxG3Kh2soIBY03Lm/nP7A0TEkJhdIZTOXPmR1teXPwALryp6
OLWG4epgc6Tv6EYUPQWeqvBzZGw18+27n0d6j2zXQWuB8VGiM8o3hFhv8UWD58AF
xdzf+NgvY/yUvuNC6lLguCk2+O2Qg4bK37FNb6Fb59HOlFP/4nMQu+qnUD/EpqPY
639nkHZJBTs3WkiBs45x2eax0MtXPt35DF4xmdmI1gtO+MyyN0lAYYttAqPi19SF
aY4NFhA+mYeAJ51tVrL4I1s71MgQ5ljdxJsyrQWVND4UoQd9eebye6uDgaKEgxnj
XLvNx/sOkJgZTmPuseLQlye86Mc97WcFp75+mosUfjeOLV26JIMh3KL/KMD8yzrz
m1bEbn96gjpMrTfjf6whjcbvWDOdFv9yDqzyGGFyDFqrvAk88FJZL0JIpit7C2IZ
JGEtbnDXkBWGpx8YG6yC
=1kzn
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
