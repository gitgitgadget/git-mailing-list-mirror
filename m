From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Expand ~ and ~user in core.excludesfile, commit.template
Date: Wed, 18 Nov 2009 08:24:31 +0100
Message-ID: <vpq7hto70sw.fsf@bauges.imag.fr>
References: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
	<20091117073426.GB4007@coredump.intra.peff.net>
	<20091117074930.GB11636@glandium.org> <m2lji43l20.fsf@igel.home>
	<7v8we4er0t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Mike Hommey <mh@glandium.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Karl Chen <quarl@quarl.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 08:29:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAez5-0003Zo-2P
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 08:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbZKRH3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 02:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbZKRH3e
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 02:29:34 -0500
Received: from imag.imag.fr ([129.88.30.1]:64043 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbZKRH3e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 02:29:34 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nAI7OY7p017496
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Nov 2009 08:24:34 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NAeu0-00039k-8o; Wed, 18 Nov 2009 08:24:32 +0100
In-Reply-To: <7v8we4er0t.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 17 Nov 2009 14\:16\:18 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 18 Nov 2009 08:24:37 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133150>

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> Mike Hommey <mh@glandium.org> writes:
>>
>> "~" should just expand to the value of $HOME, like in the shell,
>> independent of the real home directory of the real or effective user.

Right, I'll resend in a minute.

Junio C Hamano <gitster@pobox.com> writes:

> How should this interact with installations that run gitosis/gitlite that
> use shared account, giving user identity via the ssh key?

I guess there's some kind of rhetorical question behind that I missed,
but if a gitosis-like installation uses the user git, and the user foo
connects to it identifier by its SSH key, I don't see what you could
do other than expanding ~ to the homedir of git, which is $HOME at the
time your run git on the server.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
