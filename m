From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [RFC] Patches exchange is bad?
Date: Thu, 18 Aug 2005 03:00:23 -0700 (PDT)
Message-ID: <20050818100023.80893.qmail@web26310.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 12:01:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5hCd-0005cd-TS
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 12:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVHRKA3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 06:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVHRKA3
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 06:00:29 -0400
Received: from web26310.mail.ukl.yahoo.com ([217.146.176.21]:9319 "HELO
	web26310.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932157AbVHRKA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 06:00:28 -0400
Received: (qmail 80895 invoked by uid 60001); 18 Aug 2005 10:00:23 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=GZ1WBWgHhwBsc585mRmyb0xwao6lT/NEedGbXC18m1dVf9XAq4Lh4e7JBwhtMKJu015M24Oph5F0J3OwVd1fctyuMW+GkAbX2LO2KFU5Kn5enB49FRUnMpWtuearodolRLS4dyiWPzxUhoo0HC+IxP+FEi4VguVUXJRfm/pPNJs=  ;
Received: from [151.42.103.149] by web26310.mail.ukl.yahoo.com via HTTP; Thu, 18 Aug 2005 03:00:23 PDT
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas wrote:

>
>The base of the StGIT stack in the HEAD repository (branch) should
>always be the head of the MAIN repository. 

That's the point I missed, now it's more clear.

>
>That's how you would normally do development on Linux using StGIT -
>clone the mainline kernel, create patches in your StGIT tree and submit
>them either via e-mail or ask the gatekeeper to pull directly from your
>tree (assuming that you only push those patches that need to be merged).
>Doing a 'stg pull' would retrieve the latest changes from the mainline
>kernel (including the changes made by your patches which were merged
>upstream).
>

If I uderstand correctly you never commit patches from StGIT stack directly
in your base git repository, in this example git HEAD, but you always round 
trip to MAIN. 

Then you don't have two git repository: HEAD and MAIN

Infact there is only one git repository, MAIN, cloned on your box and called HEAD and 
with a StGIT stack added on top.

>
>Please let me know if this needs further clarification.
>

I think so. 
Please, reading my notes above tell me if I thinking right ;-)

Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
