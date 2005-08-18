From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [RFC] Patches exchange is bad?
Date: Thu, 18 Aug 2005 06:34:10 -0700 (PDT)
Message-ID: <20050818133411.15529.qmail@web26306.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 15:35:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5kXJ-0004cC-Vm
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 15:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVHRNeU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 09:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbVHRNeU
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 09:34:20 -0400
Received: from web26306.mail.ukl.yahoo.com ([217.146.176.17]:28857 "HELO
	web26306.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932225AbVHRNeU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 09:34:20 -0400
Received: (qmail 15531 invoked by uid 60001); 18 Aug 2005 13:34:11 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5AUYIrVtNccIr+JQr+gaftKPHgZ13qPZoBzo2MPcvrcxEDHxztGdwbKcC/S4DtxJ2yJVb8T+J+4fbIUaDosqyAQyVBfaSYuRlWSEfoichc2CH2ox4K4d3f3nh8VyxPFC8i/da+zSitoimya0/HUr/rGNTD3gb35R7ddeAqXqoOE=  ;
Received: from [151.42.103.149] by web26306.mail.ukl.yahoo.com via HTTP; Thu, 18 Aug 2005 06:34:10 PDT
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas wrote:

>>
>>If I uderstand correctly you never commit patches from StGIT stack directly
>>in your base git repository, in this example git HEAD, but you always round 
>>trip to MAIN.
>
When I say 'you always round trip to MAIN', I mean you send patches 
upstream and someone commits to MAIN, then you pull from MAIN.

Sorry if it was not clear.

>
>One usually doesn't maintain MAIN. That's an example for the Linux
>kernel development where you can't control what get merged into MAIN.
>
>There is a bit of confusion here since you said in a previous e-mail
>that more people can commit to the stable branch. In this case, you
>would need a separate repository for stable with a maintainer pulling
>changes from others.
>

When I said 'more people can commit to the stable branch' I meant more 
people sends patches to a mantainer that commits the patches in a stable branch.

Sorry, peraphs also this was not clearly expressed.


>>Then you don't have two git repository: HEAD and MAIN
>>
>>Infact there is only one git repository, MAIN, cloned on your box
>>and called HEAD and with a StGIT stack added on top.
>
>
>The StGIT usage idea is that you only know what patches you have on
>top of a main repository. Since you expect your patches to be merged
>upstream or just updated every time the main repository changes, it
>might not make sense to commit the patches onto the base.
>

Yes, you better explained what I was badly trying to say before.


>
>I need a bit more clarification about your work flow.
>

I was thinking at two different kind of workflow, one were you are tracking a 
remote repository ( Linux kernel project like ) and one as single developer with 
both stable and develop lines ( qgit or StGIT ;-) projects like ). 

You clarified me for both cases.

Thanks
Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
