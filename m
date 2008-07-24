From: Donald Brady <dbrady010@me.com>
Subject: Re: git newbie - cloning / check out help
Date: Thu, 24 Jul 2008 16:55:38 -0700
Message-ID: <7E28442B-13FE-41A3-A4A4-F46683495CDC@me.com>
References: <loom.20080724T211609-298@post.gmane.org>
 <20080724231531.GS32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jul 25 02:56:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMBc6-0006wX-3u
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 02:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719AbYGYAzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 20:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753792AbYGYAzy
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 20:55:54 -0400
Received: from asmtpout018.mac.com ([17.148.16.93]:36711 "EHLO
	asmtpout018.mac.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbYGYAzx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 20:55:53 -0400
X-Greylist: delayed 3614 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jul 2008 20:55:53 EDT
Received: from [17.151.80.147] by asmtp018.mac.com
 (Sun Java(tm) System Messaging Server 6.3-6.03 (built Mar 14 2008; 32bit))
 with ESMTPA id <0K4J003R4BSQKY90@asmtp018.mac.com> for git@vger.kernel.org;
 Thu, 24 Jul 2008 16:55:39 -0700 (PDT)
In-reply-to: <20080724231531.GS32184@machine.or.cz>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89991>

Hi Peter.

I got it working now thanks to your pointer.

Donald

On Jul 24, 2008, at 4:15 PM, Petr Baudis wrote:

>  Hi,
>
> On Thu, Jul 24, 2008 at 09:24:34PM +0000, Donald Brady wrote:
>> I am just ramping up on git and have the following scenario / issue:
>>
>>  I have a git repository on server A.
>>
>>  I clone it onto my machine B.
>>
>>  In my local copy/repository on machine B I clone a repository on  
>> some
>> third party server C.
>>
>>  I commit my changes into B and push them to A.
>>
>>  Now if I clone my repository from Server A onto my local machine
>> in a different location I see all the source as normal but only the  
>> top
>> level directory of C. Any source under that is not present.
>>
>> What is the magic git incantation to make sure that I check out
>> not only the code from my repository but  any repositories that
>> are cloned into it (recursive clone?)
>
>  we call this functionality "submodules" and the quickstart howto is:
>
> 	You have git repository on A
>
> 	You clone it onto your machine B
>
> 	git submodule add url directoryC
>
> 	You commit your changes into B and push them to A
>
> 	You do another clone of A and then within the clone
>
> 	git submodule update --init
>
> For further details, see git-submodule(1).
>
> -- 
> 				Petr "Pasky" Baudis
> As in certain cults it is possible to kill a process if you know
> its true name.  -- Ken Thompson and Dennis M. Ritchie
