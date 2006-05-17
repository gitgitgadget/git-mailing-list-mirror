From: Petr Vandrovec <petr@vmware.com>
Subject: Re: Fwd: [OT] Re: Git via a proxy server?
Date: Wed, 17 May 2006 12:54:06 +0200
Message-ID: <446B00CE.9000609@vmware.com>
References: <4469CF92.2010002@vmware.com> <20060517035639.40450.qmail@web32004.mail.mud.yahoo.com> <20060517083845.GC23642@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 12:54:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgJfV-0005aL-MS
	for gcvg-git@gmane.org; Wed, 17 May 2006 12:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWEQKyL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 06:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWEQKyL
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 06:54:11 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:31755 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751142AbWEQKyK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 06:54:10 -0400
Received: from mailhost1.vmware.com (mailhost1.vmware.com [10.16.12.135])
	by mailout1.vmware.com (Postfix) with ESMTP
	id B5B454747; Wed, 17 May 2006 03:52:00 -0700 (PDT)
Received: from pa-exch3.vmware.com (pa-exch3.vmware.com [10.16.15.61])
	by mailhost1.vmware.com (Postfix) with ESMTP id 4A6AC6FC330;
	Wed, 17 May 2006 03:54:09 -0700 (PDT)
Received: from [127.0.0.1] ([10.17.163.5]) by pa-exch3.vmware.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 17 May 2006 03:54:08 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: cs, en
To: Sam Song <samlinuxkernel@yahoo.com>
In-Reply-To: <20060517083845.GC23642@lug-owl.de>
X-OriginalArrivalTime: 17 May 2006 10:54:09.0247 (UTC) FILETIME=[39770EF0:01C679A0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20189>

Jan-Benedict Glaw wrote:
> On Tue, 2006-05-16 20:56:39 -0700, Sam Song <samlinuxkernel@yahoo.com> wrote:
> 
>>Petr Vandrovec <petr@vmware.com> wrote:
>>
>>>Best to test this is to start 'socket 192.168.40.99
>>>80' from command line and 
>>>then type these two lines above, plus one empty
>>>line.  You should get back '200 
>>>OK', empty line, and then you can start
>>>communicating using git protocol - if 
>>>you can do that...
>>
>>I cannot run "socket" and "CONNECT" on Fedora Core 3.
>>It simply told me that no such command. How could I 
>>do this task in my case?
> 
> 
> Well, install some package to have `socket' available? Debian calls
> the packet `socket', too, so I guess Fedora may have something
> similar.

Surprisingly they do not...  You should be able to replace 'socket' with 
'netcat' - and I believe that netcat/nc package is available for Fedora.  For 
this purpose they have same command line & behavior.
							Petr
