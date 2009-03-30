From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 1/2] send-email: refactor and ensure prompting doesn't  loop forever
Date: Mon, 30 Mar 2009 16:40:10 +0200
Message-ID: <vpqwsa7gjlh.fsf@bauges.imag.fr>
References: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com>
	<vpqd4bzjlk1.fsf@bauges.imag.fr>
	<76718490903300717x5cc5e33ax1cf91471efd242bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 16:47:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoIk3-0006Wi-Sg
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 16:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbZC3OoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 10:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbZC3OoB
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 10:44:01 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:55674 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467AbZC3OoB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 10:44:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n2UEeELI007108;
	Mon, 30 Mar 2009 16:40:14 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LoIeo-00067V-4l; Mon, 30 Mar 2009 16:40:10 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LoIeo-00070G-2N; Mon, 30 Mar 2009 16:40:10 +0200
In-Reply-To: <76718490903300717x5cc5e33ax1cf91471efd242bd@mail.gmail.com> (Jay Soffian's message of "Mon\, 30 Mar 2009 10\:17\:43 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 30 Mar 2009 16:40:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115160>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Mon, Mar 30, 2009 at 7:29 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>
> perl send-email ... 2>/dev/null :-)
>
> Seriously though, I am unable to reproduce the messages you are
> getting from Term::ReadLine, and I tried really hard.

Anyway, as I said, the warnings do not harm. They just appear messy in
my log files, but it's really a matter of polishing the UI.

> What does:
>
> $ perl -e 'use Term::ReadLine; print "$Term::ReadLine::VERSION\n"'

$ perl -e 'use Term::ReadLine; print "$Term::ReadLine::VERSION\n"'
1.02
$

That's Debian oldstable (etch), so perhaps newer versions fixed the
problem.

Thanks again,

-- 
Matthieu
