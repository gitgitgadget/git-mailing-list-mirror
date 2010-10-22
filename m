From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: pulling the root commit overwrites untracked files without
 warning (1.7.2.3)
Date: Fri, 22 Oct 2010 23:17:09 +0200
Message-ID: <20101022211709.GB1774@localhost>
References: <AANLkTimDnyzyV1FEEwEuxLfG1nSOcNa7Hzwt7DDssjba@mail.gmail.com>
 <20101022211400.GA1774@localhost>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Cc: git@vger.kernel.org
To: Gert Palok <gert@planc.ee>
X-From: git-owner@vger.kernel.org Fri Oct 22 23:16:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Oyf-0006EW-UL
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 23:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380Ab0JVVQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 17:16:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45911 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab0JVVQg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 17:16:36 -0400
Received: by bwz11 with SMTP id 11so961070bwz.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 14:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=rlgfzlIgbvdla7CO6FnWiqn38V9FycxRMMlMe+SOagE=;
        b=Rh/cDtgY9mkZFDsczMLM4QNA+hRV6EvP/zpUl3XQF80ZmB2nK6b8bUmg/8bpWXeySE
         GMguRkp7v1hsarypmqirZcSFVLqekJx8bt8ABov7egc+coQV362/5e88mXfbu3vxk1UK
         JJrFpN4mW1C8b9yoInotvlytxPawYmYvV2ZjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=chAm2Wl9HP+CT8nl7soYPENsBmyPWrjgHeamjOWcOow8bdJ0baEjMMy+xoTNvgSJ7u
         h8RFjw5G+rAKuEyHq3bv8ElETX5S6bPFP8LRoeLlVnt11ipgxcg+BQ1KbVyKfpdDvR6C
         uCmMCuM8gKWUvXy38ZP+75g/Fc4Vg71K7Wh2w=
Received: by 10.204.50.206 with SMTP id a14mr2633143bkg.65.1287782193310;
        Fri, 22 Oct 2010 14:16:33 -0700 (PDT)
Received: from darc.lan (p549A6958.dip.t-dialin.net [84.154.105.88])
        by mx.google.com with ESMTPS id u4sm2456060bkz.5.2010.10.22.14.16.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 14:16:32 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1P9Oz7-0000UW-3z; Fri, 22 Oct 2010 23:17:09 +0200
Content-Disposition: inline
In-Reply-To: <20101022211400.GA1774@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159751>


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 22, 2010 at 11:14:00PM +0200, Clemens Buchacher wrote:
> Hi,
>=20
> On Thu, Oct 21, 2010 at 04:18:19PM +0300, Gert Palok wrote:
> >=20
> > On 1.7.2.3, pulling the root commit overwrites untracked files
>=20
> Thanks. This is probably fixed by the following series.
>=20
>  http://mid.gmane.org/1286632380-7002-1-git-send-email-drizzd@aon.at

Actually, it might not. But since it's related, I'll have a look at
it.

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMwf9VAAoJELKdZexG8uqMVqIIAKTQpMlp8vTGBcbtiNmnFyZx
h7SXjYoSdgVS0EpeMi1tJquJ0/sBEHJziPi+cvWT56iidker4OHVg8QyzSOwXJJE
ghs0Q1K1oU5Og1l3byaIvd9zgtolWCW2zn7E6pY31erzWQ1qgZhz8lo3s5n/mJON
lvz6z6oC9kI5qPDHpLAXwXOhHvwVE0T+tfjmbzpizHuebqwCVjHwv3UlQj8vsnjF
EouGlcHB6eiu444t2CoNqDT6o5FKAY2+sWLUnlgQz8exbsAMlaqwFDdS3CuDn63V
wCRVAY43mkEae5i1DKrEsceZHm3Kak1kyr2vAMR8wGmFuEYffYHJAUze59dx2/U=
=jMqe
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
