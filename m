From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Pure renames/copies
Date: Mon, 21 Nov 2005 13:37:53 -0800
Message-ID: <43823E31.2050500@zytor.com>
References: <87hda61a80.fsf@gmail.com>	<Pine.LNX.4.64.0511211020130.13959@g5.osdl.org>	<7vacfxrdao.fsf@assigned-by-dhcp.cox.net> <438235AA.8070805@zytor.com> <7vpsotofd0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 22:41:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeJMl-00006F-Fq
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 22:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbVKUViU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 16:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbVKUViU
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 16:38:20 -0500
Received: from terminus.zytor.com ([192.83.249.54]:47235 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750973AbVKUViU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 16:38:20 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jALLc3DH030871
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Nov 2005 13:38:05 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsotofd0.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12489>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> 
>>Any reason we can't make it take an actual decimal number, like -M1.0 or 
>>-M0.345?  It seems odd and annoying to invent our own notation for 
>>floating-point numbers, especially in userspace.
> 
> 
> No reason we "can't".  About we "don't", inertia and nothing
> else.  It happened around this time.
> 
> 	http://marc.theaimsgroup.com/?l=git&m=111654149421574
> 
> We could in addition to take 0 <= x <= 1 decimal number and that
> should be a simple patch to diff.c::parse_num().
> 

Okay, in that post Linus suggests that -M without an argument should be 
== 100% (1.0), thus avoiding having to mess up the meaning of -M100 as 
0.100.  It seems like a really odd thing to have -M100 mean something 
that's completely out of line with the rest of the meaning.

	-hpa
