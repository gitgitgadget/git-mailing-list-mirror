From: =?UTF-8?Q?Mathieu_Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
Subject: Re: [PATCH 2/2] rm: introduce advice.rmHints to shorten messages
Date: Mon, 10 Jun 2013 19:17:07 +0200
Message-ID: <13e4098ead63ece337f065669dcc64ec@ensibm.imag.fr>
References: <1370868700-27189-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
 <1370868700-27189-2-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
 <18c54938bf29444008aec7b3e48912dc@ensibm.imag.fr>
 <7vd2rtkiov.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	<git@vger.kernel.org>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 19:22:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um5nz-0002ty-E5
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 19:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450Ab3FJRWv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 13:22:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43741 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485Ab3FJRWv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 13:22:51 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5AHH5AW014481
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 19:17:05 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5AHH7fD017231;
	Mon, 10 Jun 2013 19:17:07 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r5AHH7ew021025;
	Mon, 10 Jun 2013 19:17:07 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r5AHH7XE021024;
	Mon, 10 Jun 2013 19:17:07 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to mathieu.lienard--mayor@ensimag.fr using -f
In-Reply-To: <7vd2rtkiov.fsf@alter.siamese.dyndns.org>
X-Sender: mathieu.lienard--mayor@ensimag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 10 Jun 2013 19:17:05 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227328>

Le 2013-06-10 18:57, Junio C Hamano a =C3=A9crit=C2=A0:
> Mathieu Li=C3=A9nard--Mayor  <mathieu.lienard--mayor@ensimag.fr> writ=
es:
>
>> Please ignore this, manipulation error while in the git send-email
>> command line.
>
> Here is what my mailbox looks like (the penultimate one with 252
> lines is what I am responding to).
>
>   R. [ 146: Mathieu Lienard--Mayor ] [PATCH 1/2] rm: better error=20
> messa
>   R. [ 231: Mathieu Lienard--Mayor ] [PATCH 2/2] rm: introduce=20
> advice.r
>   R. [ 157: Mathieu Lienard--Mayor ] [PATCH 2/2] rm: introduce=20
> advice.r
>   R. [ 198: Mathieu Lienard--Mayor ] [PATCH v2 1/2] rm: better error=20
> me
>   R. [ 157: Mathieu Lienard--Mayor ] [PATCH v2 2/2] rm: introduce=20
> advic
>    . [ 153: Mathieu Lienard--Mayor ] [PATCH v3 2/2] rm: introduce=20
> advic
>    . [ 214: Mathieu Lienard--Mayor ] [PATCH v3 1/2]  rm: better error=
=20
> m
>    . [ 214: Mathieu Lienard--Mayor ] [PATCH v3 1/2]  rm: better error=
=20
> m
>    . [ 153: Mathieu Lienard--Mayor ] [PATCH v3 2/2] rm: introduce=20
> advic
>   R  [  33: Mathieu Li=C3=A9nard--Mayor ] Re: [PATCH 1/2] rm: better =
error=20
> m
>   O  [  38: Mathieu Li=C3=A9nard--Mayor ] Re: [PATCH 2/2] rm: introdu=
ce=20
> advi
>   R. [ 156: Mathieu Li=C3=A9nard--Mayor ] Re: [PATCH 1/2] rm: better =
error=20
> m
>   R. [ 252: Mathieu Li=C3=A9nard--Mayor ] Re: [PATCH 2/2] rm: introdu=
ce=20
> advi
>    . [  84: Mathieu Li=C3=A9nard--Mayor ] Re: [PATCH v2 1/2] rm: bett=
er=20
> erro
>
> I am guessing that [v3 1/2] and [v3 2/2] are the final ones but it
> that is not the case please holler.
Yes, [v3 1/2] and [v3 2/2] are the final ones.
i'm sorry, i really don't know how i managed to create such a mess, i'm=
=20
still not familiar with the send-email tool =3D/
--=20
Mathieu Li=C3=A9nard--Mayor,
2nd year at Grenoble INP - ENSIMAG
(+33)6 80 56 30 02
