From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 02 Aug 2007 11:57:01 +0200
Message-ID: <vpqbqdq45ua.fsf@bauges.imag.fr>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021050500.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 11:57:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGXQt-0000rU-HQ
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 11:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbXHBJ5Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 05:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbXHBJ5Y
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 05:57:24 -0400
Received: from imag.imag.fr ([129.88.30.1]:53419 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293AbXHBJ5X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 05:57:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l729v1ME019114
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 2 Aug 2007 11:57:01 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IGXQT-0006e1-9B; Thu, 02 Aug 2007 11:57:01 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IGXQT-000284-6h; Thu, 02 Aug 2007 11:57:01 +0200
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>,  git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0708021050500.14781@racer.site> (Johannes Schindelin's message of "Thu\, 2 Aug 2007 10\:51\:17 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 02 Aug 2007 11:57:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54533>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 2 Aug 2007, Matthieu Moy wrote:
>
>> > If the feature still makes sense in the modern world is a
>> > different story, but I do find it useful.
>> 
>> I understand that it can be usefull, but I really don't like having it
>> by default (is there a way to deactivate it BTW?).
>
> Yes.  Just call "git status" and be done with it.

That's not what I mean (my original message mentionned that already
BTW). By "deactivate", I mean "make git-diff never show empty diffs".
I don't want to run two commands where I need only one.

-- 
Matthieu
