From: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
Subject: Re: [PATCH v2 14/22] git-remote-mediawiki: Check return value of
 open + remove import of unused open2
Date: Sat, 08 Jun 2013 20:45:04 +0200
Message-ID: <51B37BB0.7000504@ensimag.fr>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr> <1370641344-4253-15-git-send-email-celestin.matte@ensimag.fr> <CAPig+cQHPjjpt_JYHjua6VWzTjTFog9VzhpD0hOLKSPCrEnEdg@mail.gmail.com> <51B353A7.1090206@ensimag.fr> <vpqd2rwv40f.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, benoit.person@ensimag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jun 08 20:45:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlO8d-0006yZ-Nz
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 20:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558Ab3FHSpN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 14:45:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43754 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752378Ab3FHSpM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 14:45:12 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r58Ij1Vc013069
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Jun 2013 20:45:01 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r58Ij3KF013582;
	Sat, 8 Jun 2013 20:45:03 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r58Ij3m5014746;
	Sat, 8 Jun 2013 20:45:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <vpqd2rwv40f.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 08 Jun 2013 20:45:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r58Ij1Vc013069
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371321906.33978@2LYJaUBnRwqP+lRdOJflXg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226856>

Le 08/06/2013 20:41, Matthieu Moy a =E9crit :
> C=E9lestin Matte <celestin.matte@ensimag.fr> writes:
>=20
>> Le 08/06/2013 02:14, Eric Sunshine a =E9crit :
>>> These two changes are unrelated and could be split into distinct
>>> patches (IMHO, though others may disagree).
>>
>> Two distinct patches or two distinct commits?
>=20
> That's the same. You write commits locally, send them as patches, and
> Junio uses "git am" to turn the patches back into commits.
>=20

Oh, I thought a part of a patch was called a commit. So the question wa=
s
rather: "Should it be sent to this list independently from this series
of patches?".

--=20
C=E9lestin Matte
