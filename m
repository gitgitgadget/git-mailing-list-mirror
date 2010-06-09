From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/ PATCH 5/5] t7609: test merge and checkout error messages
Date: Wed, 09 Jun 2010 23:31:02 +0200
Message-ID: <vpqsk4vrizt.fsf@bauges.imag.fr>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-4-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-5-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-6-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-7-git-send-email-diane.gasselin@ensimag.imag.fr>
	<vpqtypcx7a9.fsf@bauges.imag.fr>
	<AANLkTinw5gC9jCqhEeufwVnK0rZ-bJdx9sgpwEPoBEAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 09 23:31:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMSre-0005So-3u
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 23:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981Ab0FIVbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 17:31:05 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52200 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754736Ab0FIVbE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 17:31:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o59LNGp7019775
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 9 Jun 2010 23:23:16 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OMSrW-0002z9-Dl; Wed, 09 Jun 2010 23:31:02 +0200
In-Reply-To: <AANLkTinw5gC9jCqhEeufwVnK0rZ-bJdx9sgpwEPoBEAw@mail.gmail.com> (Diane Gasselin's message of "Wed\, 9 Jun 2010 23\:10\:33 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 09 Jun 2010 23:23:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o59LNGp7019775
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148823>

Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:

> It seems a good idea, I will introduce that in my next version.
> Should the message directly advice that files should not be exchanged
> outside of Git and propose a solution for resolving the situation?

I don't think the tool should try to guess the origin of the problem,
but give a solution (like "please move or remove the files before you
can merge").

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
