From: Jorma Karvonen <karvjorm@users.sourceforge.net>
Subject: Re: Compiling git-snapshot-20069831
Date: Thu, 31 Aug 2006 19:59:03 +0300
Message-ID: <44F71557.1080404@users.sourceforge.net>
References: <44F6D016.4050007@users.sourceforge.net> <Pine.LNX.4.63.0608311408350.28360@wbgn013.biozentrum.uni-wuerzburg.de> <44F6F478.1070708@users.sourceforge.net> <Pine.LNX.4.63.0608311727010.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: karvjorm@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 18:59:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIpsg-0003KN-1x
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 18:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWHaQ6r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 12:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWHaQ6r
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 12:58:47 -0400
Received: from smtp2.song.fi ([194.100.2.122]:13651 "EHLO smtp2.song.fi")
	by vger.kernel.org with ESMTP id S932382AbWHaQ6q (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 12:58:46 -0400
Received: from [192.168.1.34] (dsl-60-2-216-83.maxinetti.fi [83.216.2.60])
	by smtp2.song.fi (Postfix) with ESMTP id BD9041AE7EB;
	Thu, 31 Aug 2006 19:58:44 +0300 (EEST)
User-Agent: Thunderbird 2.0a1 (X11/20060724)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608311727010.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26268>

Johannes Schindelin wrote:
> Hi,
>
> On Thu, 31 Aug 2006, Jorma Karvonen wrote:
>
>   
>> Johannes Schindelin wrote:
>>     
>>> Hi,
>>>
>>> since you do have a recent snapshot, why not try ./configure, as Pasky
>>> suggested?
>>>
>>> BTW I cannot read Finnish, but it probably says that you do not have curl
>>> installed. configure would detect that, and automatically set NO_CURL=1.
>>>
>>> Ciao,
>>> Dscho
>>>
>>>
>>>   
>>>       
>> Sorry,
>>
>> but I have not any git installed and there is no configure file in installing
>> directory.
>>     
>
> Ooops. As mentioned elsewhere, try "make configure" first.
>
>   
I tried

make configure

and got an error message:

/bin/sh: curl-config: command not found
make: **** No rule to make target `configure'. Stop.

Then I tried

make NEEDS_LIBICONV=1 NO_CURL=1 configure

and error message was: make: **** No rule to make target `configure'. Stop.
> This would not be necessary with ./configure, since it writes these 
> settings into a file, which is read by "make".
>
> Ciao,
> Dscho
>
>
>
>   
