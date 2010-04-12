From: Michal Vitecek <fuf@mageo.cz>
Subject: Re: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Mon, 12 Apr 2010 12:50:34 +0200
Message-ID: <20100412105034.GC30605@mageo.cz>
References: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com>
 <20100410042609.GA24295@coredump.intra.peff.net>
 <7vsk73zzt1.fsf@alter.siamese.dyndns.org>
 <4BC0D87E.70001@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Apr 12 13:14:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Hai-00058M-U9
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 13:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991Ab0DLLOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 07:14:00 -0400
Received: from interactive-1.com ([193.85.232.82]:33536 "EHLO
	interactive-1.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab0DLLOA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 07:14:00 -0400
X-Greylist: delayed 1404 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2010 07:13:59 EDT
Received: from interactive-1.com (localhost.localdomain [127.0.0.1])
	by interactive-1.com (Postfix) with ESMTP id A427B2E74A4;
	Mon, 12 Apr 2010 12:50:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BC0D87E.70001@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144721>

On 10.04.2010 21:58 CEST, Johannes Sixt wrote:
>Am 10.04.2010 06:39, schrieb Junio C Hamano:
>>I used to religiously rebase slushy topics that are not in any stable
>>integration branches (we used to have only 'master' and 'pu'), and
>>
>>	git rebase master foo
>>         git rebase master bar
>>         git rebase master baz
>>
>>was far easier to type than
>>
>>	git checkout foo&&  git rebase master
>>	git checkout bar&&  git rebase master
>>	git checkout baz&&  git rebase master
>
>I'm actually very glad that the current interface is the way it is -
>because it can do the rebase *without* the checkout. This way you can
>save a lot of recompilation due to changed timestamps if the topic is
>based on an old version.
>
>Only that some (all?) variants of rebase still unnecessarily do the
>checkout...

 Is there any chance for merge to behave the same? I really like that I
 don't have to do a checkout prior rebasing.

        Thanks,
-- 
		Michal Vitecek		(fuf@mageo.cz)
