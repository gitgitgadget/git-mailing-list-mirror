From: "J.H." <warthog9@kernel.org>
Subject: Re: What's cooking in git.git (Nov 2010, #02; Wed, 17)
Date: Thu, 18 Nov 2010 13:33:49 -0800
Message-ID: <4CE59BBD.9060105@kernel.org>
References: <7v1v6je9g8.fsf@alter.siamese.dyndns.org> <m3mxp668cy.fsf@localhost.localdomain> <7v1v6icyb0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 22:33:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJC6r-0002DS-M0
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 22:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759801Ab0KRVdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 16:33:33 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:58125 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757156Ab0KRVdc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 16:33:32 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oAILXDjd019388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 18 Nov 2010 13:33:14 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.7
In-Reply-To: <7v1v6icyb0.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 18 Nov 2010 13:33:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161714>

>> I am thinking about splitting main 'gitweb: File based caching layer
>> (from git.kernel.org)' patch in two, separating moving test for
>> $caching_enabled out of cache_fetch to separate commit (largest change
>> to original J.H. submission), but leaving hardening "do 'cache.pl';"
>> and replacing 0/1 valued $cache_enable with boolean valued 
>> $caching_enabled.
>>
>> Because currently new tests in t9501 and t9502 (examining status and
>> output of gitweb with caching enabled) do not pass, I am thinking
>> about adding new configuration know turning off "Generating..." page.
>>
>> BTW. should I forge J.H. signoffs, and add mine?
> 
> Just ping him beforehand ;-)

I hadn't done a signoff as Jakub asked me to investigate some breakage
in the testing infrastructure he had put together.  Sadly I haven't been
able to duplicate it, and I haven't been able to catch him online to try
and figure out what the problem was exactly.

That said there's already a way to disable the Generating... page so I'm
not sure why an extra, and different, mechanism to disable it is needed...

- John 'Warthog9' Hawley
