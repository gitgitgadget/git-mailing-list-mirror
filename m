From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Document how to tell git to not launch a pager
Date: Thu, 19 Jul 2007 21:34:35 +0200
Message-ID: <vpq7iowxk50.fsf@bauges.imag.fr>
References: <20070719104351.GA17182@midwinter.com>
	<20070719110224.GA4293@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0707191211010.14781@racer.site>
	<Pine.LNX.4.64.0707191235490.32611@reaper.quantumfyre.co.uk>
	<86ir8gbo0a.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0707191128040.27353@woody.linux-foundation.org>
	<dbfc82860707191151w3e9571fcu60d113cba6c2f6dd@mail.gmail.com>
	<alpine.LFD.0.999.0707191155100.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nikolai Weibull <now@bitwi.se>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 21:35:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBbmh-0001R0-SD
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 21:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939137AbXGSTfR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 15:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938941AbXGSTfQ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 15:35:16 -0400
Received: from imag.imag.fr ([129.88.30.1]:44371 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934381AbXGSTfN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 15:35:13 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l6JJYZ3M029466
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 19 Jul 2007 21:34:35 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IBblj-0005M1-H6; Thu, 19 Jul 2007 21:34:35 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IBblj-0006P8-Eg; Thu, 19 Jul 2007 21:34:35 +0200
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>, Nikolai Weibull <now@bitwi.se>,  David Kastrup <dak@gnu.org>, git@vger.kernel.org
In-Reply-To: <alpine.LFD.0.999.0707191155100.27353@woody.linux-foundation.org> (Linus Torvalds's message of "Thu\, 19 Jul 2007 12\:14\:30 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 19 Jul 2007 21:34:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53027>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> But the *combination* of all three is just evil and stupid. And the choice 
> of ctrl-A as the default command sequence (can you even override it? Don't 
> know, don't care) is just insanity.

Yes, you can. For example, I have

  escape ^oo

in my ~/.screenrc, and the control command is C-o, and I can do a real
C-o by doing C-o o.

That said, I rarely use screen, just to launch a long command at work
and get the result from home later.

-- 
Matthieu
