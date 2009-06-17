From: "=?utf-8?q?K=C4=81rlis_Repsons?=" <karlis.repsons@gmail.com>
Subject: Re: Repository authenticity question
Date: Wed, 17 Jun 2009 07:57:51 +0000
Message-ID: <200906170757.59476.Karlis.Repsons@gmail.com>
References: <200906131527.03450.Karlis.Repsons@gmail.com> <4A33C980.40003@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1408173.FLWQk0zBvq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jun 17 09:58:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGq27-0008Fv-Ql
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 09:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbZFQH6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 03:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbZFQH6A
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 03:58:00 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:52482 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbZFQH57 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 03:57:59 -0400
Received: by bwz9 with SMTP id 9so119775bwz.37
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 00:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:cc:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=pPBzfzHZFjOKn89Kgm0y6JTEBVvOVzkwnocq/LkWPLU=;
        b=vT1QJpg+3/XGDVHlCxvBKd9raV37/QMTT/GAsM38tm7HZYKIn6ly/BQ2RZdeeRkLE5
         +3f4Efz8Qe9b8dLNhmFF9kiqFHo/ifM3wjPqLKVxA38OQ/7mhn/SObP+qan+SuUXY064
         HrNa9BGkX1/FgQaxt2Y9IbxSSuJluGC5Hvrlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:cc
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=qISISjQ6ALEGCAuT17OUqjXvH5wM4omgmVWPveZybmzYsRTs1AHkuacvJD86SioegW
         nP2yVhMai9uW0mR7VNPKXzQwSYpNV9SRww+99JRN7vEvAL0ReWF2GMjHvYhoMyYFfJ1v
         ahCK8TUTVv+bYdakcGVC0KguamGN97kZ5v/9Y=
Received: by 10.204.77.102 with SMTP id f38mr9121162bkk.62.1245225480990;
        Wed, 17 Jun 2009 00:58:00 -0700 (PDT)
Received: from ?192.168.7.93? ([85.15.210.9])
        by mx.google.com with ESMTPS id 28sm328294bwz.116.2009.06.17.00.58.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Jun 2009 00:58:00 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <4A33C980.40003@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121727>

--nextPart1408173.FLWQk0zBvq
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 13 June 2009 15:45:04 you wrote:
> K=C4=81rlis Repsons venit, vidit, dixit 13.06.2009 17:26:
> > Hi,
> > It would be good to know what did Linus meant, when he said "and they
> > will fail" about people, who would try changing some git projects'
> > history (that is, the content, that is added already)? If I loose my
> > repository completely, can I still know, that those contributions there
> > are the same after I pull and how? What contents can be deleted, while
> > still retaining consistency?
> >
> > Regards,
> > K=C4=81rlis
>
> The sha1 ("object name") of a commit depends not only on its contents,
> but on all its predecessors. So if you know one commit's sha1 to be
> "original" you know for all its ancestors.
>
> Michael

So, if I clone someone else's git archive, sha1 of a known commit must be=20
compared and what else? How to check if all of archive's sha1-s are identic=
al=20
to its contents and every content is included?

--nextPart1408173.FLWQk0zBvq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAko4ogcACgkQHuSu329e3GHFuwCeKokXqg40lHmBQhOYprWU5XEp
QIoAoOQa5Oe7xilRWrSFiA9BeJkk8Z5R
=jXxM
-----END PGP SIGNATURE-----

--nextPart1408173.FLWQk0zBvq--
