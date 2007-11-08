From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH MISC 1/1] Make gcc warning about empty if body go away.
Date: Thu, 08 Nov 2007 09:20:55 -0600
Message-ID: <47332957.5050308@freescale.com>
References: <1194430832-6224-1-git-send-email-madcoder@debian.org>	<1194430832-6224-2-git-send-email-madcoder@debian.org> <7vode57awg.fsf@gitster.siamese.dyndns.org> <4732CBD3.503@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 08 16:33:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq9NV-0005py-9N
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 16:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759729AbXKHPcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 10:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759618AbXKHPcv
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 10:32:51 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:46194 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759545AbXKHPcv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 10:32:51 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id lA8FKvaM018087;
	Thu, 8 Nov 2007 08:21:00 -0700 (MST)
Received: from [10.214.72.17] (mvp-10-214-72-17.am.freescale.net [10.214.72.17])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lA8FKuKh009950;
	Thu, 8 Nov 2007 09:20:56 -0600 (CST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <4732CBD3.503@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64043>

Andreas Ericsson wrote:

>> +    if (active_cache_changed &&
>> +        !write_cache(fd, active_cache, active_nr) && !close(fd))
>> +        commit_locked_index(lock_file);
>>      rollback_lock_file(lock_file);
>>  }
>>  
> 
> Ack, obviously, as it no longer requires a comment to explain it, although
> I'd prefer an empty line after commit_locked_index(lock_file); so as to not
> confuse the rollback_lock_file() statement as being part of the conditional
> path.
> 
> First I thought the rollback_lock_file() was the *only* statement to the
> condition, and everyone who uses 4 for tabsize) will have double trouble
> since commit_locked_index(lock_file) aligns with the second line of the
> condition.
> 

It's too bad this was confusing due to the lack of braces. :-)

jdl
