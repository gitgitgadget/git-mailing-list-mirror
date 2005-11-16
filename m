From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 3/3] git --help COMMAND brings up the git-COMMAND man-page.,
 take two
Date: Wed, 16 Nov 2005 07:56:43 +0100
Message-ID: <437AD82B.1050404@op5.se>
References: <20051116002318.A46C55BF97@nox.op5.se> <437AAB48.7090904@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 16 07:57:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcHDs-0007o8-1d
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 07:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbVKPG4p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 01:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVKPG4p
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 01:56:45 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:17096 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751184AbVKPG4o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 01:56:44 -0500
Received: from vrrx50sn1.teliamobile.net (192.71.148.196) by pne-smtpout1-sn2.hy.skanova.net (7.2.060.1)
        id 4378E953000820A6 for git@vger.kernel.org; Wed, 16 Nov 2005 07:56:44 +0100
Received: from [212.181.228.90] (host-n13-90.homerun.telia.com [212.181.228.90])
	by vrrx50sn1.teliamobile.net (8.11.6/8.11.6) with ESMTP id jAG6uhf26101
	for <git@vger.kernel.org>; Wed, 16 Nov 2005 07:56:43 +0100
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <437AAB48.7090904@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12006>

H. Peter Anvin wrote:
> Andreas Ericsson wrote:
>> +
>> +    execlp("man", "man", page, NULL);
>> +}
>> +
> 
> 
> The way this made it into the actual tree was to call /usr/bin/man, but 
> still using execlp().  This is clearly bogus.  There *ARE* good reasons 
> to use PATH resolutions for this, since man is one of the interactive 
> commands the user may want to wrapper.
> 

Everyone agrees. I just brained the original implementation.

> So please drop PATH_TO_MAN that made it into the repository and revert 
> to the original patch.
> 

PATH_TO_MAN *was* the original. This is the updated version. I think 
Junio imported the wrong one by mistake, cause I sent this one 
specifically to fix the first one.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
