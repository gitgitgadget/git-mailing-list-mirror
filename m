From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/3] git --help COMMAND brings up the git-COMMAND man-page.,
 take two
Date: Wed, 16 Nov 2005 13:53:35 -0800
Message-ID: <437BAA5F.5060608@zytor.com>
References: <20051116002318.A46C55BF97@nox.op5.se>	<437AAB48.7090904@zytor.com> <7vbr0law3z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 22:56:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcVEF-0002gJ-Ub
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 22:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030520AbVKPVx6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 16:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbVKPVx6
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 16:53:58 -0500
Received: from terminus.zytor.com ([192.83.249.54]:22196 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030521AbVKPVx5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 16:53:57 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAGLrdac010359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Nov 2005 13:53:39 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr0law3z.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12061>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>>The way this made it into the actual tree was to call /usr/bin/man, but 
>>still using execlp().  This is clearly bogus.  There *ARE* good reasons 
>>to use PATH resolutions for this, since man is one of the interactive 
>>commands the user may want to wrapper.
> 
> Oh, that was my call, so please do not blame Andreas.
> I just sent out a proposed patch to address all the points
> discussed on the list for the last several hours.
> 

FWIW, I rarely blame people for bad code; *everyone* does something 
stupid every now and then, and for most of us, far more often than that. 
  "This piece of code is stupid" != "the author of this piece of code is 
stupid", a distinction which unfortunately often gets lost.

I say "rarely", because there are of course a small number of people who 
*consistently* produce crap.  However, even they occationally produce 
something useful -- it's just not that often, and one has to carefully 
review it first.  With sufficient thrust pigs fly just fine[*], and 
heck, even RBJ even occationally says something correct.

	-hpa

[*] It is, however, not necessarily a good idea.  It can be dangerous 
for the people on the ground, and annoys the pig.
