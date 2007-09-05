From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 10:39:52 +0200
Message-ID: <vpqtzq91p5z.fsf@bauges.imag.fr>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<7vsl5tk1r8.fsf@gitster.siamese.dyndns.org>
	<200709051013.39910.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 05 10:41:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISqSJ-0003Ui-MK
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 10:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957AbXIEIlj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 04:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755872AbXIEIlj
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 04:41:39 -0400
Received: from imag.imag.fr ([129.88.30.1]:40722 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755947AbXIEIli (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 04:41:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l858dqg9025304
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 5 Sep 2007 10:39:53 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1ISqQS-0004z4-78; Wed, 05 Sep 2007 10:39:52 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1ISqQS-00083q-34; Wed, 05 Sep 2007 10:39:52 +0200
In-Reply-To: <200709051013.39910.johan@herland.net> (Johan Herland's message of "Wed\, 5 Sep 2007 10\:13\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 05 Sep 2007 10:39:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57687>

Johan Herland <johan@herland.net> writes:

> When git-fetch and git-commit has done its job and is about to exit, it checks 
> the number of loose object, and if too high tells the user something 
> like "There are too many loose objects in the repo, do you want me to repack? 
> (y/N)". If the user answers "n" or simply <Enter>,

I don't like commands to be interactive if they don't _need_ to be so.
It kills scripting, it makes it hard for a front-end (git gui or so)
to use the command, ...

-- 
Matthieu
