From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 5/5 v2] t7609: test merge and checkout error messages
Date: Tue, 15 Jun 2010 15:09:18 +0200
Message-ID: <vpqaaqwzblt.fsf@bauges.imag.fr>
References: <1276604576-28092-1-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276604576-28092-2-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276604576-28092-3-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276604576-28092-4-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276604576-28092-5-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276604576-28092-6-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 15 15:09:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOVtR-0003er-Bq
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 15:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab0FONJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 09:09:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38206 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458Ab0FONJX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 09:09:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5FD1IJN019368
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 15 Jun 2010 15:01:18 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OOVtG-0003au-T6; Tue, 15 Jun 2010 15:09:18 +0200
In-Reply-To: <1276604576-28092-6-git-send-email-diane.gasselin@ensimag.imag.fr> (Diane Gasselin's message of "Tue\, 15 Jun 2010 14\:22\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 15 Jun 2010 15:01:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5FD1IJN019368
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1277211680.90944@Qzz2EJ+yCli9QM10mZD6Ug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149182>

Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:

> +	echo two>two &&
> +	echo three>three &&
> +	echo four>four &&
> +	echo five>five &&

Space before '>' please :

2010/6/9 Junio C Hamano <gitster@pobox.com>:

>  (1) redirection ">" and "<" stick to the target file and have a SP on the
>     other end.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
