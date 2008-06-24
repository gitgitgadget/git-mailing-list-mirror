From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-clone works with ssh but not with http/https/git
Date: Tue, 24 Jun 2008 16:05:18 +0200
Message-ID: <vpqzlpbapy9.fsf@bauges.imag.fr>
References: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com>
	<1214306517.6441.10.camel@localhost>
	<ce513bcc0806240445x6d00323g303f218504d2df53@mail.gmail.com>
	<alpine.DEB.1.00.0806241246500.9925@racer>
	<ce513bcc0806240507q58c2a3y5fe8f0e8033353ad@mail.gmail.com>
	<m3abhbkoe2.fsf@localhost.localdomain>
	<ce513bcc0806240642g56ca5450t4edd24fd88ce79c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Matthias Kestenholz" <mk@spinlock.ch>, git@vger.kernel.org
To: "Erez Zilber" <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 16:10:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB9EU-0004Fb-JQ
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 16:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbYFXOJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 10:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753279AbYFXOJ4
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 10:09:56 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:58670 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbYFXOJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 10:09:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m5OE8rfj006063;
	Tue, 24 Jun 2008 16:08:53 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KB994-0002Wf-K4; Tue, 24 Jun 2008 16:05:18 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KB994-0002nO-Hl; Tue, 24 Jun 2008 16:05:18 +0200
In-Reply-To: <ce513bcc0806240642g56ca5450t4edd24fd88ce79c7@mail.gmail.com> (Erez Zilber's message of "Tue\, 24 Jun 2008 16\:42\:14 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 24 Jun 2008 16:08:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86061>

"Erez Zilber" <erezzi.list@gmail.com> writes:

> I guess that the problem is that no proper mapping exists. That's why
> I see the following in /var/log/httpd/error_log:
>
> [Tue Jun 24 16:31:52 2008] [error] [client 172.16.0.7] File does not
> exist: /var/www/html/pub
>
> What do I need to add in /etc/httpd/conf.d/ in order to set the
> mapping to /pub/git instead of /var/www/html/pub ? Is there an example
> that shows how to map?

Try to access the repository from a web browser first. If you don't
have directory listing enabled, opening a file like HEAD should work.

-- 
Matthieu
