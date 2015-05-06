From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/3] git help: group common commands by theme
Date: Wed, 06 May 2015 09:59:20 +0200
Message-ID: <vpqfv7ap25j.fsf@anie.imag.fr>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
To: =?iso-8859-1?Q?S=E9bastien?= Guimmara 
	<sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 09:59:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpuEz-0006SC-8C
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 09:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbbEFH7c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2015 03:59:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60010 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbbEFH7b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 03:59:31 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t467xKjP024916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 May 2015 09:59:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t467xKTg003998;
	Wed, 6 May 2015 09:59:20 +0200
In-Reply-To: <cover.1430770308.git.sebastien.guimmara@gmail.com>
 (=?iso-8859-1?Q?=22S=E9bastien?=
	Guimmara"'s message of "Mon, 4 May 2015 22:28:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 06 May 2015 09:59:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t467xKjP024916
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1431503963.02689@YLC5AqybgM1UJpRWtr+B2w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268455>

S=E9bastien Guimmara <sebastien.guimmara@gmail.com> writes:

>    * examining the history and state:
>       log        Show commit logs
>       status     Show the working tree status
>
>    * growing, marking and tweaking your history:
>       branch     List, create, or delete branches
>       checkout   Checkout a branch or paths to the working tree
>       commit     Record changes to the repository
>       diff       Show changes between commits, commit and working [..=
=2E]
>       merge      Join two or more development histories together

I would have put "diff" next to "status" in the "examining the history
and state" section. It's neither growing, marking nor tweaking the
history.

> I removed from the list of common commands: rebase, rm, mv, bisect=20
> because [1] they are not really common to an unfamiliar user,

I tend to agree for rebase and bisect (even though showing them to
beginners may give them a hint on why Git can be good for them).

But removing rm and mv seems weird. It seems to me that the obvious
question of someone who just learnt "add" would be "and how do I do the
opposite?".

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
