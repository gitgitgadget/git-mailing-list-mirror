From: Mark Levedahl <mlevedahl@verizon.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 12:28:22 -0500
Message-ID: <45D346B6.5020802@verizon.net>
References: <45CFA30C.6030202@verizon.net>
 <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
 <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
 <7v8xf1uxme.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702132127330.3604@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702141208020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D31C0E.2040206@verizon.net>
 <Pine.LNX.4.63.0702141653440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mdl123@verizon.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 14 18:28:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNve-0003gt-HK
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbXBNR2W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 12:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbXBNR2W
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:28:22 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:43675 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbXBNR2W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:28:22 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDG00CJQR74WL13@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 14 Feb 2007 11:28:21 -0600 (CST)
In-reply-to: <Pine.LNX.4.63.0702141653440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39697>

Johannes Schindelin wrote:
> Hi,
>
> On Wed, 14 Feb 2007, Mark Levedahl wrote:
>   
> This sounds regretfully complex. Somebody (you?) mentioned that cvsnt does 
> a kick-ass job here. Does cvsnt need strategies? I don't think so. Neither 
> do we. Someone who cares enough should just rip^H^H^Hlook at cvsnt's text 
> detection.
>
> Ciao,
> Dscho
>   
I agree that is complex, I started thinking of PAM when I wrote that, 
leading to, "this aint gonna work." But in the modern day let's all feel 
good spirit of "there are no stupid ideas, just some are better" I threw 
it out anyway.

As to cvsnt, my actual feeling is I'd like to kick it in the ass, it has 
destroyed too many files for me over the years, binary and text, so I 
don't think its strategies are very good. That is why I'm kicking these 
ideas around, if I thought I knew the "right" way I would have written 
it already.

Mark
