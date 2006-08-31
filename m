From: Andreas Ericsson <ae@op5.se>
Subject: Re: Compiling git-snapshot-20069831
Date: Thu, 31 Aug 2006 17:19:24 +0200
Message-ID: <44F6FDFC.9050707@op5.se>
References: <44F6D016.4050007@users.sourceforge.net> <Pine.LNX.4.63.0608311408350.28360@wbgn013.biozentrum.uni-wuerzburg.de> <44F6F478.1070708@users.sourceforge.net> <ed6tg9$9ij$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 17:22:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIoKI-00021v-1P
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 17:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbWHaPT1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 11:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWHaPT1
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 11:19:27 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:26539 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751313AbWHaPT0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Aug 2006 11:19:26 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 856106BD45; Thu, 31 Aug 2006 17:19:25 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,
	SUBJ_HAS_UNIQ_ID autolearn=ham version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 814086BD34; Thu, 31 Aug 2006 17:19:24 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ed6tg9$9ij$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26265>

Jakub Narebski wrote:
> Jorma Karvonen wrote:
>  
>> When I tested 
>>
>> make NEEDS_LIBICONV=1 NO_CURL=1
>>
>> the make succeeded but when trying make install I got error messages 
>> shown in the enclosed file.
> 
> Try then
>   $ NEEDS_LIBICONV=YesPlease NO_CURL=YesPlease make
> 

I think you meant

$ make NEEDS_LIBICONV=YesPlease NO_CURL=YesPlease install

there, Jakub.

Jorma, since the Makefile has no ideas on state, it only notices that 
some files it needs to make a complete install with the parameters 
you're passing it when also passing 'install' are missing, it tries to 
build them, but without the NEEDS_LIBICONV and NO_CURL flags. Pass them 
both when doing normal 'make' and when doing 'make install' and you'll 
be fine. You might also want to check if your distribution provides a 
pre-compiled package. If that's the case, you should be able to get away 
with something easy such as

	$ apt-get install git

or

	$ yum install git

Good luck

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
