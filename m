From: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
Subject: Re: [PATCH v5 00/31] Follow perlcritic's recommandations
Date: Wed, 12 Jun 2013 22:34:38 +0200
Message-ID: <51B8DB5E.8030707@ensimag.fr>
References: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr> <vpqd2rrqeqg.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>,
	git@vger.kernel.org, benoit.person@ensimag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 12 22:34:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umrkh-0002Ct-53
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 22:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757906Ab3FLUei convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 16:34:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50150 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756972Ab3FLUei (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 16:34:38 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5CKYYs8004206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 22:34:34 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5CKYajA029497;
	Wed, 12 Jun 2013 22:34:36 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5CKYZJp026937;
	Wed, 12 Jun 2013 22:34:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <vpqd2rrqeqg.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 12 Jun 2013 22:34:34 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227675>

Le 12/06/2013 22:02, Matthieu Moy a =E9crit :
> C=E9lestin Matte <celestin.matte@ensimag.fr> writes:
>=20
>> Not many changes since v3. This version is only for fixing last typo=
s and
>> applying Junio's recommandations for [21/31], which I forgot in v4.
>> At this point, the only patch worth reviewing is [21/31].
>=20
> Thanks. I went through the series again and it all looks good.
>=20

Actually, there still is a problem: the "defined(@array)" (introduced
with the change in [21/31]) produces a warning.
Benoit also seems to have problems with this patch... I'm waiting for
his feedback.

--=20
C=E9lestin Matte
