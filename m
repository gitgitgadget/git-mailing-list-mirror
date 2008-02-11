From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: fatal: Entry 'xxx' not uptodate. Cannot merge.
Date: Mon, 11 Feb 2008 11:21:38 +0100
Message-ID: <vpqwspbyerx.fsf@bauges.imag.fr>
References: <30929dfe0802102248p1f1cca44q4cec26a3237a3f20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Donuvi Tanoga" <donuvitanoga@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 11:23:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOVod-000622-19
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 11:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbYBKKWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 05:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbYBKKWg
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 05:22:36 -0500
Received: from imag.imag.fr ([129.88.30.1]:40335 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbYBKKWf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 05:22:35 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m1BALdao008482
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Feb 2008 11:21:39 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JOVn9-0001yy-0H; Mon, 11 Feb 2008 11:21:39 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JOVn8-0008Ta-Tx; Mon, 11 Feb 2008 11:21:38 +0100
In-Reply-To: <30929dfe0802102248p1f1cca44q4cec26a3237a3f20@mail.gmail.com> (Donuvi Tanoga's message of "Mon\, 11 Feb 2008 08\:48\:42 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 11 Feb 2008 11:21:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73506>

"Donuvi Tanoga" <donuvitanoga@gmail.com> writes:

> Hi Everyone,
>
> I have a problem I don't know how to solve.
>
> When I do git pull (on linus' tree), I get the following:
>
> Updating 9b73e76..19af355
> fs/binfmt_elf.c: needs update
> fatal: Entry 'fs/binfmt_elf.c' not uptodate. Cannot merge.
>
> This is 100% my fault, and not a bug (I probably
> accidentally changed it or something).
>
> Can you please help me to fix it ?

Run "git status", it will point you to the modifications you did in a
slightly more user-friendly format.

Git doesn't allow a merge if you have uncommited changes, either your
changes are irrelevant and you want to "git reset --hard", or they
are, and you want to commit (and perhaps use "rebase"), or stash them.

-- 
Matthieu
