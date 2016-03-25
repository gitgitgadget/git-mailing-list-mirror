From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 0/5] Expanding tabs in "git log" output
Date: Fri, 25 Mar 2016 10:34:00 +0100
Message-ID: <56F50608.10606@web.de>
References: <xmqq7fh0s5l7.fsf@gitster.mtv.corp.google.com>
 <1458775426-2215-1-git-send-email-gitster@pobox.com>
 <56F391A4.6090603@web.de> <xmqqmvpn91o2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 25 10:34:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajO8U-0002JY-3X
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 10:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbcCYJeY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 05:34:24 -0400
Received: from mout.web.de ([212.227.17.11]:56897 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbcCYJeW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 05:34:22 -0400
Received: from macce.local ([79.223.101.215]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0Lo0V2-1a89dU47RI-00fwdN; Fri, 25 Mar 2016 10:34:05
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.0
In-Reply-To: <xmqqmvpn91o2.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:qO/el7qbRXr0rFf+FyD3aUX9zn05kgeiYzbChjbEouGC9S3zeke
 MWYXraJWWeNUq82UZonzBqwmhHDG4ZNqGbrWmN5Y4JoZszvs2dNpIJrMFoFiG+ftApQMFqx
 C2aEeatW3ngnTR8FU/BynvL9lZ8NHQGjr8EWCQELLE/LwHM+HSL4gedgKEbOgHK6Hjw4ydZ
 6KtmQA9TwCRFXV/JScqSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Yo8us3BmNLY=:Y3Ucyi4B3Vdxb7CxF08EWd
 fnlQijpyxa5u4hTForvGsRLdkRlei3zslABgSwFIIjLrw5FiPiWXmhEEiE4YJ45XyBu7PkFLs
 kSnzl8bVn0EXyY07g2BON4AfmS6AfNpOi2/8zDCo5FPDdSwyFZFTU1eHGY34Qn62eqCHQKQl4
 OieB9zHRWqWYam86v0Q1PbluAZzCbOyj+o3S0i/PnM7fkOiKmI2rBf78QZ10+aCF3FTxOoE34
 EWdbKtxGqnxG7bDBCrl2LAJyibQWCgYpDC3pWnuQv2ZXW5jxtYEDdXHUx07rCNH5F5yEWfjHh
 5ABgBPY14UXrZ05sOTuXvdL7ucU2SvNKSFKaijd3LFfY1pBgPi2Z+Z98resuJoNH5s8vePOl5
 ABzQk6jKLVYsT5iRwUmU1c/00h/WmM1cnrxmI/10Ae3i0Ya3UrhIvoRsDJvPLxoLXC+SbuY7O
 12LnAp5bLn9JSjJauaN+635DR/LwlZyp25Q9HGHEl+C+1JcwCBLn2dXCR2UktYwuzTHMgOuwh
 HqW+G5MFKBCjxqVkcefrnDXU/EsuYrHQoTYuC3SFInSUzhrIBtqDcU8myijggfSkcd7XAJxvn
 vnjm0YIZ34y4EEfiOMzWChyxQEP9uvvgEFqEctpDYdzs/2pnoATxotXWUOhX8HiEcFYxcnqc2
 9iUiyiPlIl4MiaZYaErTzLq/hKj3AfUderVlICdi0XSxkzQfKcZGTqYNYzHnGTI5DxEOw+d3I
 SP5a6TXic2WGhM2zZ1uPDnKigsFod1m9tJTIZ3nIhhg2hXXeD/1e6gSCnP0alLnUfHQ2ogKK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289866>

On 2016-03-24 19.22, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> Would it make sense to have
>> git log --tab-size=3D8
>> (or similar)
>>
>> and add a config variable like
>> git config ui.logtabsize
>> which is 0 by default to get the old handling and 8 for the new one =
?
>=20
> That may be a good approach (I agree with you that --tab-size is not
> the best name).  Want to try it as a replacement?

May be log.tabwidth ?
I'm happy to help out here, if we can cook the feature in pu for 3-4 we=
eks
or so ?
