From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PUB]corrupt repos does not return error with `git fsck`
Date: Wed, 20 May 2015 19:19:16 +0200
Message-ID: <vpq382rkvzf.fsf@anie.imag.fr>
References: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Faheem Mitha <faheem@faheem.info>
X-From: git-owner@vger.kernel.org Wed May 20 19:19:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv7eX-0008Qh-VQ
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 19:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991AbbETRT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 13:19:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35749 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754071AbbETRTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 13:19:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4KHJEBh026751
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 20 May 2015 19:19:14 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4KHJGo0020061;
	Wed, 20 May 2015 19:19:16 +0200
In-Reply-To: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org> (Faheem
	Mitha's message of "Wed, 20 May 2015 21:47:15 +0530 (IST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 20 May 2015 19:19:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4KHJEBh026751
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1432747156.34848@AQWIcUBDlspkLwwORo1UBQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269479>

Faheem Mitha <faheem@faheem.info> writes:

> Hi,
>
> Clone the repos https://github.com/fmitha/SICL.
>
> Then
>
>     git show 280c12ab49223c64c6f914944287a7d049cf4dd0
>
> gives
>
>     fatal: bad object 280c12ab49223c64c6f914944287a7d049cf4dd0

It seems 280c12ab49223c64c6f914944287a7d049cf4dd0 is not an object in
your repository. The good news it: I don't think you have a corrupt
repository. What makes you think you have an object with identifier
280c12ab49223c64c6f914944287a7d049cf4dd0?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
