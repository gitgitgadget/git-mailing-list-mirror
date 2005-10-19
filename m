From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: The git protocol and DoS
Date: Wed, 19 Oct 2005 15:01:19 -0700
Message-ID: <4356C22F.2040304@zytor.com>
References: <4356A5C5.5080905@zytor.com>	<7vmzl544f3.fsf@assigned-by-dhcp.cox.net> <4356B2C7.601@zytor.com>	<Pine.LNX.4.64.0510191410570.3369@g5.osdl.org> <7voe5l2mvu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 00:04:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESM0E-00007e-Ci
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 00:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbVJSWBk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 18:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbVJSWBj
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 18:01:39 -0400
Received: from terminus.zytor.com ([192.83.249.54]:44265 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751521AbVJSWBj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 18:01:39 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9JM1OaT009882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Oct 2005 15:01:25 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe5l2mvu.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10316>

Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
>>But once you're talking to a git-aware 
>>SYN-flooder, I don't think a challenge-response makes it any better, since 
>>a git-aware SYN-flooder would just be written to give the right response.
> 
> I think Peter's point is that the one that can give the right
> response needs to read from the server to compute it, and at
> that point it is not a "SYN-flooder" anymore.
> 

Right.  It has been shown that requiring some effort on the part of the 
client before the server spends work on it can greatly reduce the 
capabilities of a limited-resource client to execute a DoS.

	-hpa
