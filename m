From: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
Subject: Re: [PATCH 01/18] Follow perlcritic's recommendations - level 5 and
 4
Date: Fri, 07 Jun 2013 14:11:17 +0200
Message-ID: <51B1CDE5.6040109@ensimag.fr>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr> <1370547263-13558-2-git-send-email-celestin.matte@ensimag.fr> <vpqa9n25ojz.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 14:11:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkvVu-0005lH-8H
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 14:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670Ab3FGMLW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 08:11:22 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49571 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920Ab3FGMLV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 08:11:21 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r57CBFdA013218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 14:11:15 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r57CBHI0013286;
	Fri, 7 Jun 2013 14:11:17 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r57CBGZV025519;
	Fri, 7 Jun 2013 14:11:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <vpqa9n25ojz.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Jun 2013 14:11:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57CBFdA013218
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371211878.40254@z0Jw74glpQEgqz5ORQQaDQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226622>

Le 07/06/2013 10:10, Matthieu Moy a =E9crit :
> It would be cool to have a "make perlcritic" target in the Makefile s=
o
> that future developers can easily re-run it and avoid repeating the s=
ame
> mistakes. As much as possible, "make perlcritic" should produce no
> output at the end of your patch series (either the warnings should be
> fixed, or they should be disabled).

The problem is that I took some policies into account for some parts of
the code, but not for all of it. For instance, in commit [15/18], I put
some numeric values in constants, but not all of them, as I think havin=
g
"arg[3]" in the code does make sense. Ignoring this policy for future
developement just to prevent the related warnings from appearing would
prevent us to see useful warning messages from this policy.
Therefore, there still are a dozen warning messages appearing in the
current state...

Anyway, should this be integrated in the current patch or added as an
independant patch?

--=20
C=E9lestin Matte
