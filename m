From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Do not show progress meter while checking files out.
Date: Fri, 20 Apr 2007 14:46:29 +0200
Message-ID: <vpqabx3nrh6.fsf@bauges.imag.fr>
References: <11770585393395-git-send-email-junkio@cox.net>
	<1177058540390-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 14:47:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HesVy-0006RK-Mi
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 14:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992718AbXDTMqj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 08:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992726AbXDTMqj
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 08:46:39 -0400
Received: from imag.imag.fr ([129.88.30.1]:42621 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992718AbXDTMqi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 08:46:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l3KCkTDf008149
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Apr 2007 14:46:29 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HesVR-0006J0-6R; Fri, 20 Apr 2007 14:46:29 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HesVR-0003Si-3z; Fri, 20 Apr 2007 14:46:29 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <1177058540390-git-send-email-junkio@cox.net> (Junio C. Hamano's message of "Fri\, 20 Apr 2007 01\:42\:19 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 20 Apr 2007 14:46:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45098>

Junio C Hamano <junkio@cox.net> writes:

> Originally I thought it would take too long to check out many
> files and to prevent people from getting bored, I added progress
> meter.  But it feels a bit too noisy; let's disable it.

[...]

> -		/* Don't bother doing this for very small updates */
> -		if (total < 250)
> -			total = 0;

[...]

Andy Parkins <andyparkins@gmail.com> writes:

> Don't do that.  I like it.

If it's just to make it less noisy, perhaps adjusting the magic value
above would do it.

-- 
Matthieu
