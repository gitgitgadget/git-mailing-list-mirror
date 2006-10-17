From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 15:33:15 +0200
Message-ID: <vpqk62z3w4k.fsf@ecrins.imag.fr>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr>
	<200610171345.32313.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 15:34:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZp5M-0007VH-Ox
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 15:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWJQNeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 09:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWJQNeV
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 09:34:21 -0400
Received: from imag.imag.fr ([129.88.30.1]:60334 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1750923AbWJQNeV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 09:34:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9HDXGrl009612
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Oct 2006 15:33:16 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GZp4F-0000vE-Rv; Tue, 17 Oct 2006 15:33:15 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GZp4F-0002P5-Od; Tue, 17 Oct 2006 15:33:15 +0200
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610171345.32313.jnareb@gmail.com> (Jakub Narebski's message of "Tue\, 17 Oct 2006 13\:45\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Tue, 17 Oct 2006 15:33:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29069>

Jakub Narebski <jnareb@gmail.com> writes:

> But git has reverse check: it forbids (unless forced by user) to fetch 
> into branch which has local changes (does not fast-forward).

Same as bzr then I believe. "bzr pull" will suggest you to use "merge"
in this situation, unless you say "pull --overwrite".

>> The more fundamental thing I suppose is that it allows people to work
>> in a centralized way (checkout/commit/update/...), and Bazaar was
>> designed to allow several different workflows, including the
>> centralized one.
>
> Git is designed for distributed workflows, not for centralized one.
> All repositories are created equal :-)

Note that "bound branches" and "other branches" in bzr are not so
different. The "master" (the one you make a checkout of) doesn't have
to know it has checkouts, and the "checkout" just has one file
pointing to the "master", and you can switch from one flow to the
other with "bzr bind/unbind".

So, in Bazaar, all repositories are /almost/ created equal ;-).

-- 
Matthieu
