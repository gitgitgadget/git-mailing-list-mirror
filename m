From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] t0090: be prepared that 'wc -l' writes leading blanks
Date: Tue, 20 Dec 2011 10:17:41 +0100
Message-ID: <87d3bjlhze.fsf@thomas.inf.ethz.ch>
References: <7F1792D2-8ED4-4546-8ED4-52B95E0AE9FC@silverinsanity.com>
	<4EE8C3AD.9050605@viscovery.net> <4EF04635.6020406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 10:17:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcvpX-0003N2-7w
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 10:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab1LTJRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 04:17:46 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:58703 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501Ab1LTJRo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 04:17:44 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 20 Dec
 2011 10:17:39 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 20 Dec
 2011 10:17:42 +0100
In-Reply-To: <4EF04635.6020406@viscovery.net> (Johannes Sixt's message of
	"Tue, 20 Dec 2011 09:24:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187505>

Sorry for slacking off on replying to this thread...

Johannes Sixt <j.sixt@viscovery.net> writes:
> Use 'printf %d $(whatever|wc -l)' so that the shell removes the blanks
> for us.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> Am 12/14/2011 16:41, schrieb Johannes Sixt:
>> I'd solve it by moving the command substitution outside the quoted string:
>> 
>>  	printf "SHA (%d entries, 0 subtrees)\n" \
>> 		$(git ls-files | wc -l) >expect &&
>> 
>> Other proposed solutions add another process. I don't like that on Windows ;)
>
> And here is a proper patch to that effect.

Acked-by: Thomas Rast <trast@student.ethz.ch>

This is the best solution also because it the formatting more (instead
of less) readable.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
