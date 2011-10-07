From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] show git tag output in pager
Date: Fri, 07 Oct 2011 16:48:35 +0200
Message-ID: <vpqsjn4dfi4.fsf@bauges.imag.fr>
References: <20110927134235.GA27478@zelva.suse.cz>
	<vpqehz2cbk4.fsf@bauges.imag.fr>
	<20110929093749.GB27152@zelva.suse.cz>
	<20110930104241.GB24507@sigill.intra.peff.net>
	<vpqwrcmw7ve.fsf@bauges.imag.fr>
	<20111007144438.GA30318@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michal Vyskocil <mvyskocil@suse.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 07 16:49:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCBjx-0007UJ-0T
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 16:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965441Ab1JGOt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 10:49:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41776 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965405Ab1JGOt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 10:49:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p97Ek5NE001453
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Oct 2011 16:46:05 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RCBj1-00071o-Bl; Fri, 07 Oct 2011 16:48:35 +0200
In-Reply-To: <20111007144438.GA30318@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 7 Oct 2011 10:44:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 07 Oct 2011 16:46:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p97Ek5NE001453
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1318603567.13285@NFQ3wm2C1YMQ8D2hKy4THg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183078>

Jeff King <peff@peff.net> writes:

> On Mon, Oct 03, 2011 at 02:57:09PM +0200, Matthieu Moy wrote:
>
>> I like the try_subcommand_pager idea. Ideally, there would also be a
>> nice mechanism to set defaults for subcommands, so that "git tag
>> <whatever>" does the right thing without configuration.
>
> That's easy enough. Something like the patch below?

It may have been better with a big centralized array of configurations
like

	static struct cmd_struct commands[] = {
		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
                ...

in git.c, but if we have only a few instances of this, your system is
probably fine. I like it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
