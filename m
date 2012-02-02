From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [msysGit] Breakage in master?
Date: Thu, 02 Feb 2012 21:15:14 +0100
Message-ID: <4F2AEED2.30503@web.de>
References: <CABPQNSbWu0r_gKGvCHk567pUtQiyDOCO8vFfrzPMFW1eUaj1nw@mail.gmail.com> <alpine.DEB.1.00.1202021956370.1249@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= =?ISO-8859-1?Q?_Bjarmason?= 
	<avarab@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 02 21:15:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt342-0001Xl-Sc
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879Ab2BBUPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 15:15:20 -0500
Received: from smtp-out12.han.skanova.net ([195.67.226.212]:33217 "EHLO
	smtp-out12.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754644Ab2BBUPT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 15:15:19 -0500
Received: from birne.lan (194.22.188.61) by smtp-out12.han.skanova.net (8.5.133) (authenticated as tboegi@telia.com)
        id 4EFC380E009445B8; Thu, 2 Feb 2012 21:15:15 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <alpine.DEB.1.00.1202021956370.1249@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189697>

On 02.02.12 19:57, Johannes Schindelin wrote:
> Hi Erik,
> 
> On Thu, 2 Feb 2012, Erik Faye-Lund wrote:
> 
>> Something strange is going on in Junio's current 'master' branch
>> (f3fb075). "git show" has started to error out on Windows with a
>> complaint about our vsnprintf:
>> ---8<---
>>
>> $ git show
>> commit f3fb07509c2e0b21b12a598fcd0a19a92fc38a9d
>> Author: Junio C Hamano <gitster@pobox.com>
>> Date:   Tue Jan 31 22:31:35 2012 -0800
>>
>>     Update draft release notes to 1.7.10
>>
>>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>
>> fatal: BUG: your vsnprintf is broken (returned -1)
>> ---8<---
>>
>> [...]
>>
>> I'm at a loss here. Does anyone have a hunch about what's going on?
> 
> It very much reminds me of 6ef404095bc1162031fc3cb43430b512e975bc6a...
> 
> Is it possible that NO_GETTEXT is either not set, or ignored?
> 
> Ciao,
> Dscho
Hi,
same problem here, tested on Win XP.

Good news (?):
Setting 
NO_GETTEXT=YesPlease
in the Makefile makes the problem go away for me.
/Torsten
