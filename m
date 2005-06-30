From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 14:27:55 -0400
Message-ID: <42C439AB.30002@gmail.com>
References: <Pine.LNX.4.58.0506301025510.14331@ppc970.osdl.org> <42C438CA.3040507@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 30 20:21:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do3eu-0001II-Px
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 20:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbVF3S2g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 14:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbVF3S2g
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 14:28:36 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:22416 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262839AbVF3S2e (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 14:28:34 -0400
Received: by wproxy.gmail.com with SMTP id i11so152923wra
        for <git@vger.kernel.org>; Thu, 30 Jun 2005 11:28:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VTJUf94diaFz+rqfv8PAFsOMBJ81CSBj08s90+czTs6YiziATyvP8Yzxqxuf//FmheZWM1LjyCI772nLLhJsabhJo0crRVO+rxHWnpOZLzO8IlouZ32Vlxs81N9vEOf7eEHAIA7wcivY1AtLXe9Mv1KrL+D5nnOh6BG5zLainHo=
Received: by 10.54.53.25 with SMTP id b25mr593231wra;
        Thu, 30 Jun 2005 11:27:57 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id g9sm143280wra.2005.06.30.11.27.57;
        Thu, 30 Jun 2005 11:27:57 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: gitzilla@gmail.com
In-Reply-To: <42C438CA.3040507@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Damn! That should have been:

ssh torvalds@master.kernel.org \
	'/bin/sh -c "export PATH=~/tmp/foo:$PATH ; env"'

A Large Angry SCM wrote:
> Have you tried something like the following?
> 
> ssh torvalds@master.kernel.org \
>     '/bin/sh -c "export PATH=/tmp/foo:$PATH ; env"'
> 
> Linus Torvalds wrote:
>>
> ...
>  >
>> Anyway, please do give it a test. I think I'll use this to sync up to
>> kernel.org, except I _really_ would want to solve that ssh issue some 
>> other way than hardcoding the /home/torvalds/bin/ path in my local 
>> copies.. If somebody knows a good solution, pls holler.
> 
