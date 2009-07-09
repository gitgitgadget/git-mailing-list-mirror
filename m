From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: default aliases (ci, di, st, co)
Date: Thu, 09 Jul 2009 11:12:22 +0200
Message-ID: <vpqy6qycj9l.fsf@bauges.imag.fr>
References: <85b5c3130907081649s37f726f7id1a64f2fdbe609f@mail.gmail.com>
	<h34bms$8to$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 11:13:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOphJ-0006WJ-16
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 11:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758267AbZGIJNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 05:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759167AbZGIJNS
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 05:13:18 -0400
Received: from imag.imag.fr ([129.88.30.1]:43591 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758281AbZGIJNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 05:13:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n699CMOs006115
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 9 Jul 2009 11:12:24 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MOpfy-00056s-JG; Thu, 09 Jul 2009 11:12:22 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MOpfy-0004ZA-Ht; Thu, 09 Jul 2009 11:12:22 +0200
In-Reply-To: <h34bms$8to$1@ger.gmane.org> (Graeme Geldenhuys's message of "Thu\, 09 Jul 2009 11\:01\:55 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 09 Jul 2009 11:12:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122959>

Graeme Geldenhuys <graemeg@gmail.com> writes:

> Ondrej Certik wrote:
>> [alias]
>>     ci = commit
>>     di = diff --color-words
>>     st = status
>>     co = checkout
>>
>
> I also gave from SVN and I must admit, I did create co, st, ci
> aliases, but basically never used them, so removed them since. Git is
> not SVN, so why treat it as such.

co is indeed particularly nasty. Yes, it's common for cvs/svn
old-timers, but "co" is a prefix of "COmmit", and means "CheckOut".
That's really misleading.

And the problem with aliases is that although they are good for
personnal use, they become bad when people use them publicly : either
in mail messages or in scripts. Ask about something that requires "git
commit" on the Git mailing list, everybody will be talking about "git
commit", not one about "git ci", the other about "git checkin" and the
last one about "git commit". That's far less misleading (yes, the
example is oversimplified, but if I advise someone to use "git diff
--color-words", he/she understands what I'm talking about immediately,
while if I advise "git di", it requires more time).

One thing I'd like to see is a wizard that creates a ~/.gitconfig with
this section commented out when it does not exist, like

[alias]
# Aliases, uncomment the lines to use them.
# ci = commit
# di = diff --color-words

To reduce the effort of people willing to use aliases, without making
them totally official.

-- 
Matthieu
