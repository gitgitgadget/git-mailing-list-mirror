From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH v2 1/3] blame: add --abbrev command line option
Date: Wed, 06 Apr 2011 20:06:37 +0900
Message-ID: <1302087997.1509.0.camel@leonhard>
References: <1302056452-5387-1-git-send-email-namhyung@gmail.com>
	 <7vy63ojced.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 13:06:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7QZa-00065x-6u
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 13:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212Ab1DFLGq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 07:06:46 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41941 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321Ab1DFLGp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 07:06:45 -0400
Received: by iyb14 with SMTP id 14so1309775iyb.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 04:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=QFD/lZ4S9wbqyNH/d0NDAWyrpiyxkm9X6eMvbPgnLDs=;
        b=uMrkQORdY4+xP+8+gKzhoTO0vI+IFfpPAUXPm4OfBQwfbLgzaE+4uDczhJeeaG+tl8
         6BQPREqJchrzyUfPImSzj9rPPHCg+DqMs/3feaTcZhnB7zYfdfSmoWqimOVR6wB7X5Pw
         /QIl5ilu3lCAfP+z3t6PnnFr/9x4lYOgBzElU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=phzAaUgejX+cxQnZ0AFbsbmWbId3VyQz1B1MVy7n9vnpxWIOFWEKEmyvNBpjLGfHIS
         hDPktWE/rrVc3DVXASNjfxVXRLYlxMVwZW+cSPz2HuP9YLGOsP0USKwAEDiC0gulaoPu
         oFICCmOYTdt8gK0Qj4o5K9c1yfK7UsRtciPlw=
Received: by 10.231.28.164 with SMTP id m36mr332934ibc.163.1302088005083;
        Wed, 06 Apr 2011 04:06:45 -0700 (PDT)
Received: from [118.176.76.173] ([118.176.76.173])
        by mx.google.com with ESMTPS id g16sm357504ibb.37.2011.04.06.04.06.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 04:06:43 -0700 (PDT)
In-Reply-To: <7vy63ojced.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170963>

2011-04-05 (=ED=99=94), 20:18 -0700, Junio C Hamano:
> Thanks.
>=20
> As the meaning of the option changes between 1/3 and 2/3, let's squas=
h
> these three patches into a single commit.  Here is what I've tentativ=
ely
> queued.
>=20

Great! Thanks.


> commit 84393bfd731c435120dc1dda63432a70124821cb
> Author: Namhyung Kim <namhyung@gmail.com>
> Date:   Wed Apr 6 11:20:50 2011 +0900
>=20
>     blame: add --abbrev command line option and make it honor core.ab=
brev
>    =20
>     If user sets config.abbrev option, use it as if --abbrev was give=
n.  This
>     is the default value and user can override different abbrev lengt=
h by
>     specifying the --abbrev=3DN command line option.
>    =20
>     Signed-off-by: Namhyung Kim <namhyung@gmail.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>


--=20
Regards,
Namhyung Kim
