From: Andreas Ericsson <ae@op5.se>
Subject: Re: Why not clone to a remote directory over SSH
Date: Thu, 24 Nov 2005 00:15:02 +0100
Message-ID: <4384F7F6.10404@op5.se>
References: <20051123211601.GA2260@hpsvcnb.fc.hp.com> <20051123230838.GN3968@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 00:16:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef3pW-0002Fc-U0
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 00:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbVKWXPG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 18:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbVKWXPF
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 18:15:05 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:37779 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030493AbVKWXPE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 18:15:04 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 14D196BCBE; Thu, 24 Nov 2005 00:15:03 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051123230838.GN3968@reactrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12657>

Nick Hengeveld wrote:
> On Wed, Nov 23, 2005 at 02:16:01PM -0700, Carl Baldwin wrote:
> 
> 
>>It might be cool to enable cloning to a remote over ssh if the remote
>>doesn't yet exist.
> 
> 
> I would like to see the same for http.  There is limited support for
> managing a repository using http but without the ability to run tools
> like init-db/clone/update-server-info you still need shell access
> or some other workaround.  I think it would be useful to allow someone
> to create, manage, and share a repository without any special
> intelligence on the server side.
> 

You'll still need to install at least git-init-db and git-receive-pack 
(and git-merge, and...), even if they're run through commands from the 
web. That's pretty special intelligence.

You'd also have to add some logic to enter_repo() to make it find 
repositories without a HEAD correctly.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
