From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2] rebase [-i --exec | -ix] <CMD>...
Date: Thu, 07 Jun 2012 15:43:13 +0200
Message-ID: <vpqobov5jbi.fsf@bauges.imag.fr>
References: <1338817674-22877-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<4FD06906.1080007@kdbg.org>
	<20120607140404.Horde.hAwfKHwdC4BP0Ji0lAVB6zA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Thu Jun 07 15:43:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scczo-0001iH-7Y
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 15:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209Ab2FGNnY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 09:43:24 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45865 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932163Ab2FGNnX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 09:43:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q57DYNtX030130
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 7 Jun 2012 15:34:25 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sccza-0001Sv-DQ; Thu, 07 Jun 2012 15:43:14 +0200
In-Reply-To: <20120607140404.Horde.hAwfKHwdC4BP0Ji0lAVB6zA@webmail.minatec.grenoble-inp.fr>
	(konglu@minatec.inpg.fr's message of "Thu, 07 Jun 2012 14:04:04
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 07 Jun 2012 15:34:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q57DYNtX030130
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339680869.52388@XVVOsbY/t6hfQOLZt/6uvQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199408>

konglu@minatec.inpg.fr writes:

> Johannes Sixt <j6t@kdbg.org> a =E9crit=A0:
>
>> BTW, I don't think it is a good idea to dump the usage if -x was use=
d
>> without -i.
>
> In fact, that would be the next step, so that the "--exec" option cou=
ld
> be used without the interactive mode.

I think Jeff meant that a short error message would be better than
showing the complete usage instruction, which indeed is already the
case:

+if test -n "$cmd" &&
+   test "$interactive_rebase" !=3D explicit
+then
+	die "--exec option must be used with --interactive option\n"
+fi

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
