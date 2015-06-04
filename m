From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC v4 3/3] git-am: add am.threeWay config variable
Date: Thu, 04 Jun 2015 17:11:47 +0200
Message-ID: <vpqeglrik3w.fsf@anie.imag.fr>
References: <1433430295-10805-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433430295-10805-3-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 04 17:12:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0WoQ-0005I0-7h
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 17:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbbFDPMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 11:12:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43122 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108AbbFDPL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 11:11:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t54FBj4J023747
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 4 Jun 2015 17:11:45 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t54FBlTb000456;
	Thu, 4 Jun 2015 17:11:47 +0200
In-Reply-To: <1433430295-10805-3-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Thu, 4 Jun 2015 17:04:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 04 Jun 2015 17:11:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t54FBj4J023747
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434035508.74954@fyc979BvYfp1hSwcihw8Hw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270780>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> @@ -90,10 +90,13 @@ default.   You can use `--no-utf8` to override this.
>  
>  -3::
>  --3way::
> +--no-3way::
>  	When the patch does not apply cleanly, fall back on
>  	3-way merge if the patch records the identity of blobs
>  	it is supposed to apply to and we have those blobs
> -	available locally.
> +	available locally. `--no-3way` can be used to override
> +	am.threeWay configuration variable. For more information,
> +	see am.threeWay in git-config(1).

... in linkgit:git-config[1].

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
