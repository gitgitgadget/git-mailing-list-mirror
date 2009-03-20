From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH v3] Introduce BEL<branch> as shortcut to the tracked  branch
Date: Fri, 20 Mar 2009 14:05:37 +0100
Message-ID: <vpqy6v0ny3i.fsf@bauges.imag.fr>
References: <200903181448.50706.agruen@suse.de>
	<alpine.DEB.1.00.0903201053280.10279@pacific.mpi-cbg.de>
	<adf1fd3d0903200533s2be08ee7t58a22180b1c886c0@mail.gmail.com>
	<200903201345.23864.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 14:11:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkeVf-0006g9-H2
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 14:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756425AbZCTNKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 09:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756614AbZCTNJ7
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 09:09:59 -0400
Received: from imag.imag.fr ([129.88.30.1]:42055 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756482AbZCTNJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 09:09:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n2KD5qnC022677
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Mar 2009 14:05:52 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LkePp-0004tL-IK; Fri, 20 Mar 2009 14:05:37 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LkePp-0005vy-Fq; Fri, 20 Mar 2009 14:05:37 +0100
In-Reply-To: <200903201345.23864.agruen@suse.de> (Andreas Gruenbacher's message of "Fri\, 20 Mar 2009 13\:45\:23 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 20 Mar 2009 14:05:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113954>

Andreas Gruenbacher <agruen@suse.de> writes:

> For me this defeats the purpose; I can just as well type origin/branch (or 
> whatever it is) instead of branch^{origin}.  I'm really looking for something 
> very short like % or %branch.

I was thinking of ../branch (so, replace % with ../ in your patch,
roughly). The cool thing is that my fingers are used to ../ already.
The bad things are 1) not sure the "analogy" with .. in filesystem is
good, and 2) this interacts badly with ref..branch. ref..%branch was
cool, ref..../branch is less cool.

Or is //branch an idea?

My 2 cents,

-- 
Matthieu
