From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 18:47:14 +0100
Message-ID: <vpq7iknqrtp.fsf@bauges.imag.fr>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<Pine.LNX.4.64.0711121355380.4362@racer.site>
	<200711121719.54146.wielemak@science.uva.nl>
	<Pine.LNX.4.64.0711121624330.4362@racer.site>
	<vpq3avbv2ju.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121715090.4362@racer.site>
	<18232.35893.243300.179076@lisa.zopyra.com>
	<Pine.LNX.4.64.0711121727130.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 19:18:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irdrn-0001nb-PE
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 19:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbXKLSST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 13:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754131AbXKLSSS
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 13:18:18 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:35559 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753759AbXKLSSR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 13:18:17 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id lACHlE0d001586;
	Mon, 12 Nov 2007 18:47:14 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IrdNS-0003MH-Dp; Mon, 12 Nov 2007 18:47:14 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IrdNS-0006Wy-BO; Mon, 12 Nov 2007 18:47:14 +0100
In-Reply-To: <Pine.LNX.4.64.0711121727130.4362@racer.site> (Johannes Schindelin's message of "Mon\, 12 Nov 2007 17\:30\:10 +0000 \(GMT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 12 Nov 2007 18:47:20 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64683>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I don't see what is soooo hard with using git-remote in the repo you are 
> pushing from.  It's just a "git remote add origin <url>", and you can even 
> use this to push right afterwards: "git push --all origin".

If "git remote add" is so easy, why does "git clone" set up the remote
for you?

And don't tell me that you didn't notice that "git clone" does more
than your proposed "git remote add origin ...".

> Besides, if you really want to work together, chances are that you do 
> _not_ want to start with <n> independent initial commits.

So, what?

> So you need to populate the repository before starting _anyway_.

Last time I checked, the thread was talking about bare repository.
Perhaps you have a magic formula to populate a bare repository without
pushing to it from another repo, but I don't.

-- 
Matthieu
