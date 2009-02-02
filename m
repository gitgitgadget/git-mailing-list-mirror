From: Jeremy O'Brien <obrien654j@gmail.com>
Subject: Re: git grep -I bug
Date: Mon, 2 Feb 2009 13:26:01 -0500
Message-ID: <20090202182601.GA173@Ambelina.local>
References: <20090202174257.GA8259@Ambelina.erc-wireless.uc.edu> <7vwsc8hgh4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 19:27:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU3WB-00076a-O9
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 19:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbZBBS0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 13:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753140AbZBBS0K
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 13:26:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:65176 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbZBBS0J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 13:26:09 -0500
Received: by ug-out-1314.google.com with SMTP id 39so19617ugf.37
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 10:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=l6yzjKENL/BaQfkvuiHeLpDdU9OEikpwFCwfArCFWHg=;
        b=pLspDVhQUjDaKEvKU50kbecqrDqBlJZER7kvFWMabifML+mppEtiVZ0nJiP3tsoU8A
         CfbhVurp/41RHRJwbke4YPz94W4At0a3ojM0YHSNF9hWuIvrs8YgErI4WYnEt0Gz/Lov
         lYl9ke8t5+B/9by/B8US2ZeZsciRArKnW8ffQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=wRRksZpDtgpradBJYhp7641KAPPV/u04g2SH5OtaE8feD3oD80hRDvCS6o9JRT2JMt
         A/G4qAOH3soWHysPk/9RLJVfmE4IghrWxCgZjshGyFUXespf07GsfS7/SjoJgVlvHXaF
         tcikG2NNLRDcBFooQwpU5vUWFZBvX6XQvkquQ=
Received: by 10.66.220.12 with SMTP id s12mr1698196ugg.22.1233599166346;
        Mon, 02 Feb 2009 10:26:06 -0800 (PST)
Received: from Ambelina.local (rrcs-70-62-238-70.central.biz.rr.com [70.62.238.70])
        by mx.google.com with ESMTPS id b39sm1748022ugf.18.2009.02.02.10.26.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Feb 2009 10:26:05 -0800 (PST)
Mail-Followup-To: Jeremy O'Brien <obrien654j@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vwsc8hgh4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108103>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2009 at 09:54:31AM -0800, Junio C Hamano wrote:
> Jeremy O'Brien <obrien654j@gmail.com> writes:
>=20
> > I am running git version 1.6.1.2.309.g2ea3.
> >
> > When I use
> >
> > git grep -I "string_to_match"
> >
> > to ignore binary files in my grep, binary files are returned anyway.
>=20
> One sanity check.  What does 'git grep --cached -I "string_to_match"' do
> in that case?
>=20

It works as expected. It is interesting that while my Linux install was
affected by this bug, my Mac OS X install did not seem to be affected by
it, while running the same version of git.

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Darwin)

iEYEARECAAYFAkmHOrgACgkQJUoJkLEUD9tfKgCgnjcmvZI+MSzUAxSXAi+ocnSd
4HoAn1KFiJ8FdfZkMOvXXVenkX9vUKSC
=ba9M
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
