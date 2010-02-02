From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Fix signal handler
Date: Tue, 02 Feb 2010 22:44:37 +0100
Message-ID: <4B689CC5.3000400@web.de>
References: <4B684F5F.7020409@web.de> <20100202205849.GA14385@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 02 22:44:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcQYD-0002xl-OX
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 22:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756802Ab0BBVop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 16:44:45 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:55069 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747Ab0BBVol (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 16:44:41 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id CABE2145FD4EC;
	Tue,  2 Feb 2010 22:44:39 +0100 (CET)
Received: from [78.49.150.133] (helo=[192.168.1.202])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NcQY3-0001Tt-00; Tue, 02 Feb 2010 22:44:39 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <20100202205849.GA14385@sigill.intra.peff.net>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1+puJYs9b1PjFwHRf940IIniLrWt4oDertZK9c4
	eKb4uaywaQjnquLTECYifkzFQFUyCvo6wayUnPS9wlfpe/3EWd
	+m/2Gxb+LK45CbrHlvEQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138761>


>
> No, it's not a sig_atomic_t, but it is assignment of a single function
> pointer that is properly declared as volatile. Is this actually a
> problem on any known system?
>   

Is it guaranteed to work on all supported software environments that an
address can be atomically set?


> If you want to nit-pick, there are much worse cases. For example, in
> diff.c, we do quite a bit of work in remove_tempfile_on_signal.
>   

Thanks that you point out another open issue.


> It assumes that char* assignment is atomic, but nothing is even marked as
> volatile. But again, is this actually a problem on any system?
>   

Would you like to provide software implementations that work by design?

Regards,
Markus
