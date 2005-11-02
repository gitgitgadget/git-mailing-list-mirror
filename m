From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 4/4] git-daemon support for user-relative paths.
Date: Wed, 02 Nov 2005 10:39:15 +0100
Message-ID: <43688943.4010002@op5.se>
References: <20051101225921.3E7455BF74@nox.op5.se>	<7vvezb6h4c.fsf@assigned-by-dhcp.cox.net> <4368760E.6030208@op5.se> <7v1x1zv1ln.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 02 10:40:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXF5T-000757-IC
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 10:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbVKBJjQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 04:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbVKBJjQ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 04:39:16 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:9090 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932684AbVKBJjQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 04:39:16 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 4F9B26BD00
	for <git@vger.kernel.org>; Wed,  2 Nov 2005 10:39:15 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7v1x1zv1ln.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11018>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>Junio C Hamano wrote:
>>
>>>>-static int log_syslog;
>>>>+static int log_syslog = 0;
>>>
>>>I'd drop this.
>>
>>No can do. It has to be set either here or down in main. It's nice to 
>>have the default in the declaration.
> 
> 
> Isn't "static int log_syslog" in BSS to be initialized to zero anyway?
> 

I would have thought so, but it wasn't when I tested it. This could be a 
compiler-bug in my end, I suppose, but spelling it out enhances 
readability and leaves no room for doubt which is always nice.

>>
>>Ok. I'll take that to mean "hold off on the --server-root and --userdir 
>>patch for a while" then.
> 
> 
> I do not mind keeping it in the proposed updates branch for
> people to see and experiment with, but not in the master branch,
> at least for now.
> 

I'll cook it up then.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
