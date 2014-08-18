From: Daniel Corbe <corbe@corbe.net>
Subject: Re: Location of git config on Windows
Date: Mon, 18 Aug 2014 13:05:50 -0400
Message-ID: <ygfsiktu3rl.fsf@corbe.net>
References: <ygfvbpqooog.fsf@corbe.net>
	<CABPQNSZDizccths0b_RZ5FXYYq=+4_2N35DMj9h4Rha_2voekw@mail.gmail.com>
	<53F135F8.60508@gmail.com> <ygflhqlvni7.fsf@corbe.net>
	<CABPQNSZ=BKqNPCWUmaCSz+gJtBRhjkWtpcDbirsV+KJX=c0kpg@mail.gmail.com>
	<ygf7g25vm9v.fsf@corbe.net>
	<CABPQNSZayAr0jf9C55wtEH_AJ_hSUkwFsGV4ZxVixizthojkRA@mail.gmail.com>
	<CABPQNSZGYDnSfyS7X+MdskhUrmFx5Kzoi+A5+pgoBiX5kPruyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karsten Blees <karsten.blees@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 18 19:06:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJQNk-0000VD-MT
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 19:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbaHRRF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 13:05:58 -0400
Received: from port80.smtpcorp.com ([207.58.147.67]:34027 "EHLO
	port80.smtpcorp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbaHRRFy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 13:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=smtpcorp.com; s=a0_1;
	h=Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:References:Subject:Cc:To:From; bh=gHXmp/Q7piZiASqzT6380B1XlUZfr5xpsw8hq5sgBmk=;
	b=V9VT5COxmzQ/NfmVTEPzqINw9dkrxXrp/QRqv5YGrVHj2Hh1xk+hVahx8gYi6NUpF6f07YHLombP48w+StdJLi/qHZxUayTQ9/8+nCVpAXmmYP3PmD+ZIGaFFw9er9t7Y11UDzvSLSPdiOBNZE/FMtKkvMrYmhjNIiqTZdN6Rxo=;
In-Reply-To: <CABPQNSZGYDnSfyS7X+MdskhUrmFx5Kzoi+A5+pgoBiX5kPruyg@mail.gmail.com>
	(Erik Faye-Lund's message of "Mon, 18 Aug 2014 17:51:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (berkeley-unix)
X-Smtpcorp-Track: 1bJQNW4gfLWt4-.8MJzirm3S
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255402>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Mon, Aug 18, 2014 at 5:47 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> On Mon, Aug 18, 2014 at 5:40 PM, Daniel Corbe <corbe@corbe.net> wrote:
>>>
>>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>>
>>>> Or you could just restart your shell when you disconnect...
>>>
>>> Well I'm not that daft.  I tried that and if it had resolved my problem
>>> I wouldn't have posted.
>>
>> Hm, but isn't that what Karsten explains in his last paragraph? What
>> shell are you running msys or cmd?
>
> Our /etc/profile does this:
>
> https://github.com/msysgit/msysgit/blob/master/etc/profile#L38
>
> ...however, our git-wrapper only does this:
>
> https://github.com/msysgit/msysgit/blob/master/src/git-wrapper/git-wrapper.c#L71
>
> So yeah, we don't seem to actually check if %HOMEDRIVE%%HOMEPATH%
> exists. Perhaps fixing this is the right thing to do then? Since the
> git-wrapper is run for *every* invokation of git, you wouldn't even
> have to restart the shell in this case.

But again, restarting the shell doesn't fix the problem.  

-Daniel
