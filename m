From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: just fetching HEAD of repository
Date: Mon, 21 May 2007 11:08:58 +0200
Message-ID: <vpqhcq6fsr9.fsf@bauges.imag.fr>
References: <566574ef0705210201wc5c0adbmaa22d197b16bf72d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stian Haklev" <shaklev@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 21 11:09:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq3tB-00080Y-66
	for gcvg-git@gmane.org; Mon, 21 May 2007 11:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459AbXEUJJF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 05:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755721AbXEUJJF
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 05:09:05 -0400
Received: from imag.imag.fr ([129.88.30.1]:38547 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755459AbXEUJJE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 05:09:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4L98wCI003616
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 21 May 2007 11:08:59 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hq3sw-0000vI-Pz; Mon, 21 May 2007 11:08:58 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Hq3sw-0005b6-Np; Mon, 21 May 2007 11:08:58 +0200
Mail-Followup-To: "Stian Haklev" <shaklev@gmail.com>, git@vger.kernel.org
In-Reply-To: <566574ef0705210201wc5c0adbmaa22d197b16bf72d@mail.gmail.com> (Stian Haklev's message of "Mon\, 21 May 2007 16\:01\:00 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 21 May 2007 11:08:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47998>

"Stian Haklev" <shaklev@gmail.com> writes:

> After checking all the docs, I am still wondering if there is a way to
> get only the last commit from a given git repository. Sometimes I
> really just want the latest code so I can compile it - and let's say
> they are not running gitweb, or it is not convenient to go to gitweb
> and ask for a tar package to be made? This is especially relevant in
> countries with slow internet connection - here in Indonesia it takes
> me an hour to clone the git repository for example, never mind let's
> say the Linux kernel.

You'll probably pay the price for not downloading the full history
later, but yes, what you're looking for is called "shallow clone", and
it's possible with the --depth option of git-clone (I personnally
never tried it, though).

Side question: once you have a shallow clone, is it possible to
"unshallow" it, that is, fetch the missing revisions?

-- 
Matthieu
