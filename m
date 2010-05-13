From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Advice on choosing git
Date: Thu, 13 May 2010 13:48:06 +0200
Message-ID: <vpqr5lgggzt.fsf@bauges.imag.fr>
References: <4BEA4B46.6010009@smartmediacorp.com>
	<201005130018.o4D0I7iI079145@kzsu.stanford.edu>
	<AANLkTikc6_jZoMzF1VhfJBSk1DRHCNNP3puPT0Z2Usk5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joe Brenner <doom@kzsu.stanford.edu>,
	Noah Silverman <noah@smartmediacorp.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 13:48:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCWu0-0006bL-Ae
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 13:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758399Ab0EMLsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 07:48:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53415 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758176Ab0EMLsS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 07:48:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o4DBfi9d003101
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 13 May 2010 13:41:44 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OCWta-0002Zz-Oh; Thu, 13 May 2010 13:48:06 +0200
In-Reply-To: <AANLkTikc6_jZoMzF1VhfJBSk1DRHCNNP3puPT0Z2Usk5@mail.gmail.com> (Avery Pennarun's message of "Wed\, 12 May 2010 20\:31\:32 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 13 May 2010 13:41:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o4DBfi9d003101
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1274355711.73641@flkArr3FvcFJnLEbPpGW6w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146992>

Avery Pennarun <apenwarr@gmail.com> writes:

> You can only fill up your disks if
> you download tons of movies and/or create tons of VMs.

Right, but if you do so, managing your movies and VMs with Git would
be really bad idea. Typically, you don't want your backup system to
try to diff each movie with each other to save space.

> Just make sure your backup/syncing software has an expiration
> algorithm so you don't end up storing *all* the historical copies.

And this is where Git will be really bad. Removing past revisions
means editing history, and while Git knows how to edit history,
syncing after doing that will be terrible.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
