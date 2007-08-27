From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: repo.or.cz wishes?
Date: Mon, 27 Aug 2007 21:09:42 +0200
Message-ID: <vpqmywclrpl.fsf@bauges.imag.fr>
References: <20070826235944.GM1219@pasky.or.cz>
	<20070827001634.GB1976MdfPADPa@greensroom.kotnet.org>
	<20070827004153.GN1219@pasky.or.cz>
	<alpine.LFD.0.999.0708271114470.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, skimo@liacs.nl, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 21:16:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPjzI-0002Vw-Rz
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 21:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324AbXH0TKc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 15:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754219AbXH0TKc
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 15:10:32 -0400
Received: from imag.imag.fr ([129.88.30.1]:64898 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111AbXH0TKb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 15:10:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7RJ9ggP029121
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 27 Aug 2007 21:09:43 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IPjy2-0004P2-N0; Mon, 27 Aug 2007 21:09:42 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IPjy2-0007Wg-J5; Mon, 27 Aug 2007 21:09:42 +0200
In-Reply-To: <alpine.LFD.0.999.0708271114470.25853@woody.linux-foundation.org> (Linus Torvalds's message of "Mon\, 27 Aug 2007 11\:23\:52 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 27 Aug 2007 21:09:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56869>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> It's as stupid as it would be to require people to say
>
> 	scp cp+ssh://host/filename .
>
> and nobody sane would *ever* advocate something that stupid. It's not how 
> it's done.

You could find a better example.

scp doesn't accept URL syntax at all. So, no, it doesn't know about
cp+ssh://, but doesn't know ssh:// either.

-- 
Matthieu
