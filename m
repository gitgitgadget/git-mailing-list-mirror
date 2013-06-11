From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 07/28] git-remote-mediawiki: Rewrite unclear line of instructions
Date: Tue, 11 Jun 2013 18:35:32 +0200
Message-ID: <vpq1u8838rv.fsf@anie.imag.fr>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
	<1370816573-3808-8-git-send-email-celestin.matte@ensimag.fr>
	<7vsj0od6z5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?C=E9lestin?= Matte <celestin.matte@ensimag.fr>,
	git@vger.kernel.org, benoit.person@ensimag.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 18:35:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmRXq-0000T7-9P
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 18:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875Ab3FKQfi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 12:35:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57989 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956Ab3FKQfi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 12:35:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5BGZUlK015666
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 11 Jun 2013 18:35:30 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UmRXh-0006kN-1v; Tue, 11 Jun 2013 18:35:33 +0200
In-Reply-To: <7vsj0od6z5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 11 Jun 2013 08:04:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 11 Jun 2013 18:35:31 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227462>

Junio C Hamano <gitster@pobox.com> writes:

> C=E9lestin Matte <celestin.matte@ensimag.fr> writes:
>
>> Subroutines' parameters should be affected to variable before doing =
anything
>> else
>> Besides, existing instruction affected a variable inside a "if", whi=
ch break
>> Git's coding style
>
> I think s/affect/assign/g is what you meant.

Yes, common false friends for French people ;-).

>       my ($namespace) =3D @_;
> 	my $namespace =3D shift;
>
> My impression has been that both are equally common,

The second is the most common in git-remote-mediawiki (but I don't have
any preference nor know what is recommended elsewhere).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
