From: Max Horn <max@quendi.de>
Subject: Re: [Query] Can we ignore case for commiters name in shortlog?
Date: Fri, 30 Nov 2012 12:19:00 +0100
Message-ID: <C9C7BAF7-D552-41CF-B45D-413B9B69C054@quendi.de>
References: <CAOh2x==NBeeoE2=PhaDC143ZF_xHKD5m=Po+-DS2X43CEeGiEQ@mail.gmail.com> <alpine.LFD.2.02.1211292231520.4576@xanadu.home> <CAKohponGXq=P88Y=cmUPbRCeJ--VkMvJyw5th1T-WdGQnn4xWg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: viresh kumar <viresh.kumar@linaro.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 12:19:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeOcs-00027k-Pg
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 12:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757917Ab2K3LTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 06:19:06 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:45343 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757912Ab2K3LTF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 06:19:05 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TeOcW-0001Z9-Hf; Fri, 30 Nov 2012 12:19:00 +0100
In-Reply-To: <CAKohponGXq=P88Y=cmUPbRCeJ--VkMvJyw5th1T-WdGQnn4xWg@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1354274345;51ab6268;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 30.11.2012, at 04:35, viresh kumar wrote:

> On 30 November 2012 09:03, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> 
>> Have a look at the .mailmap file in the top directory of your repo.
> 
> Repeating what i said to David in other mail:
> 
> I have my name there :)
> 
> I thought using names with different case is actually different then misspelling
> it. And so, everybody must not be required to update their names in mailmap
> with different case. So, with same email id and same name (that may be in
> different case), we can show commits together in shortlog.

I don't see how wrong case is different from any other form of misspelling. And mailmap is there precisely to handle such problems. Now, if these case issues were for some reasons very frequent, it might be worth adding dedicated support for it. But this seems dubious to me -- do you have any evidence for this? Indeed, do you have more than just the one example?

In a nutshell, there seem to be two options here, and I know which *I* find more appealing ;)

1) continue this discussion over several emails to design a new feature (an option, config setting, whatever) to handle your special case, then sit down and write code for it, add documentation, add test cases to test it.

2) You just add a single entry to your mailmap to solve your problem at hand. :-)


Cheers,
Max