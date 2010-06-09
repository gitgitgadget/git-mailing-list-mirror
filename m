From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/ PATCH 5/5] t7609: test merge and checkout error messages
Date: Wed, 09 Jun 2010 22:47:26 +0200
Message-ID: <vpqtypcx7a9.fsf@bauges.imag.fr>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-4-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-5-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-6-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-7-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 09 22:50:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMSEL-0000yO-Kq
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 22:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758248Ab0FIUu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 16:50:29 -0400
Received: from imag.imag.fr ([129.88.30.1]:37105 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753242Ab0FIUu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 16:50:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o59KlQCE021455
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 9 Jun 2010 22:47:27 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OMSBK-0002UD-Ls; Wed, 09 Jun 2010 22:47:26 +0200
In-Reply-To: <1276087446-25112-7-git-send-email-diane.gasselin@ensimag.imag.fr> (Diane Gasselin's message of "Wed\,  9 Jun 2010 14\:44\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 09 Jun 2010 22:47:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148814>

Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:

> +error: Untracked working tree files:
> +	five
> +would be overwritten by merge.
> +EOF

In my experience, newbies are often confused by this message (typical
example is students who don't believe me when I tell them not to
exchange files by email, getting untracked files from their co-workers
outside Git, and then trying to pull).

Perhaps this deserves an advice like the one we have for modified
files:

> +error: Your local changes to the files:
> +	two
> +	three
> +	four
> +would be overwritten by merge.
> +Please, commit your changes or stash them before you can merge.

(also disabled by advice.commitBeforeMerge)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
