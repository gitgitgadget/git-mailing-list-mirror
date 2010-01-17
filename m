From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 3/3] commit: show interesting ident information in summary
Date: Sun, 17 Jan 2010 12:31:45 +0100
Message-ID: <vpq6371ufvi.fsf@bauges.imag.fr>
References: <20100113173408.GA16652@coredump.intra.peff.net>
	<20100113173951.GC16786@coredump.intra.peff.net>
	<1DDB570B-350A-40A0-B6E4-ADBDF4BE6BD2@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 12:33:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWTNl-00007I-K0
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 12:33:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768Ab0AQLcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 06:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692Ab0AQLcG
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 06:32:06 -0500
Received: from mx2.imag.fr ([129.88.30.17]:54899 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242Ab0AQLcF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 06:32:05 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o0HBVDtK019788
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 17 Jan 2010 12:31:13 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NWTM9-0004o0-O1; Sun, 17 Jan 2010 12:31:45 +0100
In-Reply-To: <1DDB570B-350A-40A0-B6E4-ADBDF4BE6BD2@wincent.com> (Wincent Colaiuta's message of "Wed\, 13 Jan 2010 19\:39\:47 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 17 Jan 2010 12:31:16 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o0HBVDtK019788
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1264332677.46496@lWBAn1DJsOs4Y7PxUQPMBQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137292>

Wincent Colaiuta <win@wincent.com> writes:

> I'll never see this message myself, but I think you could (and perhaps
> should) replace almost all of that with:
>
>   Your name and email address were configured automatically.
>   See "git config help" for information on setting them explicitly
>   or "git commit help" if you wish to amend this commit.

I don't think this is a good idea. The two main cases when this
information will be shown is:

* Newbies, who didn't read the doc, or read it too fast. They'll
  happily ignore your short message.

  For example, I just started a project with 200 students. The doc we
  give them _starts_ with setting user/email in ~/.gitconfig, right
  before we give them the URL of the repository they'll work on. Out
  of that, 22 email adresses were mis-configured. Don't underestimate
  the ability of newbies not to read doc, even when told to do so.

  If the message is long, it'll be disturbing, and they may end up
  reading it.

* Non-newbies, using a machine for the first time. These users will
  see the message once, so it's not really disturbing, and at least I
  would appreciate the message to be flashy, to make sure I don't miss
  it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
