From: Jorma Karvonen <karvjorm@users.sourceforge.net>
Subject: Re: Compiling git-snapshot-20069831
Date: Fri, 01 Sep 2006 16:30:58 +0300
Message-ID: <44F83612.6070707@users.sourceforge.net>
References: <44F6D016.4050007@users.sourceforge.net> <Pine.LNX.4.63.0608311408350.28360@wbgn013.biozentrum.uni-wuerzburg.de> <44F6F478.1070708@users.sourceforge.net> <Pine.LNX.4.63.0608311727010.28360@wbgn013.biozentrum.uni-wuerzburg.de> <44F71557.1080404@users.sourceforge.net> <Pine.LNX.4.63.0608311904520.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: karvjorm@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 01 15:31:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJ96Y-0003br-0v
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 15:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWIANai (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 09:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWIANai
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 09:30:38 -0400
Received: from smtp1.song.fi ([194.100.2.124]:14220 "EHLO smtp1.song.fi")
	by vger.kernel.org with ESMTP id S1751283AbWIANai (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Sep 2006 09:30:38 -0400
Received: from [192.168.1.34] (dsl-60-2-216-83.maxinetti.fi [83.216.2.60])
	by smtp1.song.fi (Postfix) with ESMTP id 1C3C817CE96;
	Fri,  1 Sep 2006 16:30:37 +0300 (EEST)
User-Agent: Thunderbird 2.0a1 (X11/20060724)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608311904520.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26300>

Johannes Schindelin wrote:
> Hi,
>
> On Thu, 31 Aug 2006, Jorma Karvonen wrote:
>
>   
>> I tried
>>
>> make configure
>>
>> and got an error message:
>>
>> /bin/sh: curl-config: command not found
>> make: **** No rule to make target `configure'. Stop.
>>     
>
> Okay. I deem this a bug in our Makefile.
>
> Could you please try "autoconf" and _then_ "./configure"?
>
> Hth,
> Dscho
>
>   
Hi,

I tried git-snapshot-20060901 and everything is now OK.

make prefix=/usr/local NEEDS_LIBICONV=1 NO_CURL=1

and

make prefix=/usr/local NEEDS_LIBICONV=1 NO_CURL=1 install

were the correct commands and git is now installed.

Thank you very much,

Jorma Karvonen
