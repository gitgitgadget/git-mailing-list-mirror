From: gitlist <gitlist@myword.co.uk>
Subject: Re: Branching strategies
Date: Mon, 19 Sep 2011 19:51:01 +0100
Message-ID: <4E778F15.9050705@myword.co.uk>
References: <CAAZ43xaFzJWzPsqhP0QDRTP0Ea-dMpCpr1vDiujFFn94j+SRCQ@mail.gmail.com> <CAH5451kn5WD4+S3_SGMarGyoUs6NA6Xvz9Pb8Wdpt9v0nY+Uow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 21:21:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5jPM-0007AL-Fi
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 21:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756778Ab1ISTVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 15:21:31 -0400
Received: from mail3.anu.net ([83.96.156.167]:37678 "EHLO mail3.anu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874Ab1ISTVb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 15:21:31 -0400
X-Greylist: delayed 1828 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Sep 2011 15:21:30 EDT
Received: from Roddie-Grants-MacBook-Pro.local (cpc3-warw13-2-0-cust132.3-2.cable.virginmedia.com [86.17.75.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail3.anu.net (Postfix) with ESMTP id 331853199E4
	for <git@vger.kernel.org>; Mon, 19 Sep 2011 20:51:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <CAH5451kn5WD4+S3_SGMarGyoUs6NA6Xvz9Pb8Wdpt9v0nY+Uow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181694>

On 10/09/2011 02:18, Andrew Ardill wrote:
> On 10 September 2011 09:01, robert mena<robert.mena@gmail.com>  wrote:
>> Hi,
>>
>>  <snip>
>> Since some of those can touch the same files how can I make this a
>> little bit better (manageable)?
>>

> A very interesting read is
> http://nvie.com/posts/a-successful-git-branching-model/
>
> It may not be perfect for you, however it does discuss some very
> interesting issues, particularly how workflow is just as important as
> the branching model.


I came across the nvie post some time and it was very useful, but it 
doesn't address handling of feature branches, especially where there is 
overlap.

I have a website where people can register. They can also buy things. If 
they haven't registered when they come to checkout, the checkout process 
includes registration. Users can also create "sponsorship" pages where 
they ask friends to sponsor them in a marathon etc. If someone setting 
up a sponsorship page is not already registered, it's included in the 
process.

So there are three strands (to avoid using the word "branch") - 
registration, buying, and sponsorship - which end up affecting the same 
bits of code. Registration was done a year ago but recently needed 
updating; buying was started some months ago but got held up; 
sponsorship started recently, has been completed, and has "overtaken" 
buying.

How should I use branches in this scenario? Or if I've got the concept 
wrong, how should I change my workflow?

Thanks

Roddie Grant
