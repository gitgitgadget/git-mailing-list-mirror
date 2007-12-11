From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 20:01:02 +0100
Message-ID: <vpq4pepcaz5.fsf@bauges.imag.fr>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	<alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Berlin <dberlin@dberlin.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:02:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2AMz-0002iM-6s
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbXLKTB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbXLKTBz
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:01:55 -0500
Received: from imag.imag.fr ([129.88.30.1]:50519 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbXLKTBz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 14:01:55 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lBBJ15OV007287
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 20:01:05 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1J2ALm-0006kr-Ti; Tue, 11 Dec 2007 20:01:02 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1J2ALm-0005AY-RK; Tue, 11 Dec 2007 20:01:02 +0100
In-Reply-To: <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org> (Linus Torvalds's message of "Tue\, 11 Dec 2007 10\:40\:36 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 11 Dec 2007 20:01:06 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67904>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The other example is doing things like "git log -p drivers/char", where 
> you don't ask for the log of a single file, but a general file pattern, 
> and get (still atomic!) commits as the result.

I've seen you pointing this kind of examples many times, but is that
really different from what even SVN does? "svn log drivers/char" will
also list atomic commits, and give me a filtered view of the global
log.

So, yes, that's cool, but I don't see a real difference between git
and almost anything else (except CVS which really got this wrong, no
big surprise).

-- 
Matthieu
