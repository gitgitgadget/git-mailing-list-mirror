From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Bizarre behavior on git commit
Date: Wed, 05 May 2010 12:06:56 +0200
Message-ID: <vpqd3xa4q7z.fsf@bauges.imag.fr>
References: <s2t6f5a4e781005042246sb9ef3d48j134b22b5b41133ed@mail.gmail.com>
	<20100505060110.GA21260@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Loewenherz <dloewenherz@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 12:10:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9bYj-0000kz-FH
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 12:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934215Ab0EEKKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 06:10:24 -0400
Received: from imag.imag.fr ([129.88.30.1]:44661 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342Ab0EEKKX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 06:10:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o45A6uXE025592
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 5 May 2010 12:06:56 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O9bVI-0002Vn-B9; Wed, 05 May 2010 12:06:56 +0200
In-Reply-To: <20100505060110.GA21260@progeny.tock> (Jonathan Nieder's message of "Wed\, 5 May 2010 01\:01\:10 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 05 May 2010 12:06:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146387>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Strange.  Maybe a hook script?
>
>   GIT_TRACE=1 git commit -m "my commit message"
>
> should reveal the culprit, I hope.

If it doesn't, playing with "strace" may help (like:
strace -f -e clone,execve git commit -m foobar ).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
