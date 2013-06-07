From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 09/18] Check return value of open and remove import of unused open2
Date: Fri, 07 Jun 2013 10:21:54 +0200
Message-ID: <vpqzjv249gd.fsf@anie.imag.fr>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
	<1370547263-13558-10-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr
To: =?iso-8859-1?Q?C=E9lestin?= Matte <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 10:22:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukrw5-0007re-V9
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 10:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357Ab3FGIWI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 04:22:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57748 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911Ab3FGIWF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 04:22:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r578LsNd020812
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 10:21:54 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ukrvn-0005VC-4y; Fri, 07 Jun 2013 10:21:55 +0200
In-Reply-To: <1370547263-13558-10-git-send-email-celestin.matte@ensimag.fr>
	(=?iso-8859-1?Q?=22C=E9lestin?= Matte"'s message of "Thu, 6 Jun 2013
 21:34:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Jun 2013 10:21:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r578LsNd020812
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1371198116.36321@AvAYF5dRbadVPxNm1jyWDw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226613>

C=E9lestin Matte <celestin.matte@ensimag.fr> writes:

>  use URI::Escape;
> -use IPC::Open2;
>  use Readonly;

This should have belonged to bp/mediawiki-credential, but it's already
in next so it's OK to fix it here.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
