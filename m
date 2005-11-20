From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Rss produced by git is not valid xml?
Date: Sun, 20 Nov 2005 10:28:11 -0800
Message-ID: <4380C03B.9090603@zytor.com>
References: <200511181833.40048.ismail@uludag.org.tr> <200511181926.10357.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr> <20051118200217.GA2831@vrfy.org> <Pine.LNX.4.63.0511190101590.28126@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Ismail Donmez <ismail@uludag.org.tr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 19:29:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdtvT-0001z3-3g
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 19:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVKTS2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 13:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVKTS2Z
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 13:28:25 -0500
Received: from terminus.zytor.com ([192.83.249.54]:13241 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750792AbVKTS2Y
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 13:28:24 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAKISBih027876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 20 Nov 2005 10:28:12 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511190101590.28126@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12392>

Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 18 Nov 2005, Kay Sievers wrote:
> 
> 
>>Yes, convince the git maintainers, that it's incredibly stupid not to
>>enforce utf8 in commit messages. It makes absolutely zero sense in a
>>SCM, which merges forth and back between people around the world to
>>allow random encodings from the last century.
> 
> 
> Oh, but it makes sense! Just because you happen to work on a very 
> international project does not mean everybody does.
> 
> Just because you happen to like utf-8 does not mean that you still do in 
> 2046. The encoding-du-jour might well be a 64-bit wide char code by then, 
> since they'll laugh about our dreaming about terabytes.
> 
> BTW, utf-8 was designed on purpose to be easily distinguishable from other 
> encodings so that you don't have to rely on every document obeying a 
> certain encoding.
> 

No, it wasn't.  It was designated on purpose to be ASCII-compatible, 
substring-safe, and minimally stateful.

Furthermore, it's extensible.  Although the original UTF-8 is limited to 
31 bits, and the officially published UTF-8 is further crippled to 21 
bits by Mirco$oft cronies who wanted it to be brainfuck-compatible with 
UTF-16, it could easily be extended to 64 bits or beyond.

I think it's *definitely* safe to say that whatever encoding we'll use 
in 2046, current UTF-8 will be a subset.  If you don't believe me, 
consider how long we've had ASCII and the first of the design criteria 
for UTF-8 that I listed in the first paragraph.

	-hpa
