From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/4] msvc: Fix some "expr evaluates to function" compiler
 warnings
Date: Fri, 25 Jun 2010 20:48:26 +0100
Message-ID: <4C25080A.107@ramsay1.demon.co.uk>
References: <4C226323.5080709@ramsay1.demon.co.uk> <201006241201.08212.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jun 26 20:02:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSZi3-0008P4-RP
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 20:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634Ab0FZSCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 14:02:16 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:36232 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753455Ab0FZSCP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Jun 2010 14:02:15 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1OSZhm-00025m-no; Sat, 26 Jun 2010 18:02:14 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <201006241201.08212.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149764>

Johan Herland wrote:
> On Wednesday 23 June 2010, Ramsay Jones wrote:
>> In particular, the following warning is issued while compiling
>> notes.c:
>>
>>     notes.c(927) : warning C4550: expression evaluates to a \
>> function which is missing an argument list
>>
>> along with identical warnings on lines 928, 1016 and 1017.
>>
>> In order to suppress the warning, we change the definition of
>> combine_notes_fn, so that the symbol type is an (explicit)
>> "pointer to function ...".  As a result, several other
>> declarations need some minor fix-up to take account of the
>> new typedef.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> 
> Acked-by: Johan Herland <johan@herland.net>

Thanks!

ATB,
Ramsay Jones
