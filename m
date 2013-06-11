From: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
Subject: Re: [PATCH v3 07/28] git-remote-mediawiki: Rewrite unclear line of
 instructions
Date: Tue, 11 Jun 2013 22:13:28 +0200
Message-ID: <51B784E8.8020700@ensimag.fr>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr> <1370816573-3808-8-git-send-email-celestin.matte@ensimag.fr> <7vsj0od6z5.fsf@alter.siamese.dyndns.org> <vpq1u8838rv.fsf@anie.imag.fr> <7vhah4bjtf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?ISO-8859-1?Q?C=E9lesti?= =?ISO-8859-1?Q?n_Matte?= 
	<celestin.matte@ensimag.fr>, git@vger.kernel.org,
	benoit.person@ensimag.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 22:13:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmUx0-00036F-Ug
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 22:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757003Ab3FKUNi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 16:13:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45868 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757075Ab3FKUNh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 16:13:37 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5BKDOpb001850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Jun 2013 22:13:24 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5BKDRbw023131;
	Tue, 11 Jun 2013 22:13:27 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5BKDQ6t003063;
	Tue, 11 Jun 2013 22:13:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7vhah4bjtf.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 11 Jun 2013 22:13:25 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227511>

Le 11/06/2013 20:09, Junio C Hamano a =E9crit :
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>=20
>>>       my ($namespace) =3D @_;
>>> 	my $namespace =3D shift;
>>>
>>> My impression has been that both are equally common,
>>
>> The second is the most common in git-remote-mediawiki (but I don't h=
ave
>> any preference nor know what is recommended elsewhere).
>=20
> I wasn't implying I prefer the former.  I was just being curious,
> and if the latter is more prevalent in the code _and_ Perlcritique
> does not have any issue with it, it is perfectly fine.

Perlcritic doesn't have an issue with any of both cases.
I think the second method is clearer when there is only one argument,
because it makes it clear that there is only one.

--=20
C=E9lestin Matte
