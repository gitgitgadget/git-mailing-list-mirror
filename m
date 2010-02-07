From: David Aguilar <davvid@gmail.com>
Subject: Re: Gmail and unwanted line-wrapping
Date: Sat, 6 Feb 2010 16:24:14 -0800
Message-ID: <20100207002413.GA14744@gmail.com>
References: <bc341e101002061229t7a1525c2w2d5a8e221124b3c2@mail.gmail.com> <fabb9a1e1002061247k7a8fba5at4c687faac0dcabb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Aaron Crane <git@aaroncrane.co.uk>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 01:24:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndux1-0006n3-Fr
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 01:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725Ab0BGAYV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 19:24:21 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:49428 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181Ab0BGAYU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 19:24:20 -0500
Received: by iwn27 with SMTP id 27so839369iwn.5
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 16:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=uhuOrJY80i6IezBsOQ3cdcW54PZppFWowvegltUvq1E=;
        b=kNmY1i3E03rStj5pqWMMGNR/FRgvskXT9Dh1HnfMJm8ymEOWf6NvNmQ6KkESTnGY+X
         7dFHfG8bqNnCpRVP60WTngibXENE5k1sIiPv4/ZtVqImpQO0CISl0oO8+jf43mFhFEuF
         O+reGvUTL2geMZTmpyPHHDDUzgNXnvI6IE5Tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kH3WpfI7SgsbjPRP3MtHKX5Eeq63tRy6Gie/H/aBRkBLX6mK4pxbzKqgI4Va38yWtI
         g+imhMp6ez6UM8fqYQPA3wswT13cUeHy/RvpQ4vtrWp9pTKywWG9YDvEoL0djGpX/hqa
         JSKt9EKSC6f5E2Q0VVNWnQtNXIwQyTyAdPXJA=
Received: by 10.231.158.21 with SMTP id d21mr2143779ibx.61.1265502260163;
        Sat, 06 Feb 2010 16:24:20 -0800 (PST)
Received: from gmail.com ([12.183.88.10])
        by mx.google.com with ESMTPS id 21sm2648741iwn.6.2010.02.06.16.24.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 16:24:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <fabb9a1e1002061247k7a8fba5at4c687faac0dcabb8@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139201>

On Sat, Feb 06, 2010 at 09:47:39PM +0100, Sverre Rabbelier wrote:
> Heya,
>=20
> On Sat, Feb 6, 2010 at 21:29, Aaron Crane <git@aaroncrane.co.uk> wrot=
e:
> > Can anyone think of anything I might have done wrong here? =C2=A0If=
 not,
> > I'm inclined to suggest dropping all of that advice. =C2=A0That's n=
ot
> > ideal, because it leaves Gmail users with no obvious way to submit
> > well-formatted patches to the list; but it's better than suggesting
> > something which apparently doesn't work.
>=20
> I'm using git send-email with this configuration:
> [sendemail]
>   smtencryption =3D tls
>   smtpserver =3D smtp.gmai.com
>   smtpuser =3D srabbelier@gmail.com
>   smptserverport =3D 587
>=20
> It'll ask you for your password when you're sending the emails. Like =
so:
>=20
> $ git format-patch --no-color -C -M origin/master..topic-branch -o ou=
tgoing/
> $ git send-email --compose outgoing/00*
>=20
> Of course you should substitute specific things as appropriate, I
> doubt you'll want to be sending your patches pretending to be me :P.
>=20
> --=20
> Cheers,
>=20
> Sverre Rabbelier

Great tip!

I've added it to the Git Wiki:
http://git.wiki.kernel.org/index.php/GitTips#Using_gmail_to_send_your_p=
atches


Good stuff,

--=20
		David
