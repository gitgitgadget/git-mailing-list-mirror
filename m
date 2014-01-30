From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Having Git follow symlinks
Date: Thu, 30 Jan 2014 13:37:17 +0100
Message-ID: <vpqa9ed1w8y.fsf@anie.imag.fr>
References: <alpine.DEB.2.02.1401281443330.17426@perkele.intern.softwolves.pp.se>
	<CALKQrgf5o-ZcaeqXLm3P7RpK2yPcFd_HnG4ewwoEGESduyDSjQ@mail.gmail.com>
	<alpine.DEB.2.00.1401300958320.30100@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Jan 30 13:37:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8qsG-0008JB-88
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 13:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbaA3Mhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 07:37:31 -0500
Received: from mx1.imag.fr ([129.88.30.5]:43766 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752887AbaA3Mh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 07:37:29 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s0UCbHid026185
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 30 Jan 2014 13:37:17 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id s0UCbHjm008803
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 30 Jan 2014 13:37:17 +0100
In-Reply-To: <alpine.DEB.2.00.1401300958320.30100@ds9.cixit.se> (Peter
	Krefting's message of "Thu, 30 Jan 2014 10:01:20 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 30 Jan 2014 13:37:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s0UCbHid026185
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1391690241.08116@+n58zZBljPu93Sco/8yr1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241268>

Peter Krefting <peter@softwolves.pp.se> writes:

> Yeah, but then I have copies of the files, instead of having the files
> themselves under version control, meaning I need to copy them back to
> push changes back, or to merge them. That is undesirable :-/

One option is to have the symlink in the other direction: make /etc/foo
a symlink to $GIT_WORKTREE/foo and version the later.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
