From: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
Subject: Re: [PATCH v5 00/31] Follow perlcritic's recommandations
Date: Wed, 12 Jun 2013 22:47:19 +0200
Message-ID: <51B8DE57.9040205@ensimag.fr>
References: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr> <vpqd2rrqeqg.fsf@anie.imag.fr> <51B8DB5E.8030707@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	benoit.person@ensimag.fr
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 12 22:47:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umrwx-00024m-Jr
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 22:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757959Ab3FLUrT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 16:47:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48025 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756565Ab3FLUrS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 16:47:18 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5CKlEfP009339
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 22:47:14 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5CKlGsJ029620;
	Wed, 12 Jun 2013 22:47:17 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5CKlGwI012126;
	Wed, 12 Jun 2013 22:47:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <51B8DB5E.8030707@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 12 Jun 2013 22:47:14 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227676>

Le 12/06/2013 22:34, C=E9lestin Matte a =E9crit :
> Le 12/06/2013 22:02, Matthieu Moy a =E9crit :
>> C=E9lestin Matte <celestin.matte@ensimag.fr> writes:
>>
>>> Not many changes since v3. This version is only for fixing last typ=
os and
>>> applying Junio's recommandations for [21/31], which I forgot in v4.
>>> At this point, the only patch worth reviewing is [21/31].
>>
>> Thanks. I went through the series again and it all looks good.
>>
>=20
> Actually, there still is a problem: the "defined(@array)" (introduced
> with the change in [21/31]) produces a warning.
> Benoit also seems to have problems with this patch... I'm waiting for
> his feedback.
>=20
There is indeed a bug. In patch [21/31], at line 163, it should be
if (!defined $cmd[0]) {
instead of
if (!defined @cmd) {
=2E

Should I send yet another version of this series of patch?

--=20
C=E9lestin Matte
