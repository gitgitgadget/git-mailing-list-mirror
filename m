From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 3/3] git --help COMMAND brings up the git-COMMAND man-page.,
 take two
Date: Thu, 17 Nov 2005 00:16:38 +0100
Message-ID: <437BBDD6.40809@op5.se>
References: <20051116002318.A46C55BF97@nox.op5.se>	<437AAB48.7090904@zytor.com> <7vbr0law3z.fsf@assigned-by-dhcp.cox.net> <437BAA5F.5060608@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 00:19:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcWWB-0006LF-UW
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 00:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbVKPXQl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 18:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbVKPXQk
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 18:16:40 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:55506 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030564AbVKPXQk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 18:16:40 -0500
Received: from [82.182.116.45] (1-2-9-7b.gkp.gbg.bostream.se [82.182.116.45])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 07CE96BCBE; Thu, 17 Nov 2005 00:16:39 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <437BAA5F.5060608@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12066>

H. Peter Anvin wrote:
> Junio C Hamano wrote:
> 
>> "H. Peter Anvin" <hpa@zytor.com> writes:
>>
>>> The way this made it into the actual tree was to call /usr/bin/man, 
>>> but still using execlp().  This is clearly bogus.  There *ARE* good 
>>> reasons to use PATH resolutions for this, since man is one of the 
>>> interactive commands the user may want to wrapper.
>>
>>
>> Oh, that was my call, so please do not blame Andreas.
>> I just sent out a proposed patch to address all the points
>> discussed on the list for the last several hours.
>>
> 
> FWIW, I rarely blame people for bad code; *everyone* does something 
> stupid every now and then, and for most of us, far more often than that. 
>  "This piece of code is stupid" != "the author of this piece of code is 
> stupid", a distinction which unfortunately often gets lost.
> 

True, but it's possible to have a 180 iq and still know nothing about 
programming. Anyhow, I sent the first patch too, so please blame me if 
anyone. If I was hoping to be admired I'd go play video-games with my 6 
year old cousin.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
