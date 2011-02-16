From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 10:05:31 +0100
Message-ID: <vpqsjvos61w.fsf@bauges.imag.fr>
References: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
	<20110216023645.GA7085@sigill.intra.peff.net>
	<20110216032047.GA2858@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 10:05:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpdKY-0006br-6X
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 10:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758776Ab1BPJFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 04:05:43 -0500
Received: from mx2.imag.fr ([129.88.30.17]:50157 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752579Ab1BPJFk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 04:05:40 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p1G95VMh031417
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Feb 2011 10:05:31 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PpdKF-0003xJ-Me; Wed, 16 Feb 2011 10:05:31 +0100
In-Reply-To: <20110216032047.GA2858@elie> (Jonathan Nieder's message of "Tue\, 15 Feb 2011 21\:20\:47 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 16 Feb 2011 10:05:31 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p1G95VMh031417
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1298451931.36128@vGCnI2x2Yy/rcpTV8Umb/Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166934>

Jonathan Nieder <jrnieder@gmail.com> writes:

> If I remember the discussion[1] correctly, by requiring a separate
> add -u step (or commit -f -a) if the "I don't trust my fingers"
> configuration is enabled.
>
> [1] http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/698001/focus=145662

You may want to look at what eg (easy git) does too:

http://people.gnome.org/~newren/eg/documentation/commit.html

essentially, it considers commiting with dirty index the uncommon
case, and requires an extra --staged flag to allow it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
