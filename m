From: Ali Polatel <polatel@gmail.com>
Subject: Re: git clone http://git.savannah.gnu.org/cgit/xboard.git segfaults
Date: Wed, 26 Aug 2009 16:12:35 +0300
Message-ID: <20090826131235.GF16486@harikalardiyari>
References: <alpine.DEB.1.00.0908171620160.4991@intel-tinevez-2-302> <20090817135651.GA4570@harikalardiyari> <20090826202053.6e6442a6.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oPmsXEqKQNHCSXW7"
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 15:12:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgIJ1-0001Uz-0x
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 15:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932966AbZHZNMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 09:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932957AbZHZNMm
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 09:12:42 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:63506 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932919AbZHZNMl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 09:12:41 -0400
Received: by bwz19 with SMTP id 19so107697bwz.37
        for <git@vger.kernel.org>; Wed, 26 Aug 2009 06:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jZN50FonZcxwu90ITtmtwPQk+mS5kHQ4gAIINgwWhpY=;
        b=FBgDhSNN20ZpfTU3DGKwsT4BsT9NfygB++ke5eZS4rJyCKeBaDScCH9doGUG8p/7m/
         sB8Z9fD/ZUZGgJ4zLLWUFBDzqcX4jEzefBLmPSQcKrKJirXIrPvAuLKFC5UJ0Tnm+jgt
         Eb5Yh+li422N/O7a5vTwrHxI05oKgQgpbGfj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WCgQXfUu08Z+VbWEQNDlRId4M6KqRrJxoEm0EemrkdsryG/pCGa4EGpNWcM+q1tlhC
         Ek4LG5OjHf89NjSkiO7CddcuwoUu2+DSG1YlkJxX0wa13lZ2m9dH7j3eyPIVBODc2IfH
         FIZaFJr6gg0y1Rrl/Q/nSO+ZSd6plsbDUU6zk=
Received: by 10.204.160.80 with SMTP id m16mr3630509bkx.138.1251292360293;
        Wed, 26 Aug 2009 06:12:40 -0700 (PDT)
Received: from harikalardiyari ([78.179.43.183])
        by mx.google.com with ESMTPS id g28sm9169274fkg.45.2009.08.26.06.12.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Aug 2009 06:12:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090826202053.6e6442a6.rctay89@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127094>


--oPmsXEqKQNHCSXW7
Content-Type: text/plain; charset=iso-8859-9
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Tay Ray Chuan yazm=FD=FE:
> Hi,
>=20
> On Mon, Aug 17, 2009 at 10:22 PM, Johannes Schindelin<Johannes.Schindelin=
@gmx.de> wrote:
> > Seems that an object request is aborted, but the slot, and therefore the
> > callback, is called nevertheless.  Tay, does that ring a bell?
>=20
> thanks Johannes, your diagnosis was a vital clue.
>=20
> Ali, could you see if this patch fixes it for you? On my side, I had
> some difficulty reproducing your problem reliably (it happened
> sometimes but not on other times).
>=20

It works, I don't get any segfaults after applying this patch.

--=20
Regards,
Ali Polatel

--oPmsXEqKQNHCSXW7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEABECAAYFAkqVNMMACgkQQU4yORhF8iDLlACffde6klc85OttjEK1V9Sw6tlq
VkYAn3m1BZtiJd5gn4ax94z3dM/ZlJTd
=caYX
-----END PGP SIGNATURE-----

--oPmsXEqKQNHCSXW7--
