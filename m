From: Andreas Ericsson <ae@op5.se>
Subject: Re: Following renames
Date: Mon, 27 Mar 2006 14:27:39 +0200
Message-ID: <4427DA3B.3070603@op5.se>
References: <20060326014946.GB18185@pasky.or.cz>	 <7virq1sywj.fsf@assigned-by-dhcp.cox.net> <e06fl8$p9f$1@sea.gmane.org>	 <Pine.LNX.4.64.0603260843250.15714@g5.osdl.org>	 <e06hts$1ne$1@sea.gmane.org>	 <Pine.LNX.4.64.0603260947100.15714@g5.osdl.org>	 <e5bfff550603261122m5e680c62ye1290f3e601e947e@mail.gmail.com>	 <Pine.LNX.4.64.0603261422280.15714@g5.osdl.org>	 <e5bfff550603262147t3aec8da6p6bf2a333e2d35f1d@mail.gmail.com>	 <Pine.LNX.4.64.0603270005330.15714@g5.osdl.org> <e5bfff550603270355s4b71c306hb4cb2b96eafd0f6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 27 14:28:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNqp3-0004lu-Py
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 14:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWC0M1m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 07:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWC0M1m
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 07:27:42 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:32686 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750973AbWC0M1l
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 07:27:41 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 97E316BD1A; Mon, 27 Mar 2006 14:27:39 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550603270355s4b71c306hb4cb2b96eafd0f6e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18083>

Marco Costalba wrote:
> On 3/27/06, Linus Torvalds <torvalds@osdl.org> wrote:
> 
>>In contrast, git-whatchanged will start outputting the recent changes
>>immediately.
>>
> 
> 
> To integrate git-whatchanged like functionality with filter on a
> specific code region, the Linus original request, I am wondering about
> something like this:
> 
> A new git-diff-tree option --range=a..b to delimit a region,
> identified by code lines bounduaries.
> 

Make it --line-range if you implement this. On a first glance I thought 
you meant --commit-range.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
