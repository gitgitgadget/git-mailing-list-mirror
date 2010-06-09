From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 1/4] sha1_name: add get_sha1_with_context()
Date: Wed, 09 Jun 2010 09:29:05 +0200
Message-ID: <vpqhblcvf3y.fsf@bauges.imag.fr>
References: <1276004958-13540-1-git-send-email-clement.poulain@ensimag.imag.fr>
	<1276004958-13540-2-git-send-email-clement.poulain@ensimag.imag.fr>
	<vpqiq5t5rvd.fsf@bauges.imag.fr>
	<AANLkTinI_ghLE5U3tQ0JFmvuU8DySLFtdl03sv0uW-Ab@mail.gmail.com>
	<20100609061337.GA14007@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>, git@vger.kernel.org,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 09 09:32:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMFm1-0006mm-VS
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 09:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699Ab0FIHcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 03:32:24 -0400
Received: from imag.imag.fr ([129.88.30.1]:52923 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327Ab0FIHcY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 03:32:24 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o597T6Xu008162
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 9 Jun 2010 09:29:06 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OMFik-0005BW-2G; Wed, 09 Jun 2010 09:29:06 +0200
In-Reply-To: <20100609061337.GA14007@coredump.intra.peff.net> (Jeff King's message of "Wed\, 9 Jun 2010 02\:13\:37 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 09 Jun 2010 09:29:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148750>

Jeff King <peff@peff.net> writes:

> Note the "warnings being treated as errors". Matthieu is compiling with
> -Werror (and presumably -Wall). We strive to be warning-free in git, and
> I think many of the developers compile with "-Wall -Werror".

Right. Try this:

echo 'CFLAGS = -g -Wall -Werror' > config.mak
make

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
