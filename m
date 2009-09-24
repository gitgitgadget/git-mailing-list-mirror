From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How does gitosis know who the key belongs to
Date: Thu, 24 Sep 2009 21:26:43 +0200
Message-ID: <vpqskeckuto.fsf@bauges.imag.fr>
References: <26ae428a0909240751k3a799750h121935a79439b389@mail.gmail.com>
	<20090924172610.GA31309@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Howard Miller <howard@e-learndesign.co.uk>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Sep 24 21:27:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqtyG-0000Vz-JR
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 21:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbZIXT0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 15:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbZIXT0w
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 15:26:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51979 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754105AbZIXT0t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 15:26:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8OJNVPa010408
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 24 Sep 2009 21:23:32 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mqtxj-0005rM-Tl; Thu, 24 Sep 2009 21:26:43 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mqtxj-0006Sw-SL; Thu, 24 Sep 2009 21:26:43 +0200
In-Reply-To: <20090924172610.GA31309@book.hvoigt.net> (Heiko Voigt's message of "Thu\, 24 Sep 2009 19\:26\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 24 Sep 2009 21:23:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8OJNVPa010408
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1254425012.75877@ATC6hX/Xw8qm5oG5peKcBg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129056>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Thu, Sep 24, 2009 at 03:51:44PM +0100, Howard Miller wrote:
>> Gitosis obviously uses keypairs but the config file addresses the user
>> by name/host. How does gitosis connect the two together? Is it any
>> more complicated than the user detail at the end of the public key?

The user@host at the end of the public key is mostly a comment. No
serious software would use it for authentication, since you can freely
edit it without changing the rest of the key.

> Not much different. It uses the command feature of the authorized_keys
> file of ssh to limit access to the 'gitosis-serve' command which is
> given the username from the gitosis.conf as argument.

... the username -> key association being done in gitosis's
configuration itself (the key held in keydir/foobar is the one of user
foobar).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
