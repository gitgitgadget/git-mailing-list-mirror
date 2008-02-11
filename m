From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC/PATCH] Implement git-cp.
Date: Mon, 11 Feb 2008 11:18:21 +0100
Message-ID: <vpq1w7jzthu.fsf@bauges.imag.fr>
References: <38b2ab8a0802031023y2ed7a5aax6d3c404b08757a4d@mail.gmail.com>
	<vpq63x5swsj.fsf@bauges.imag.fr>
	<m3tzkp6eqz.fsf@localhost.localdomain>
	<20080210011203.GL25954@genesis.frugalware.org>
	<alpine.LSU.1.00.0802100125510.11591@racer.site>
	<7vzlu9uu7c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 11:21:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOVmu-0005Tx-1f
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 11:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbYBKKUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 05:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbYBKKUs
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 05:20:48 -0500
Received: from imag.imag.fr ([129.88.30.1]:39787 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521AbYBKKUr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 05:20:47 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m1BAIMVR007881
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Feb 2008 11:18:22 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JOVjy-0001t5-2P; Mon, 11 Feb 2008 11:18:22 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JOVjx-0008T1-WF; Mon, 11 Feb 2008 11:18:22 +0100
In-Reply-To: <7vzlu9uu7c.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 09 Feb 2008 23\:49\:43 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 11 Feb 2008 11:18:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73505>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> If you touch builtin-mv.c already, why not just move cmd_cp() in there?  
>> It's not like it would be the first cmd_*() function living in the same 
>> file as other cmd_*() functions.
>
> Why do we even want "git-cp", especially when git-mv and git-rm
> are already pretty much redundant commands?
>
> Especially, why do we even encourage copy-and-paste?

I rarely (let's say: never ;-) ) copy-and-paste a C source file, but
there are tons of cases wher I start a file by copying another
(typically, a 10 lines long Makefile containing macro definitions and
an "include" statement, to be copied in each subdirectory and adapted
to reflect the source file name, or starting a .txt file based on a
skeleton).

I can very well live without a "git cp" command, but I'd use it if it
was available.

-- 
Matthieu
