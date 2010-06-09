From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/ PATCH 2/5] unpack_trees: group errors by type
Date: Wed, 09 Jun 2010 22:59:05 +0200
Message-ID: <vpqljanylba.fsf@bauges.imag.fr>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-4-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 09 22:59:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMSMl-00066H-G0
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 22:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287Ab0FIU7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 16:59:10 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60850 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583Ab0FIU7J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 16:59:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o59KpLD9002012
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 9 Jun 2010 22:51:21 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OMSMb-0002bF-BI; Wed, 09 Jun 2010 22:59:05 +0200
In-Reply-To: <1276087446-25112-4-git-send-email-diane.gasselin@ensimag.imag.fr> (Diane Gasselin's message of "Wed\,  9 Jun 2010 14\:44\:03 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 09 Jun 2010 22:51:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o59KpLD9002012
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148816>

Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:

> +		error(msg,file,action);

Style: spaces after commas. grep your patch for ',[^ ]' to find many
other occurences.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
