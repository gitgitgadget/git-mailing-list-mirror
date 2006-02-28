From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/3] apply --whitespace: configuration option.
Date: Tue, 28 Feb 2006 10:16:06 +0100
Message-ID: <440414D6.8050407@op5.se>
References: <20060225174047.0e9a6d29.akpm@osdl.org>	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>	<20060225210712.29b30f59.akpm@osdl.org>	<Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>	<20060226103604.2d97696c.akpm@osdl.org>	<Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>	<20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer>	<Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>	<20060227011832.78359f0a.akpm@osdl.org>	<7vhd6kxuea.fsf@assigned-by-dhcp.cox.net> <7vacccuvxz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 10:16:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE0y1-0002Et-3I
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 10:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWB1JQJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 04:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWB1JQJ
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 04:16:09 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:37304 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750822AbWB1JQH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 04:16:07 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id CD8E56BD15; Tue, 28 Feb 2006 10:16:06 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacccuvxz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16927>

Junio C Hamano wrote:
> The new configuration option apply.whitespace can take one of
> "warn", "error", "error-all", or "strip".  When git-apply is run
> to apply the patch to the index, they are used as the default
> value if there is no command line --whitespace option.
> 

I would think "warn-all" would be the logical thing, since "error" 
either breaks out early or prints all warnings before denying the patch 
anyway.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
