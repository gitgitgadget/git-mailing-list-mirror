From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git rebase chokes on directory -> symlink -> directory
Date: Fri, 11 May 2007 17:35:11 -0700
Message-ID: <46450BBF.5020900@zytor.com>
References: <463FCD7C.4020009@zytor.com> <20070508215009.GA2670@steel.home>	<46413565.3090503@zytor.com> <7vps569904.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 02:35:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmfZx-0003Bf-TA
	for gcvg-git@gmane.org; Sat, 12 May 2007 02:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbXELAfS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 20:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754530AbXELAfS
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 20:35:18 -0400
Received: from terminus.zytor.com ([192.83.249.54]:54822 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbXELAfR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 20:35:17 -0400
Received: from tazenda.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.8) with ESMTP id l4C0ZBn2021146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 May 2007 17:35:12 -0700
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
In-Reply-To: <7vps569904.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.95.0
X-Virus-Scanned: ClamAV 0.88.7/3227/Fri May 11 02:39:25 2007 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47002>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> Mine stops already at the directory -> symlink checkin (the above is the
>> symlink -> directory one), but your trick of using "git checkout" as a
>> trick to resolve things helped for both... eventually :-/
> 
> I've tried to redo your rebase using:
> 
> 	apply: do not get confused by symlinks in the middle
> 
> patch on top of 'master'.  It successfully run through the end.
> 
> So I think I can declare victory for now ;-).
> 

YAY!  Huge thanks!

	-hpa
