From: Andreas Ericsson <ae@op5.se>
Subject: Re: Clone a repository with only the objects needed for a single
 tag
Date: Wed, 02 Nov 2005 09:49:50 +0100
Message-ID: <43687DAE.2010604@op5.se>
References: <43681E47.4010203@ust.hk> <7vy847y1m2.fsf@assigned-by-dhcp.cox.net> <43687869.7060104@ust.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 02 09:51:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXEJf-0000gc-D4
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 09:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbVKBItw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 03:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbVKBItw
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 03:49:52 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:23424 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932662AbVKBItv
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 03:49:51 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id F34E46BD00
	for <git@vger.kernel.org>; Wed,  2 Nov 2005 09:49:50 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <43687869.7060104@ust.hk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11011>

Ben Lau wrote:
> Hi Junio,
> 
>  It works!  Thanks a lot.
> 
>  However, it has a problem when involves the gitk/git-log.


Both those programs use the history, which you don't have. With a 
shallow repository like this some commands just won't work. git-*log and 
gitk are among those.

> 
> git-log/gitk do not complains afterward, but it also make gitk shows 
> nothing during run. Any solution?
> 

* Get a second machine with more disk-space and run the history tools 
there. If you use it as mothership and push your commits to it you'll be 
able to track your changes from the laptop as well.

* Get a larger disk. They're not terribly expensive now adays.

* Check out one tag (i.e. release) more than you need. Then you'll get 
history back to that tag.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
