From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Memory overrun in http-push.c
Date: Fri, 02 Mar 2007 16:30:11 +0100
Message-ID: <vpqd53racjg.fsf@olympe.imag.fr>
References: <20070228151516.GC57456@codelabs.ru>
	<20070301120042.GD63606@codelabs.ru> <es9cnt$egh$1@sea.gmane.org>
	<200703021523.37010.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 16:30:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN9iU-0004wz-Us
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 16:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992518AbXCBPaY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 10:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992521AbXCBPaY
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 10:30:24 -0500
Received: from imag.imag.fr ([129.88.30.1]:42858 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992518AbXCBPaX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 10:30:23 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l22FUBUJ011847
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 2 Mar 2007 16:30:11 +0100 (CET)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HN9hz-0000Bc-MC
	for git@vger.kernel.org; Fri, 02 Mar 2007 16:30:11 +0100
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HN9hz-00005y-Jc
	for git@vger.kernel.org; Fri, 02 Mar 2007 16:30:11 +0100
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <200703021523.37010.andyparkins@gmail.com> (Andy Parkins's message of "Fri\, 2 Mar 2007 15\:23\:35 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 02 Mar 2007 16:30:11 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41218>

Andy Parkins <andyparkins@gmail.com> writes:

> On Friday 2007 March 02 14:38, Jakub Narebski wrote:
>
>> First, keyword expansion on checkout (CVS-like) is an abomination;
>> the proper way is to do it on _build_ time, like git and Linux kernel
>
> What about my SVG example?  There is no build time, the file is the file.

Same with manually written HTML, or even just plain text files, or ...

A typical other example is when you're working with people having some
kind of alergy to revision control systems. Then, you have to send the
source, and they send you back the modified source. That's very hard
to manage without some kind of timestamp within the file.

However, I have to admit that workflows requiring keyword expansions
still appear dirty to me.

A (dirty too) solution is to have a pre-commit hook that would update
the keywords for each modified file. Then, the keyword is in the
source itself.

-- 
Matthieu
