From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Cleaned up git-daemon virtual hosting support.
Date: Tue, 26 Sep 2006 09:47:03 +0200
Message-ID: <4518DAF7.4050304@op5.se>
References: <E1GRhhk-0004O6-GP@jdl.com> <7vd59jw9lb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jon Loeliger <jdl@jdl.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 09:47:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS7et-0000jJ-47
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 09:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWIZHrL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 03:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWIZHrK
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 03:47:10 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:41189 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750748AbWIZHrH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 03:47:07 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 76F506BD30; Tue, 26 Sep 2006 09:47:06 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 6780C6BD2A; Tue, 26 Sep 2006 09:47:03 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd59jw9lb.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27781>

Junio C Hamano wrote:
>> Added --host=host_or_ipaddr option suport.
> 
> I wonder if --listen= might be more appropriate name:
> 
>         "Listen a.b.c.d:port" (Apache),
>         "ListenAddress" (ssh daemon).
>         "--listen-host=" (svnserve).
> 
> I wanted to find an example or two who uses "bind" but I think
> listen is more popular.
> 

Apache has both Bind and Listen (at least 1.3 series). I've never 
understood the difference between the two, if there is one.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
