From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Tool renames.
Date: Wed, 14 Sep 2005 22:56:31 -0700
Message-ID: <43290D0F.9060408@zytor.com>
References: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>	<Pine.LNX.4.58.0509050738340.3504@evo.osdl.org>	<46a038f90509051713389c62c8@mail.gmail.com>	<Pine.LNX.4.58.0509060013520.4316@evo.osdl.org>	<7vll2atz8a.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.58.0509060057491.4316@evo.osdl.org>	<7vwtlusi9t.fsf@assigned-by-dhcp.cox.net>	<u5tek82bmlb.fsf@fidgit.hq.vtech>	<7v1x41g3c6.fsf@assigned-by-dhcp.cox.net> <7vfysg2wvo.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, davidk@lysator.liu.se,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 07:58:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFmkK-0006o1-21
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 07:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbVIOF5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 01:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbVIOF5K
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 01:57:10 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:28645 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1030335AbVIOF5J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 01:57:09 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j8F5uWJv024553
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Sep 2005 22:56:33 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfysg2wvo.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8587>

Junio C Hamano wrote:
> 
> I have done this and the first commit since 0.99.6 in the
> proposed updates branch contains the big rename.
> 

I noticed you also renamed git-ssh-{push,pull}.  These tools rely on 
having the same names on both sides, so you have introduced a major 
version skew problem.

	-hpa
