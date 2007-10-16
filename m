From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: should git command and git-command be equivalent?
Date: Tue, 16 Oct 2007 10:55:34 +0200
Message-ID: <vpqk5pnmoah.fsf@bauges.imag.fr>
References: <20071016084800.270917E6F@mail.kooxoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "franky" <yinping@kooxoo.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 10:56:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhiES-00019b-KM
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 10:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756466AbXJPI4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 04:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758134AbXJPI4p
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 04:56:45 -0400
Received: from imag.imag.fr ([129.88.30.1]:53947 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756211AbXJPI4o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 04:56:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l9G8tZdp015917
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 16 Oct 2007 10:55:35 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IhiD8-0001OS-F8; Tue, 16 Oct 2007 10:55:34 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IhiD8-0006Ti-Co; Tue, 16 Oct 2007 10:55:34 +0200
In-Reply-To: <20071016084800.270917E6F@mail.kooxoo.com> (franky's message of "Tue\, 16 Oct 2007 16\:47\:58 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 16 Oct 2007 10:55:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61122>

"franky" <yinping@kooxoo.com> writes:

>> Also, you can use aliases (for example, I type "git st" to do "git
>> status") with "git whatever", but not with "git-whatever" (unless you
>> define the alias in your shell).
> I try "git st", but it complains "git: 'st' is not a git-command".

Sure, I'm talking about aliases, so what I meant is that I had

[alias]
	st = status

in ~/.gitconfig.

> Instead, I use gt-beginning abbreviation for some command frequently used
> such as gtci->git-commit, gtco-->git-checkout, gtst-->git-status,
> gtdi->git-diff, gtinit->git-init
>
> So it will be wonderful if I can use "gtinit --bare"

You can't without defining gtinit as a simple-but-not-totally-trivial
wrapper script.

But you can define an alias to init, to enable you to type

$ git --bare i

(that said, it could be a good idea for "git init" to accept --bare as
an option too).

-- 
Matthieu
