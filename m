From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Detection of relocations within a file
Date: Mon, 30 Aug 2010 18:24:30 +0200
Message-ID: <vpqk4n81329.fsf@bauges.imag.fr>
References: <SNT124-W57C91CBC3A362218ACA23DC4890@phx.gbl>
	<20100830154427.GB3292@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Mazid <timmazid@hotmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Bo Yang <struggleyb.nku@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 18:24:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq7AB-0004nc-BD
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 18:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923Ab0H3QYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 12:24:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41922 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753825Ab0H3QYo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 12:24:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o7UGCgfB031284
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 30 Aug 2010 18:12:42 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oq79r-0006UD-28; Mon, 30 Aug 2010 18:24:31 +0200
In-Reply-To: <20100830154427.GB3292@burratino> (Jonathan Nieder's message of "Mon\, 30 Aug 2010 10\:44\:27 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 30 Aug 2010 18:12:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7UGCgfB031284
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1283789562.65295@DZ4oFb+HyPp+JeykMGLw0w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154827>

Jonathan Nieder <jrnieder@gmail.com> writes:

> 4. I want a simple, easy-to-review patch representing a code movement.
> No one I know of has worked on this, and if you have ideas for it,
> that would be very neat.

5. I have a history with a lot of code movement, someone branched from
me a while ago, modified various pieces of code which moved in the
meantime, and we want to merge.

Unfortunately, I don't think any VCS does a really good job here
either.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
