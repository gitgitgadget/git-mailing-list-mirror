From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 18:05:32 +0100
Message-ID: <vpqejemtbc3.fsf@bauges.imag.fr>
References: <1195477504.8093.15.camel@localhost>
	<8c5c35580711190845s71a4880ek4ab28170d277e0e6@mail.gmail.com>
	<E983072E-E9FD-499E-A418-B630A275C4F3@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>,
	"Jonas Juselius" <jonas.juselius@chem.uit.no>, git@vger.kernel.org
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Nov 19 18:14:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuACB-0003AL-Fp
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 18:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbXKSRNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 12:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753607AbXKSRNq
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 12:13:46 -0500
Received: from imag.imag.fr ([129.88.30.1]:54116 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753576AbXKSRNp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 12:13:45 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lAJH5XUJ010276
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 19 Nov 2007 18:05:33 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IuA3x-00055y-25; Mon, 19 Nov 2007 18:05:33 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IuA3w-0006Ua-VH; Mon, 19 Nov 2007 18:05:32 +0100
In-Reply-To: <E983072E-E9FD-499E-A418-B630A275C4F3@lrde.epita.fr> (Benoit Sigoure's message of "Mon\, 19 Nov 2007 17\:57\:50 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 19 Nov 2007 18:05:33 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65473>

Benoit Sigoure <tsuna@lrde.epita.fr> writes:

>  git reset --hard HEAD~42 and then git reset --hard A.

And if you don't "remember" A, the reflog is here for you.

$ git reflog show HEAD
$ git reset --hard HEAD@{42} # not "the 42th ancestor"
                             # but "where HEAD was 42 moves ago".

By default, the reflog will expire after IIRC, 3 months, and git-prune
will not prune the objects while they are reachable.

So, it's even safer than you say ;-).

-- 
Matthieu
