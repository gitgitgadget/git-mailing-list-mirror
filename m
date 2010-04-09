From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Fri, 09 Apr 2010 10:13:53 +0200
Message-ID: <vpqr5mp6o1q.fsf@bauges.imag.fr>
References: <loom.20100406T161552-321@post.gmane.org>
	<alpine.LFD.2.00.1004061709360.7232@xanadu.home>
	<4BBC1ED3.6020008@gmail.com>
	<alpine.LFD.2.00.1004070842580.7232@xanadu.home>
	<4BBECE44.4040608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vitaly Berov <vitaly.berov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 10:17:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O09PH-0000Q4-UJ
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 10:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432Ab0DIIRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 04:17:33 -0400
Received: from imag.imag.fr ([129.88.30.1]:40627 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889Ab0DIIRa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 04:17:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o398Dsfu012032
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 9 Apr 2010 10:13:54 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O09Le-0000aT-4p; Fri, 09 Apr 2010 10:13:54 +0200
In-Reply-To: <4BBECE44.4040608@gmail.com> (Vitaly Berov's message of "Fri\, 09 Apr 2010 10\:50\:44 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 09 Apr 2010 10:13:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144417>

Vitaly Berov <vitaly.berov@gmail.com> writes:

> Objects amount: 3997548.
> Size of the repository: ~57Gb.
[...]
> By the way, we have a large amount of binary files in our rep.

This is clearly not the kind of repositories Git is good at. I
encourage you to continue this discussion, and try to find a way to
get it working, but the standard approach (probably a "my 2 cents"
kind of advices, but ...) would be:

* Split your repo into smaller ones (submodules ...)

* Avoid versionning binary files

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
