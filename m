From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: msysgit: merge, stat
Date: Mon, 13 Aug 2007 19:41:24 +0200
Message-ID: <23ED0751-B872-46E0-A6F5-2C0A72C4EA53@zib.de>
References: <2C573942-DD22-46EC-AE4A-1334450A7C4D@zib.de> <Pine.LNX.4.64.0708131743360.25989@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 13 19:41:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKdvC-0001T1-FL
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 19:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S973842AbXHMRkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 13:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S973726AbXHMRkr
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 13:40:47 -0400
Received: from mailer.zib.de ([130.73.108.11]:58106 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S973843AbXHMRkn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 13:40:43 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7DHeeN5015821;
	Mon, 13 Aug 2007 19:40:40 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7DHeek6001161
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 13 Aug 2007 19:40:40 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0708131743360.25989@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55774>


On Aug 13, 2007, at 6:45 PM, Johannes Schindelin wrote:

> Hi,
>
> On Sun, 12 Aug 2007, Steffen Prohaska wrote:
>
>> After a 'git merge' in msysgit some stat information of the index
>> doesn't match the working tree. Thus 'git diff' looks at files,
>> which it shouldn't look at. I need to do a
>> 'git update-index --refresh' before everything's in sync.
>>
>> Is this a know issue? Do other experience the same?
>
> Yes, it is.  The real issue is that the index is out of date, and  
> the full
> speed of git is not available until a refresh (which you can have  
> with a
> "git status", too).
>
> There are people who want to change the behaviour, and hide the  
> empty diff
> output, preventing the user from ever knowing why git is so slow.
>
> So just run a "git status" and continue.

Could we add 'git update-index --refresh' after a successful merge,
or would it slow things down. I'm not that much concerned about
the empty diff, but if I start gitk it also finds local changes,
which are not real, and this is always a bit distracting.

	Steffen
