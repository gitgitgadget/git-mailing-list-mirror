From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] check_and_freshen_file: fix reversed success-check
Date: Thu, 09 Jul 2015 22:51:50 +0200
Message-ID: <559EDEE6.1040807@kdbg.org>
References: <DUB120-W5049F72955243F44BB2511F6920@phx.gbl> <20150707141305.GA629@peff.net> <DUB120-W36B78FEE6DC80BDCB05D7FF6920@phx.gbl> <20150707194956.GA13792@peff.net> <559D60DC.4010304@kdbg.org> <20150708180539.GA12353@peff.net> <20150708183331.GA16138@peff.net> <559D9006.20102@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
	X H <music_is_live_lg@hotmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 22:52:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDInY-00029r-7I
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 22:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbbGIUv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 16:51:56 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:63562 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753668AbbGIUvz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 16:51:55 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3mS8nM6RYhz5tlB;
	Thu,  9 Jul 2015 22:51:51 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 6A7B052C3;
	Thu,  9 Jul 2015 22:51:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <559D9006.20102@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273777>

Am 08.07.2015 um 23:03 schrieb Johannes Sixt:
> Am 08.07.2015 um 20:33 schrieb Jeff King:
>> ...or maybe in the utime() step there is actually a bug, and we report
>> failure for no good reason. Ugh.
>
> Ah! That code is less than a year old. When I began to adopt a workflow
> requiring force-pushes lately, I wondered why I haven't seen these
> failures earlier, because I did do force pushes in the past, but not
> that frequently. I thought that I had just been lucky. But this would
> explain it.

And, in fact, with this patch these particular failures are gone! Thank 
you so much!

-- Hannes
