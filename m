From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Building git on NetBSD
Date: Sat, 12 Nov 2005 16:32:05 +0100
Message-ID: <43760AF5.1010704@op5.se>
References: <Pine.LNX.4.64.0511120649430.2695@x2.ybpnyarg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 16:32:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaxMZ-0000Of-Vb
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 16:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVKLPcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 10:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbVKLPcH
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 10:32:07 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:42934 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932394AbVKLPcG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 10:32:06 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 7A5EE6BD02; Sat, 12 Nov 2005 16:32:05 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <Pine.LNX.4.64.0511120649430.2695@x2.ybpnyarg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11691>

walt wrote:
> 
> I'm no software developer so I'm not sure about the syntax of the -rpath
> flag.  It does what I wanted, but it results in lots of warnings about
> not being used because no linking is taking place.  Should this maybe
> go in LDFLAGS instead of CFLAGS?  Dunno.
> 

Yes it should. Currently the git makefile doesn't distinguish between 
CFLAGS and LDFLAGS which results in a fair few warnings.

> Oh, one person was concerned about the cogito scripts running on the
> NetBSD version of sh, which isn't bash.  So far I've tried cg-clone,
> cg-update, and gitk, and all worked just like on linux.  Any chance
> that some of the other scripts may not work as well on a non-bash sh?
> 

gitk is in tcl so I'd be surprised if that didn't work.

I don't think there's been a whole lot of testing for other shells but 
the friendly folks on this list usually takes care of fixing such things 
fairly quickly so long as someone tells them where to look or, 
preferrably, sends a patch that does the trick.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
