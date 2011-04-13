From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: using aliases within the subdirectory
Date: Wed, 13 Apr 2011 14:42:07 +0200
Message-ID: <4DA59A1F.7060104@drmicha.warpmail.net>
References: <4DA579CA.5030908@ge.infn.it> <4DA59480.5080307@drmicha.warpmail.net> <4DA5965C.8050501@ge.infn.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Matej Batic <matej.batic@ge.infn.it>
X-From: git-owner@vger.kernel.org Wed Apr 13 14:42:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9zOn-00075G-5w
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 14:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833Ab1DMMmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 08:42:11 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:42363 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751126Ab1DMMmK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 08:42:10 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8802D20596;
	Wed, 13 Apr 2011 08:42:09 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 13 Apr 2011 08:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Cnm4TAlWP+oibgpyji09YRFXrFs=; b=KGlndVx+zzZa0x6CXzc+jtjCowlr92YhXefmqUxxSwWz5wVsGdhWAjM1ukIc9P+G8daq0yBFMxwVFgGQnjfxv7HcmBS6ax9EGIwMoFf0M5ZBdoyXoXzP7M7ABP32Qr+IRd6feEMJodGwv0D3ckeYHWIvDXwab/Ug+xleK08y4zU=
X-Sasl-enc: T3YyYk5y7Bs6IQJi3knALaLhruGeCFMNbfgLTeug9sbS 1302698529
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 13ACB448C97;
	Wed, 13 Apr 2011 08:42:08 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <4DA5965C.8050501@ge.infn.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171449>

Matej Batic venit, vidit, dixit 13.04.2011 14:26:
> Michael J Gruber wrote:
>> Matej Batic venit, vidit, dixit 13.04.2011 12:24:
>>   
>>> Dear all,
>>>
>>> I am facing a problem, noted previously in
>>>     
>>> http://git.661346.n2.nabble.com/git-alias-always-chdir-to-top-td1609456.html  
>>>
>>>     http://kerneltrap.org/mailarchive/git/2010/5/5/29818/thread
>>> which in practice means that I cannot pass the " -- 
>>> relative_path_to_some_file_in_the_tree" argument to my alias.
>>>
>>> Is there any way to get the current working dir before git changes dir 
>>> to root directory?
>>>
>>> Best regards,
>>> Matej
>>>     
>>
>> This may depend on your shell and rc files, but for me, $PWD gives the
>> original current working dir.
>>
>> Also, revisiting that topic after 1.7.5 seems worthwhile.
>>
>> Michael
>>   
> 
> Well, that does not work for me:
> [alias]
>     pwd = "!sh -c 'echo $PWD'"
> 
> git pwd inside tree subdirectory will print git root directory with git 
> version 1.7.3.4 and also with 1.7.4.1.

I had only tried "pwd = !env" to check the environment which is passed
(and that has the PWD from the subdir). So, I guess you'd need to have a
second look at that topic.

Michael
