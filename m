From: Andreas Ericsson <ae@op5.se>
Subject: Re: Quick question: how to generate a patch?
Date: Mon, 27 Feb 2006 18:09:21 +0100
Message-ID: <44033241.6070001@op5.se>
References: <6d6a94c50602270657m453cc581p6ec290c20879de25@mail.gmail.com>	 <Pine.LNX.4.64.0602270801280.22647@g5.osdl.org>	 <6d6a94c50602270818k5f82bb8ft68a19899db3db636@mail.gmail.com>	 <Pine.LNX.4.64.0602270830330.22647@g5.osdl.org> <6d6a94c50602270902k2c06aaffw7e70268b0753ef64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 18:10:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDlsE-0006Aa-6z
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 18:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWB0RJX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 12:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWB0RJX
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 12:09:23 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:58803 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751493AbWB0RJW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 12:09:22 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id B389F6BD15; Mon, 27 Feb 2006 18:09:21 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Aubrey <aubreylee@gmail.com>
In-Reply-To: <6d6a94c50602270902k2c06aaffw7e70268b0753ef64@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16864>

Aubrey wrote:
>>It really should "just have worked". Can you show what the diff actually
>>looked like, and your exact command history?
> 
> 
> 
>>If it was something like
>>
>>        git clone remote-repo localdir
>>        cd localdir
>>        vi somefile
>>        git diff
>>
> 
> Yes, exactly right.
> 

Did you by any chance do chmod -R, chown -R or start an ntp daemon 
somewhere in between there (don't know if clock skews will be detected 
by git, but...)?

> 
>>then you did everything right, and if it gives any diff other than your
>>changes to "somefile", something is buggy. Need more info.
>>
>>Does "git diff" and "git diff HEAD" give different results, btw?
> 
> 
> Yes. the two commands give the same results.
> 

Decidedly odd. What happens when you do "git update-index --refresh" and 
then re-run the "git diff > my.patch" thing?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
