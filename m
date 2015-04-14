From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git add -p =?utf-8?Q?=E2=80=9CYour?= edited hunk does not
 apply. Edit =?utf-8?Q?again=E2=80=9D?=
Date: Tue, 14 Apr 2015 16:00:49 +0200
Message-ID: <vpqegnmizce.fsf@anie.imag.fr>
References: <loom.20150414T035141-286@post.gmane.org>
	<vpq7ftfkpue.fsf@anie.imag.fr>
	<CALv9gbMshdNhB58Otx5h8rmtCAU4qo9eNTqKSMzD_Phy7Sataw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tanky Woo <wtq1990@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 16:01:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi1Ok-0007vh-80
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 16:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755392AbbDNOBA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Apr 2015 10:01:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44542 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753464AbbDNOA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 10:00:58 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t3EE0lw0011039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 14 Apr 2015 16:00:47 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3EE0ndw016892;
	Tue, 14 Apr 2015 16:00:49 +0200
In-Reply-To: <CALv9gbMshdNhB58Otx5h8rmtCAU4qo9eNTqKSMzD_Phy7Sataw@mail.gmail.com>
	(Tanky Woo's message of "Tue, 14 Apr 2015 21:52:08 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 14 Apr 2015 16:00:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3EE0lw0011039
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1429624851.9221@6NU11w0oDfvpZiTyYQL4Kg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267139>

Tanky Woo <wtq1990@gmail.com> writes:

> Stash this hunk [y,n,q,a,d,/,j,J,g,e,?]? y
> @@ -2,3 +3,4 @@
> =A0bbb
> +added line 2
> =A0ccc
> =A0ddd
> Stash this hunk [y,n,q,a,d,/,K,g,e,?]? y

My version does n, y, not y, y. The problem is the mix of stashed/not
stashed hunks. See my other message for a reproducible test, it does
fail on Git master.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
