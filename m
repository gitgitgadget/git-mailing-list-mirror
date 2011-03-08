From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: Q about the date format in "git commit --date=..." and such
Date: Tue, 08 Mar 2011 20:20:57 +0100
Message-ID: <4D768199.80204@dirk.my1.cc>
References: <4D73B158.5040409@dirk.my1.cc>	<20110307165448.GD11934@sigill.intra.peff.net>	<7vzkp6zclw.fsf@alter.siamese.dyndns.org>	<20110308011646.GA21278@sigill.intra.peff.net> <m2vcztqwcr.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Mar 08 20:27:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px2ZK-0004lp-07
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 20:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465Ab1CHT1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 14:27:36 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:53067 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab1CHT1f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 14:27:35 -0500
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Mar 2011 14:27:35 EST
Received: from [84.176.36.69] (helo=[192.168.2.100])
	by smtprelay01.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Px2Sn-00025V-TL; Tue, 08 Mar 2011 20:20:57 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <m2vcztqwcr.fsf@igel.home>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168679>

Am 08.03.2011 19:51 schrieb Andreas Schwab:
> Jeff King<peff@peff.net>  writes:
>
>> Why would you be resetting the date but _not_ taking ownership? Maybe
>> a reasonable situation for that exists, but I couldn't think of one.
>
> If you are already the author it's not so obvious that you have to reset
> authorship in order to reset the date.  Also, if you are the author, but
> under a different email you may not want to change that.
>
> Andreas.
>

Thank you, Peff and Andreas. Indeed I never tried --reset-author before 
but it works fine for my problem, as the authorship/email didn't change 
between the commits. However, I personally think --date=now should work 
everywhere but if you don't like it I will definitely not insist on it. :-)

In case I _really_ need it, I could use sth. like
--date=$(perl -e 'print localtime').

Dirk
