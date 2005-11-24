From: Andreas Ericsson <ae@op5.se>
Subject: Re: Why not clone to a remote directory over SSH
Date: Thu, 24 Nov 2005 09:14:01 +0100
Message-ID: <43857649.2080502@op5.se>
References: <20051123211601.GA2260@hpsvcnb.fc.hp.com> <7vd5kr3pz1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0511240038001.11106@wbgn013.biozentrum.uni-wuerzburg.de> <20051124001955.GP3968@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Carl Baldwin <cnb@fc.hp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 09:15:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfCF6-0005ry-04
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 09:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030586AbVKXIOE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 03:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030620AbVKXIOE
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 03:14:04 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:44948 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030619AbVKXIOD
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 03:14:03 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id D43446BCBE; Thu, 24 Nov 2005 09:14:01 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051124001955.GP3968@reactrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12692>

Nick Hengeveld wrote:
> On Thu, Nov 24, 2005 at 12:41:56AM +0100, Johannes Schindelin wrote:
> 
> 
>>Obviously, this only works if the other side can connect to this side via 
>>ssh. Hmm. Firewalls? Disabled sshd? `hostname` not reliably returning a 
>>valid address for the remote side?
> 
> 
> If sshd is running locally, you can forward a port back to yourself and
> have the remote clone localhost:`pwd`.  Assuming there's a way to clone
> using a nonstandard port.
> 

ssh://host.xz:port/path/to/repo.git

should work. If it doesn't I'll fix it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
