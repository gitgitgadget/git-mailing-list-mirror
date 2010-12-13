From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] completion: Add PS1 configuration for submodules
Date: Mon, 13 Dec 2010 19:12:47 +0100
Message-ID: <4D06621F.6010101@web.de>
References: <1291677763-55385-1-git-send-email-scott@appden.com> <AANLkTin8JstkjEWaCGZuqpEXZnLMyudFm24K7Y3iCgX6@mail.gmail.com> <0E479F18-B26A-4216-A71E-C65EAB41A74A@sb.org> <4CFEA249.907@web.de> <AANLkTinnH4pFaEf=e4YE64f7cwLRx2R_2o_-=JGua30b@mail.gmail.com> <20101207212949.GA25162@burratino> <AANLkTinjzvCDjCFrvujdFPRZKo2vK_9_8j3ybLNAfFmE@mail.gmail.com> <20101212063848.GB17185@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Scott Kyle <scott@appden.com>, Kevin Ballard <kevin@sb.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 19:13:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSCts-0002J2-6t
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 19:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912Ab0LMSNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 13:13:13 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:35611 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab0LMSNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 13:13:09 -0500
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate03.web.de (Postfix) with ESMTP id AA92D17D85118;
	Mon, 13 Dec 2010 19:12:56 +0100 (CET)
Received: from [93.240.111.220] (helo=[192.168.178.51])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PSCtL-0006gs-00; Mon, 13 Dec 2010 19:12:56 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20101212063848.GB17185@burratino>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX197z49GwrNBgbQ6xd4/onGGMuq3UxqrHQyX2CNU
	ZWlERDN38+M6t8FpsAwxhS1RHxgjPzbjTzkOY7OEWwBPDjyD4/
	/5G+Pag/B+N95GbmphCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163578>

Am 12.12.2010 07:38, schrieb Jonathan Nieder:
> Scott Kyle wrote:
>> On Tue, Dec 7, 2010 at 1:29 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> Scott Kyle wrote:
> 
>>>> If I set the "submodule.<name>.ignore" then diffing around inside my
>>>> history will not show the changes to that particular submodule.
>>>
>>> Even if you set it to "dirty"?
>>
>> Setting it to "dirty" is far less disruptive, you're right, but that
>> wouldn't do me much good since my submodules are often on different
>> branches while developing.
> 
> Ah, I see now.  How about something like this?  Untested, just a
> vague sketch to show the idea.

Me thinks your proposal of a new "worktree" option makes sense. Let's
hear what Scott says ...
