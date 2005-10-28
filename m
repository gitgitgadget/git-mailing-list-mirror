From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal
 bars
Date: Thu, 27 Oct 2005 18:13:43 -0700
Message-ID: <43617B47.3070008@zytor.com>
References: <20051027203945.GC1622@pe.Belkin> <7vfyqm1uvx.fsf@assigned-by-dhcp.cox.net> <20051027234813.GA512@pe.Belkin> <Pine.LNX.4.64.0510271709120.4664@g5.osdl.org> <20051028005029.GA2654@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 03:15:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVIpD-0003Do-Kx
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 03:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbVJ1BOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 21:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbVJ1BOR
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 21:14:17 -0400
Received: from terminus.zytor.com ([192.83.249.54]:64149 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965038AbVJ1BOQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 21:14:16 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9S1DsTB011934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 27 Oct 2005 18:13:55 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Chris Shoemaker <c.shoemaker@cox.net>
In-Reply-To: <20051028005029.GA2654@pe.Belkin>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10734>

Chris Shoemaker wrote:
> 
> Ok, but that cache would live inside GIT_DIR an be shared with gitk,
> right?
> 

That would be bad.  Don't assume that the person running gitweb (or 
gitk, for that matter) has write permission.

	-hpa
