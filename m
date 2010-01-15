From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Re: git clone against firewall
Date: Fri, 15 Jan 2010 20:33:37 +0100
Message-ID: <4B50C311.2040305@hartwork.org>
References: <4B4FACB1.2080902@hartwork.org>	<7vzl4fz0zb.fsf@alter.siamese.dyndns.org>	<4B50BE10.5010603@hartwork.org> <m2aawf1804.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 20:33:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVrvb-00055b-9h
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 20:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758084Ab0AOTdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 14:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757742Ab0AOTdl
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 14:33:41 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:45554 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052Ab0AOTdl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 14:33:41 -0500
Received: from [78.52.98.79] (helo=[192.168.0.3])
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1NVrvN-0001Ho-Do; Fri, 15 Jan 2010 20:33:37 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100103 Thunderbird/3.0
In-Reply-To: <m2aawf1804.fsf@igel.home>
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137103>

On 01/15/10 20:30, Andreas Schwab wrote:
> Sebastian Pipping <webmaster@hartwork.org> writes:
> 
>> I get a loop/freeze on
>>
>>   Trying 66.219.59.40...
>>
>> nothing more.  Can you deduce from that, what's happening?
> 
> So your firewall is dropping the packets on the floor.

I see.


> Not much that
> can be done about that.

My problem actually is not the dropping but that git doesn't stop
trying.  I actually want it to fail.



Sebastian
