From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Make --color available to git-status
Date: Sun, 06 May 2007 15:58:13 +0200
Message-ID: <vpq64762gwa.fsf@bauges.imag.fr>
References: <11783866694076-git-send-email-Matthieu.Moy@imag.fr>
	<Pine.LNX.4.64.0705051956200.4015@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 15:58:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkhFv-0000js-Le
	for gcvg-git@gmane.org; Sun, 06 May 2007 15:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbXEFN62 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 09:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753398AbXEFN62
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 09:58:28 -0400
Received: from imag.imag.fr ([129.88.30.1]:43733 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbXEFN61 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 09:58:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l46DwD2Z029778
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2007 15:58:13 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HkhFd-0005xx-5y; Sun, 06 May 2007 15:58:13 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HkhFd-0002x0-2a; Sun, 06 May 2007 15:58:13 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0705051956200.4015@racer.site> (Johannes Schindelin's message of "Sat\, 5 May 2007 19\:58\:45 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 06 May 2007 15:58:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46336>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sat, 5 May 2007, Matthieu Moy wrote:
>
>> Git has a nice colored output for status, using
>> 
>> $ git runstatus --color
>> 
>> However, this --color is not made available to git-status itself.
>
> AFAIR there have been attempts to enable this by default, when git-status 
> is run interactively (i.e. its output is not piped). However, this proved 
> to be remarkably complex, given that the output of runstatus _is_ piped.

It would definitely be cool to have it enabled by default, but just
having the option (which means in particular that users can use it in
an alias) should be the minimum.

I don't have enough experience with git hacking to do all the way you
suggest, so I'm starting with easy things ;-).

-- 
Matthieu
