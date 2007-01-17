From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Replace "echo -n" with printf in shell scripts.
Date: Wed, 17 Jan 2007 13:00:31 -0500
Message-ID: <F850C6F1-EFDC-4D37-90B4-27D8982BA086@silverinsanity.com>
References: <17437.1168911089@lotus.CS.Berkeley.EDU> <7v1wlv1yeh.fsf@assigned-by-dhcp.cox.net> <200701171629.l0HGTCE3019292@laptop13.inf.utfsm.cl> <7vk5zlsglk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 19:01:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7F5g-0002hi-NN
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 19:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbXAQSAi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 13:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbXAQSAi
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 13:00:38 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:49160 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526AbXAQSAh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 13:00:37 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 8F5741FFC02B;
	Wed, 17 Jan 2007 18:00:35 +0000 (UTC)
In-Reply-To: <7vk5zlsglk.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37020>


On Jan 17, 2007, at 12:33 PM, Junio C Hamano wrote:

> The problematic are less common ones, ranging from (not so less
> common) OSX, Solaris to (much less common) AIX that some people
> seem to run git on (or at least compile git for).

At least as far a OS X goes, it's installed on my machine (10.4.8)  
as /usr/bin/printf.  I don't know if it's part of the Xcode packages,  
the "BSD Subsystem", or the core OS but I have a hard time imagining  
someone who didn't have them all installed using GIT.

Also, it's man page identifies itself as
"PRINTF(1)                 BSD General Commands Manual                 
PRINTF(1)"
so most, if not all, flavors of BSD and BSD-like should be alright.

~~ Brian
