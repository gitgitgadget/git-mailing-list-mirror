From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Thu, 01 Sep 2011 21:35:51 +0200
Message-ID: <vpqippcm4x4.fsf@bauges.imag.fr>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org>
	<4E5FDAFE.6050004@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 01 21:36:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzD3Z-00068I-OE
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 21:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757808Ab1IATgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 15:36:04 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57726 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757765Ab1IATgC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 15:36:02 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p81JZ7S7020999
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 1 Sep 2011 21:35:07 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QzD3I-0005Cl-0P; Thu, 01 Sep 2011 21:35:52 +0200
In-Reply-To: <4E5FDAFE.6050004@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 01 Sep 2011 21:20:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 01 Sep 2011 21:35:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p81JZ7S7020999
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315510507.79999@p0KyD0HXbkDVV7fUuG3F3g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180567>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Thinking more about it, we try to encourage a workflow where locally
> history may be rewritten a lot, and distribution points fast-forward
> only. We have defaults and settings to discourage (pushes to checked out
> branches and) non-ff pushes, for example. So I think the above change is
> pretty much in line with that reasoning.

Agreed. It's not only a security thing, it's also about
teaching/encourraging workflows.

By asking users to explicitely say "yes, I know, this branch can be
rewond", we also ask them to think about it before making a mistake.

That said, enabling the check by default may also become painful. I'd
vote for a configuration option, defaulting to the current behavior for
now. Then we can try living with it for a while and see how painful it
is.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
