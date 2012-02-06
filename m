From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Specifying revisions in the future
Date: Mon, 06 Feb 2012 12:43:06 +0100
Message-ID: <vpq62fk89x1.fsf@bauges.imag.fr>
References: <jgjkk0$qrg$1@dough.gmane.org>
	<m3ehu9kknw.fsf@localhost.localdomain> <m2wr81vsdv.fsf@igel.home>
	<201202052324.59941.jnareb@gmail.com>
	<178AA8FDB02246D9AA9416C0D54E51A8@PhilipOakley>
	<m2obtcx4i2.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Philip Oakley" <philipoakley@iee.org>,
	"Jakub Narebski" <jnareb@gmail.com>, <jpaugh@gmx.us>,
	<git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Feb 06 12:43:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuMyi-0006GD-UH
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 12:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179Ab2BFLnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 06:43:20 -0500
Received: from mx1.imag.fr ([129.88.30.5]:44870 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753114Ab2BFLnU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 06:43:20 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q16BeUrL021497
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 6 Feb 2012 12:40:30 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RuMyQ-00072C-FG; Mon, 06 Feb 2012 12:43:06 +0100
In-Reply-To: <m2obtcx4i2.fsf@igel.home> (Andreas Schwab's message of "Mon, 06
	Feb 2012 00:08:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 06 Feb 2012 12:40:31 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q16BeUrL021497
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1329133231.62509@VTSXj1eHrWeE5kXZgq8yDw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190067>

Andreas Schwab <schwab@linux-m68k.org> writes:

> The rule should be to follow the leftmost parent as far as possible.

But then, if --first-parent doesn't reach the commit you want, there may
be several paths not following --first-parent that reach it. And you'll
have to invent some more rules to order them.

Sure, that's not impossible, but is the complexity really worth it?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
