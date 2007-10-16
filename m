From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: should git command and git-command be equivalent?
Date: Tue, 16 Oct 2007 09:48:28 +0200
Message-ID: <vpqprzfsdo3.fsf@bauges.imag.fr>
References: <20071016032240.AD2FD7E80@mail.kooxoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "franky" <yinping@kooxoo.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 09:50:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhhBT-0007Rq-C6
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 09:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764807AbXJPHth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 03:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763386AbXJPHth
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 03:49:37 -0400
Received: from imag.imag.fr ([129.88.30.1]:55340 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764308AbXJPHtg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 03:49:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l9G7mSX3000222
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 16 Oct 2007 09:48:29 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IhhAC-0007Db-Ec; Tue, 16 Oct 2007 09:48:28 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IhhAC-0006IV-Al; Tue, 16 Oct 2007 09:48:28 +0200
In-Reply-To: <20071016032240.AD2FD7E80@mail.kooxoo.com> (franky's message of "Tue\, 16 Oct 2007 11\:22\:39 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 16 Oct 2007 09:48:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61107>

"franky" <yinping@kooxoo.com> writes:

> 	I use git-init frequently and it confuses me for a long time that I
> can't init a bare repository. 
> 	I just found I can do that by "git -bare init". However, I get used
> to "git-init" and I always tried "git-init -bare" (of course failed)
> 	And I thought git-init and "git init" were always the same as most
> newbies of git.

AFAIK, git-init and "git init" are equivalent, but as you noticed
already, the advantage of "git init" is that you can pass options to
the git command, not only to the "init" subcommand.

Also, you can use aliases (for example, I type "git st" to do "git
status") with "git whatever", but not with "git-whatever" (unless you
define the alias in your shell).

The git-whatever syntax is more or less deprecated, although I guess
it will stay forever at least for compatibility.

-- 
Matthieu
