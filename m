From: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
Subject: Re: [PATCH 05/18] Turn double-negated expressions into simple expressions
Date: Fri, 07 Jun 2013 22:32:48 +0200
Message-ID: <51B24370.3020706@ensimag.fr>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr> <1370547263-13558-6-git-send-email-celestin.matte@ensimag.fr> <CAPig+cSDxhT=WVMQz_88z0xEmPVENDSyp5mE7XWCf_99yQTkTA@mail.gmail.com> <51B2129F.3040304@ensimag.fr> <CAPig+cRamEU1jREcFnN4hzDaSXNFL2N1gRt98jEBJ7ogzor-ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 22:32:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3LF-0005Fy-VO
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab3FGUcy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 16:32:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51026 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752746Ab3FGUcx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:32:53 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r57KWjgU014869
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 22:32:45 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r57KWlCr029146;
	Fri, 7 Jun 2013 22:32:47 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r57KWkwj028511;
	Fri, 7 Jun 2013 22:32:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <CAPig+cRamEU1jREcFnN4hzDaSXNFL2N1gRt98jEBJ7ogzor-ZA@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 07 Jun 2013 22:32:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57KWjgU014869
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371241967.55245@Yo+AM308UeCDaprGrPVH9Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226698>

Le 07/06/2013 22:25, Eric Sunshine a =E9crit :
> If you do choose to be more precise, it should be done as a separate
> patch. Each conceptually distinct change should have its own patch.
> Doing so makes changes easier to review and (generally) easier to
> cherry-pick. For example, in this particular case, "simplify
> doubly-negated expressions" is quite conceptually distinct from "emit
> more precise diagnostics". (Textually the changes may happen to
> overlap, but conceptually they are unrelated.)

OK, I will do another patch.

--=20
C=E9lestin Matte
