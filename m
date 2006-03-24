From: Andreas Ericsson <ae@op5.se>
Subject: Re: Cloning from sites with 404 overridden
Date: Fri, 24 Mar 2006 19:40:32 +0100
Message-ID: <44243D20.9060309@op5.se>
References: <20060322025921.1722.qmail@science.horizon.com> <442152E0.4020604@op5.se> <slrne28b3a.cp6.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 19:40:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMrDB-0005EE-WC
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 19:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbWCXSkf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 13:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWCXSkf
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 13:40:35 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:3304 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932551AbWCXSke (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 13:40:34 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 766666BD46; Fri, 24 Mar 2006 19:40:32 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrne28b3a.cp6.mdw@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17935>

Mark Wooding wrote:
> Andreas Ericsson <ae@op5.se> wrote:
> 
> 
>>>I'm not sure what the best "object that's not supposed to be there" is.
>>
>>.git/objects/00/hoping-for-a-404-or-webadmin-should-fix
> 
> 
> If .git/objects/00/00000000000000000000000000000000000000 exists, the
> repository has big problems already.
> 

Indeed. I'm off sobriety again, it being friday and all, but I'm 
assuming there are more than 18 zeroes there, yes? The "feature" of the 
above line is that it will fit in any buffer that already exists, and 
will match any third argument to send(2) that already exists.


> (Aside: `C-u 38 0' doesn't work because Emacs hears `C-u 380' and waits
> for a key.  `M-: (insert-char ?0 38) RET' does the right thing, but is
> ugly.  Any better suggestions?)
> 

This I happily don't understand at all. I'm also happy ignorant of what 
it has to do with the issue at hand.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
