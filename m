From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 2/2] status: fix tests to handle new verbose git status during rebase
Date: Wed, 03 Jun 2015 19:42:34 +0200
Message-ID: <vpqmw0gadth.fsf@anie.imag.fr>
References: <1433320545-14244-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	<1433320545-14244-2-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Guillaume =?iso-8859-1?Q?Pag=E8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 03 19:42:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Cgf-00055e-TF
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 19:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517AbbFCRml convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 13:42:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45737 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754011AbbFCRmk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 13:42:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t53HgVZR012002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jun 2015 19:42:31 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t53HgYmT011422;
	Wed, 3 Jun 2015 19:42:34 +0200
In-Reply-To: <1433320545-14244-2-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	("Guillaume \=\?iso-8859-1\?Q\?Pag\=E8s\=22's\?\= message of "Wed, 3 Jun 2015
 10:35:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 03 Jun 2015 19:42:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t53HgVZR012002
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433958155.26835@DxXLpivocifYCExZ+i+5XQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270709>

Guillaume Pag=E8s <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> Signed-off-by: Guillaume Pag=E8s <guillaume.pages@ensimag.grenoble-in=
p.fr>
> ---
>  t/t7512-status-help.sh | 227 +++++++++++++++++++++++++++++++++++++++=
+++++++---

Your history is not bisectable if you sparate tests and code changes in
two patches.

Plus, as a reviewer, I like seeing changes to the tests next to changes
to the code, to show me what is the impact of the code change on the
output of the program. In this case, this patch really shows what your
code is doing, and reviewing PATCH 2 means checking that we agree on th=
e
specification, which should not be done _after_ checking the code.

+  (use git rebase --edit-todo to view and edit)

All other status hints use double-quotes around commands. I think this
one should, too.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
