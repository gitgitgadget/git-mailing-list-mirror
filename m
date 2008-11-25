From: Luis Gutierrez <luis.gutierrez@xmos.com>
Subject: Re: inted problems when upgrading to 1.6.0.4
Date: Tue, 25 Nov 2008 10:54:09 +0000
Message-ID: <492BD951.1010200@xmos.com>
References: <492BC56A.6040506@xmos.com>	 <1227608420.3222.2.camel@therock.nsw.bigpond.net.au>	 <492BCFA0.5030708@xmos.com> <1227610459.3222.4.camel@therock.nsw.bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Arafangion <thestar@fussycoder.id.au>
X-From: git-owner@vger.kernel.org Tue Nov 25 11:55:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4vZM-0006Mr-4G
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 11:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbYKYKxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 05:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbYKYKxo
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 05:53:44 -0500
Received: from smtp-out-50.livemail.co.uk ([213.171.216.50]:53083 "EHLO
	smtp-out-56.livemail.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752302AbYKYKxo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2008 05:53:44 -0500
Received: from [10.0.102.43] (unknown [195.26.247.140])
	by smtp-out-56.livemail.co.uk (Postfix) with ESMTP id A4B9026F6B1;
	Tue, 25 Nov 2008 10:53:42 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <1227610459.3222.4.camel@therock.nsw.bigpond.net.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101658>

Arafangion wrote:
> On Tue, 2008-11-25 at 10:12 +0000, Luis Gutierrez wrote:
>   
>> Arafangion wrote: 
>>     
>>> On Tue, 2008-11-25 at 09:29 +0000, Luis Gutierrez wrote:
>>> <snip>
>>>   
>>>       
>>>> All push/pull/clone operations were failing with the dreaded 'fatal: The 
>>>> remote end hung up unexpectedly'. After a few tests, this is what I found:
>>>>
>>>> - I can clone/pull/push if I do it through ssh (ie, git clone 
>>>> ssh://server/project)
>>>> - I can clone/pull/push if I start git daemon on the command line through
>>>> git daemon --syslog --verbose --export-all 
>>>> --base-path=/vol0/git/projects --verbose --reuseaddr
>>>>
>>>> But the way I had setup git, through xinetd is broken.
>>>>     
>>>>         
>>> I'm just guessing, as I'm too new to the git world to respond with more
>>> expertise, but I will suggest that perhaps your problem is that your
>>> $PATH is different with the xinitd configuration as contrasted with your
>>> ssh configuration, as the locations of the git binaries could be
>>> different.
>>>
>>>   
>>>       
>> I've tried that, they are the same:
>>
>> # which git
>> /usr/local/bin/git
>>     
>
> What about the other git-* commands?
>
>   
This is what I have now:
ls /usr/local/bin/git*
git  git-cvsserver  gitk  git-receive-pack  git-shell  
git-upload-archive  git-upload-pack
it seems.. a lot less than it used to be, but then again, perhaps this 
is why the git-* commands were deprecated?


-- 
* Luis Gutierrez | * XMOS Semiconductor <http://www.xmos.com>
Venturers House, King Street, Bristol BS1 4PB, UK
