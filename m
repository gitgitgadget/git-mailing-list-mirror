From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-branch --with=commit
Date: Thu, 08 Nov 2007 00:13:58 -0800
Message-ID: <7vejf140jd.fsf@gitster.siamese.dyndns.org>
References: <7vpryl8x5t.fsf@gitster.siamese.dyndns.org>
	<4732BC6F.7070005@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 08 09:14:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq2Wr-0007ZL-Rl
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 09:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbXKHIOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 03:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbXKHIOG
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 03:14:06 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44070 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbXKHIOF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 03:14:05 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 5F61D2EF;
	Thu,  8 Nov 2007 03:14:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id DAC1A925CB;
	Thu,  8 Nov 2007 03:14:21 -0500 (EST)
In-Reply-To: <4732BC6F.7070005@viscovery.net> (Johannes Sixt's message of
	"Thu, 08 Nov 2007 08:36:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63957>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>>      $ git checkout -b xx/maint-fix-foo
>>      $ git am -3 -s ,xx-maint-fix-foo.patch
>
> Is this comma a hidden feature?

No, just my personal convention to queue e-mails from my mailbox.

>> With this patch, I could do this to find out which topic
>> branches already contain the faulty commit:
>>
>>     $ git branch --with=maint^ | grep /
>>       xx/maint-fix-foo
>
> It'd be helpful if you could construct the example in this commit
> message such that you don't need the "grep /" here; otherwise, the
> reader doesn't know which part of the effect is hidden by the grep.

Yeah, in the example sequence, I think only maint itself and
xx/maint-fix-foo are shown, so there is no need for grep.
