From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [BUG] git-rebase fails when a commit message contains a diff
Date: Fri, 9 Nov 2007 15:29:05 +0100
Message-ID: <04B901C5-E8A4-494D-A8D0-4D430F818803@zib.de>
References: <20071109011214.GA5903@diku.dk> <7vlk98xkm3.fsf@gitster.siamese.dyndns.org> <7vhcjwxk1s.fsf@gitster.siamese.dyndns.org> <B2BAA0E1-8DA7-417D-AE25-53D8690810ED@zib.de> <Pine.LNX.4.64.0711091417500.4362@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 15:29:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqUqq-0007cS-RO
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 15:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760282AbXKIO2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 09:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759848AbXKIO2h
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 09:28:37 -0500
Received: from mailer.zib.de ([130.73.108.11]:65280 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760178AbXKIO2g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 09:28:36 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA9ERrN4011246;
	Fri, 9 Nov 2007 15:27:53 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA9ERnD9017732
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 9 Nov 2007 15:27:53 +0100 (MET)
In-Reply-To: <Pine.LNX.4.64.0711091417500.4362@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64189>


On Nov 9, 2007, at 3:18 PM, Johannes Schindelin wrote:

> Hi,
>
> On Fri, 9 Nov 2007, Steffen Prohaska wrote:
>
>> On Nov 9, 2007, at 2:51 AM, Junio C Hamano wrote:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> That's a known design limitation of applymbox/mailinfo.  Any
>>>> line that looks like a beginning of a patch in e-mail ("^--- ",
>>>> "^---$", "^diff -", and "^Index: ") terminates the commit log.
>>>
>>> Ok, so that explains the symptom.  What's the next step?
>>>
>>>  * The applymbox/mailinfo pair should continue to split the
>>>    commit log message at the first such line.  There is no point
>>>    breaking established workflow, and people in communities that
>>>    exchange patches via e-mail already know to avoid this issue
>>>    by indenting quoted diff snippet in the log message,
>>>    e.g. 5be507fc.
>>
>> I wasn't aware of this.
>
> But there's a really easy workaround: use --merge with git rebase.

It's no longer a problem for me. I now know the limitation and
the work around. But others could get bitten, too. We could
save them.

	Steffen
