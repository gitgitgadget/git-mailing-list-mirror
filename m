From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 15:58:58 -0800
Message-ID: <437E6AC2.3080905@zytor.com>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr> <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr> <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <20051118205513.GA3168@vrfy.org> <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org> <Pine.LNX.4.64.0511181338460.13959@g5.osdl.org> <437E51EB.7050100@zytor.com> <Pine.LNX.4.64.0511181519100.13959@g5.osdl.org> <437E6505.8000201@zytor.com> <Pine.LNX.4.64.0511181554580.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Ismail Donmez <ismail@uludag.org.tr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 01:25:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdG8Z-0003TT-4b
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 00:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVKRX7R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 18:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVKRX7R
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 18:59:17 -0500
Received: from terminus.zytor.com ([192.83.249.54]:10896 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751119AbVKRX7Q
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 18:59:16 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAINx3TE016926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 Nov 2005 15:59:04 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511181554580.13959@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12306>

Linus Torvalds wrote:
> 
> On Fri, 18 Nov 2005, H. Peter Anvin wrote:
> 
>>There is another usage mode: "we're dumping CVS and switching to this
>>new-fangled git thing."  I have myself done this with several projects by now.
> 
> 
> I agree that in that case, the problem space is _much_ simpler, and you're 
> able to do much more. 
> 
> And I suspect it works well for projects with a few developers that can 
> just afford to do that. And it obviously works for a big project with 
> hundreds of developers that is forced to do it. 
> 
> But I suspect it's not the common way of doing things. There's already a 
> few projects that do the "maintain in parallel" thing, like the Wine tree 
> discussed a few days ago.
> 

Oh, agreed.  However, if you want to convert your master repository you 
may want to do conversion.

And in *either* case you may want to convert commit messages.

	-hpa
