From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH] branch: honor core.abbrev
Date: Fri, 01 Jul 2011 15:10:40 +0900
Message-ID: <1309500640.1310.53.camel@leonhard>
References: <1309449762-10476-1-git-send-email-namhyung@gmail.com>
	 <m2pqlvmayd.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Jul 01 08:10:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcWwE-0004vo-Vg
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 08:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829Ab1GAGKq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jul 2011 02:10:46 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59076 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792Ab1GAGKp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2011 02:10:45 -0400
Received: by gwaa18 with SMTP id a18so1222851gwa.19
        for <git@vger.kernel.org>; Thu, 30 Jun 2011 23:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=DCkxzmh0Yg3vCyvlOTV3zHVDigQwLB0F0hqoeSbOnOw=;
        b=cn7dmK8H5gcDisbzmYhVnZhs4RhhvBVZLnD4NlyQ3DBjMwpIa+4gjaKItixV2J3f/l
         AAP/e8LU8dudFE6SwhUuPFPOEcTXwVkqAjIa9vQsKRltUMA3tRMGS0uJhuf+mljLVB7U
         9xOBARB8pXHWfSUxLOuv2fP05mPnlcnh9s1VE=
Received: by 10.236.181.68 with SMTP id k44mr3419158yhm.143.1309500645084;
        Thu, 30 Jun 2011 23:10:45 -0700 (PDT)
Received: from [192.168.111.3] ([118.176.76.64])
        by mx.google.com with ESMTPS id h70sm2200405yhk.29.2011.06.30.23.10.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 30 Jun 2011 23:10:44 -0700 (PDT)
In-Reply-To: <m2pqlvmayd.fsf@igel.home>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176517>

2011-06-30 (=EB=AA=A9), 20:27 +0200, Andreas Schwab:
> Namhyung Kim <namhyung@gmail.com> writes:
>=20
> > diff --git a/Documentation/git-branch.txt b/Documentation/git-branc=
h.txt
> > index c50f189..906cccc 100644
> > --- a/Documentation/git-branch.txt
> > +++ b/Documentation/git-branch.txt
> > @@ -114,6 +114,7 @@ OPTIONS
> >  --abbrev=3D<length>::
> >  	Alter the sha1's minimum display length in the output listing.
> >  	The default value is 7.
> > +	(and can be overrided by the `core.abbrev` config option).
>=20
> overridden
>=20
> Andreas.
>=20

=46ixed and resent.

Thanks.

--=20
Regards,
Namhyung Kim
