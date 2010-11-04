From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Thu, 04 Nov 2010 18:34:39 +0100
Message-ID: <vpq62wddmc0.fsf@bauges.imag.fr>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org>
	<20101104112530.5c0e444a@chalon.bertin.fr>
	<4CD2E7B4.3000908@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <dirson@bertin.fr>, <kevin@sb.org>,
	<git@vger.kernel.org>
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 18:35:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE3iH-0006zr-69
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 18:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471Ab0KDRez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 13:34:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56007 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155Ab0KDRey (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 13:34:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id oA4HS6db009611
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 4 Nov 2010 18:28:06 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PE3hw-0003DY-8a; Thu, 04 Nov 2010 18:34:40 +0100
In-Reply-To: <4CD2E7B4.3000908@nextest.com> (Eric Raible's message of "Thu\, 4 Nov 2010 10\:04\:52 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 04 Nov 2010 18:28:06 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA4HS6db009611
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1289496490.05616@caT0ePw2bDoDwd9xfZlNkQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160738>

Eric Raible <raible@nextest.com> writes:

> On 11:59 AM, Yann Dirson wrote:
>>>> I'm sorry if I'm missing something, but how is this different from
>>>> "edit"?
>>>
>>> Edit cherry-picks a commit, then exits to the shell. I needed to exit
>>> to the shell without cherry-picking a commit.
>> 
>> Indeed, before "x false" was available, I had found out that "edit"
>> without an argument fails with a harmless error and indeed achieves that
>> "pause" mechanism which was really missing.
>> 
>> What about just fixing this so we can use "edit" ?  Do we really need
>> another command here ?
>
> FWIW: +1 for edit.

I like the idea (and I won't fight for my "pause" proposal if others
don't find it intuitive), but I'm wondering how to write the quick
documentation (in the todo-list). And if we don't find a concise way
to document it, it may reveal that it's a bad idea ...

Maybe:

#  e <commit>, edit <commit> = use commit, but stop for amending
#  e, edit = stop for amending

but I find this rather ugly.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
