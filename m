From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-difftool
Date: Fri, 02 Jan 2009 17:10:44 +0100
Message-ID: <vpq63kxofi3.fsf@bauges.imag.fr>
References: <20081226013021.GA15414@gmail.com>
	<402731c90812311211p548c49d3p100f79ddee7163b0@mail.gmail.com>
	<vpq8wpux61c.fsf@bauges.imag.fr>
	<200901020113.32082.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David Aguilar" <davvid@gmail.com>, git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Fri Jan 02 17:16:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LImgs-0007x4-Vu
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 17:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756540AbZABQOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 11:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753356AbZABQOk
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 11:14:40 -0500
Received: from imag.imag.fr ([129.88.30.1]:52606 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839AbZABQOj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 11:14:39 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n02GAiTS018836
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 2 Jan 2009 17:10:45 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LImbk-0002U3-D1; Fri, 02 Jan 2009 17:10:44 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LImbk-0005Ki-Ah; Fri, 02 Jan 2009 17:10:44 +0100
In-Reply-To: <200901020113.32082.markus.heidelberg@web.de> (Markus Heidelberg's message of "Fri\, 2 Jan 2009 01\:13\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 02 Jan 2009 17:10:45 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104385>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> Matthieu Moy, 01.01.2009:
>> "David Aguilar" <davvid@gmail.com> writes:
>> 
>> > Hmm... in theory, yes, but in practice, no.
>> > xxdiff is too gimp to handle what 'git diff' hands it =)
>> 
>> As done with "vimdiff" in another message, simply write a one-liner
>> wrapper script that calls xxdiff $2 $3, and call this wrapper script.
>
> This works with GUI tools, but not with console tools.

Actually, it does if you call git --no-pager.

> GVim works, Vim
> doesn't.
> And invoking
>     git difftool
> is by far more convenient than
>     GIT_EXTERNAL_DIFF=vimdiff git diff

Right, but a script "git-difftool" calling the later is a one-liner,
so 2 one-liners give you the same result as the ~500 lines script
proposed. And GIT_EXTERNAL_DIFF has the great advantage of being
maintained together with git, and will most likely handle all cases
(diff between index, working tree, arbitrary commit, ...) correctly.

-- 
Matthieu
