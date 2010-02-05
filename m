From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: reverting vs resetting
Date: Fri, 05 Feb 2010 09:41:21 +0100
Message-ID: <vpqwryskrbi.fsf@bauges.imag.fr>
References: <20100205091223.6b4cffb1@pbmiha.malagasy.com>
	<32541b131002042248x5461d904r276b184533ac492a@mail.gmail.com>
	<7v1vh0jh0p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Mihamina Rakotomandimby <mihamina@gulfsat.mg>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:07:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL4L-0003Bj-J0
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199Ab0BEIpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 03:45:19 -0500
Received: from imag.imag.fr ([129.88.30.1]:60317 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754442Ab0BEIpS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 03:45:18 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o158fMSj003871
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 5 Feb 2010 09:41:22 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NdJkg-0007Bk-4v; Fri, 05 Feb 2010 09:41:22 +0100
In-Reply-To: <7v1vh0jh0p.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 04 Feb 2010 23\:09\:10 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 05 Feb 2010 09:41:22 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139039>

Junio C Hamano <gitster@pobox.com> writes:

> 	git branch andy_failed_experiment
>         git reset --hard HEAD~50
> 	;# and perhaps revert Bob's change here as well

So would I, and to complement Junio's answer: keeping a failure
followed by a repair means this experiment will appear more or less
forever in the output of "git log", "git blame", will break "git
bisect" on that part of history, and so on. Putting it on a separate
branch avoids this, and keeps it in a safe place to show newcommers:
"see, here's what you should not do" ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
