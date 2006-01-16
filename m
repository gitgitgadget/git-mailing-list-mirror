From: Andreas Ericsson <ae@op5.se>
Subject: Re: dangling commits
Date: Mon, 16 Jan 2006 11:28:13 +0100
Message-ID: <43CB753D.2030706@op5.se>
References: <7vslrp2nw0.fsf@assigned-by-dhcp.cox.net> <20060115221108.3ED2E352659@atlas.denx.de> <20060116085238.GA3768@fiberbit.xs4all.nl> <7vr778wmj3.fsf@assigned-by-dhcp.cox.net> <20060116101722.GB5196@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 11:28:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyRb3-00083c-C9
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 11:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWAPK2Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 05:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWAPK2Q
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 05:28:16 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:14275 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932320AbWAPK2P
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 05:28:15 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id AC2D76BCBE; Mon, 16 Jan 2006 11:28:13 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Marco Roeland <marco.roeland@xs4all.nl>
In-Reply-To: <20060116101722.GB5196@fiberbit.xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14738>

Marco Roeland wrote:
> On Monday January 16th Junio C Hamano wrote:
> 
> 
>>Even when you use git native protocol, the objects the initial
>>clone gives you are kept packed, so when I rewind and rebuild
>>"pu" to make some of these objects orphaned, they will stay in
>>the pack the initial clone gave you.  Unpack+repack is needed to
>>get rid of them.
> 
> 
> Thanks very much for explaining. It makes sense now.
> 
> Does it bring many advantages for you to keep rebasing "pu"?


Since "pu" = "proposed updates" it only makes sense to keep it on top of 
the current master, otherwise the effort required for anyone to test it 
in conjunction with the latest master branch would simply be too great.


> I started
> out following that branch long ago (well in git reckoning anyway) but
> got very scared each time I got a bunch of "errors" on that one.
> I since removed it from the "Pull" list, but understand that "+pu"
> should do the trick. I'll retry using it one of these days.


It does. I also remember seeing lots of errors on that one when I first 
started with git (around 0.99b), but that was fixed quite some time ago.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
