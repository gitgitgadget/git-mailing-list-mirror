From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] send-email: do not check for editor until needed
Date: Tue, 23 Mar 2010 14:25:57 -0500
Message-ID: <20100323192557.GA1511@progeny.tock>
References: <20100322145947.GA1709@pengutronix.de>
 <20100322232531.GA2168@progeny.tock>
 <A612847CFE53224C91B23E3A5B48BAC73EC0B01EE8@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Kleine-Budde <m.kleine-budde@pengutronix.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 20:26:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu9jv-00082B-CY
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 20:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab0CWT0G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 15:26:06 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54490 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab0CWT0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 15:26:04 -0400
Received: by pva18 with SMTP id 18so188255pva.19
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 12:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OOuylF9VCiuGbQfI6nZFUy2TagDkLPl66oap3tZIyus=;
        b=vgZV5cXeGsxlQjaGQ7dFOeyvttmzW0Ja0WXefHiA7O54gwH91iMoPKnfWpsI5sny8b
         fSeQVY7UXU4+bq6aJqklIO/TcvPlV1BC1rwrtha8GMNdQyvXMmBOW221hKE3F2ieglHT
         AXZzc4QbYcccRrU4POm4kPwkk8yKIffhIjIlU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=YfjMA99ge6NqbhMxm/fEBL15OBrdjEu8L39Kinz8rHnj6dHDwvp61VAQ7JWzIe3SVc
         yFjsKhwVkddhwDWnVXCdMUGozWSakRS2nQSUkRVNvUTjh2Snq2LrbRmuWLGTxu4LzN6M
         YMUitIVJUgocoWQ66Kb7p/Udbjg0VX2WQOvYo=
Received: by 10.141.188.8 with SMTP id q8mr6707631rvp.0.1269372362834;
        Tue, 23 Mar 2010 12:26:02 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm5258812iwn.15.2010.03.23.12.26.01
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Mar 2010 12:26:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC73EC0B01EE8@xmail3.se.axis.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143044>

Peter Kjellerstedt wrote:

> Shouldn't that be:
>=20
> 	if ($#_ =3D=3D -1) {
> 		return;
> 	}
>=20
> or more readable:
>=20
> 	return if (!@_);

Probably. :)

> as I assume you are trying to protect do_edit() from being called=20
> without arguments?

I tested out Michael J Gruber=E2=80=99s simpler patch and it both makes=
 sense
and works fine, so I=E2=80=99d suggest going with it instead.

Still, thanks for the comments.  It is good to know what I need to
learn.

Regards,
Jonathan
