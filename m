From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Wed, 12 Oct 2005 14:09:18 -0700
Message-ID: <434D7B7E.6060403@zytor.com>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net> <20051007232909.GB8893@steel.home> <7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net> <20051008064555.GA3831@steel.home> <7vachks7aq.fsf@assigned-by-dhcp.cox.net> <20051008133032.GA32079@localhost> <7v64s7svya.fsf@assigned-by-dhcp.cox.net> <7vu0frpxs1.fsf@assigned-by-dhcp.cox.net> <87mzlgh8xa.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510110802470.14597@g5.osdl.org> <87ek6s0w34.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111121030.14597@g5.osdl.org> <87slv7zvqj.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111346220.14597@g5.osdl.org> <877jcjmdmq.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510120749230.14597@g5.osdl.org> <87vf02qy79.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510121355280.15297@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Eggert <eggert@CS.UCLA.EDU>, Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 23:13:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPnrN-0001Ku-KQ
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 23:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVJLVJ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 17:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVJLVJ5
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 17:09:57 -0400
Received: from terminus.zytor.com ([192.83.249.54]:32153 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964803AbVJLVJ4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 17:09:56 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9CL9LNl029556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Oct 2005 14:09:21 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510121355280.15297@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10049>

Linus Torvalds wrote:
> 
> Now, I believe patches can actually be that way - it's not at all 
> impossible to have a diff where the _filename_ is utf-8, but the content 
> of the patch itself is some byte-encoding like latin1. Or the other way 
> around.
> 

Or both.  Trivial example: a patch to change names in comments from ISO 
8859-1 to UTF-8.

	-hpa
