From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Make git-{pull,rebase} no-tracking message friendlier
Date: Mon, 27 Feb 2012 23:06:31 +0100
Message-ID: <vpq399wc4ns.fsf@bauges.imag.fr>
References: <1330013115-26355-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Feb 27 23:07:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S28iv-0007e9-AI
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 23:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755748Ab2B0WHG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 17:07:06 -0500
Received: from mx2.imag.fr ([129.88.30.17]:36461 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085Ab2B0WHF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 17:07:05 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q1RM2Tjh010453
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 27 Feb 2012 23:02:29 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S28iG-0002wY-6O; Mon, 27 Feb 2012 23:06:32 +0100
In-Reply-To: <1330013115-26355-1-git-send-email-cmn@elego.de> ("Carlos
 =?iso-8859-1?Q?Mart=EDn?=
	Nieto"'s message of "Thu, 23 Feb 2012 17:05:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 27 Feb 2012 23:02:29 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q1RM2Tjh010453
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1330984954.48086@S1uW60eVCbuW2aMXtSB/Hg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191680>

Carlos Mart=EDn Nieto <cmn@elego.de> writes:

> -		echo "You asked me to $cmd without telling me which branch you
> -want to $op_type $op_prep, and 'branch.${branch_name#refs/heads/}.me=
rge' in
> -your configuration file does not tell me, either. Please
> -specify which branch you want to use on the command line and
> +		echo "You asked me to $cmd without telling me which branch you wan=
t to
> +$op_type $op_prep, and there is no tracking information for the curr=
ent branch.
> +Please specify which branch you want to use on the command line and
>  try again (e.g. '$example').

At this point, it may be better to actually give the full command
instead of just this "(e.g. '$example')", i.e. stg like

  git $op_type <remote> $example

I also saw users confused by the message (indeed without reading it,
but ...). Giving them something as close as possible to
cut-and-paste-able command should help.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
