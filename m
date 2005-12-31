From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Make GIT-VERSION-GEN tolerate missing git describe command
Date: Fri, 30 Dec 2005 16:15:30 -0800
Message-ID: <43B5CDA2.5050408@zytor.com>
References: <dp3mtp$rfm$1@sea.gmane.org> <dp41ve$v7r$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 31 01:16:33 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EsUQC-0002PP-3o
	for gcvg-git@gmane.org; Sat, 31 Dec 2005 01:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbVLaAPs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Dec 2005 19:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbVLaAPs
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Dec 2005 19:15:48 -0500
Received: from terminus.zytor.com ([192.83.249.54]:54754 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964976AbVLaAPr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Dec 2005 19:15:47 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBV0FfuX001792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Dec 2005 16:15:41 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: John Ellson <ellson@research.att.com>
In-Reply-To: <dp41ve$v7r$1@sea.gmane.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14121>

John Ellson wrote:
> John Ellson wrote:
> 
>> I think it is probably a bug that "git non_existent_command"
>> returns its error message to stdout without an error, where
>> "git-non_existent_command" behaves differently and does return an
>> error.
> 
> 
> BTW.  Its the old shell-script version of "git" that fails to return an 
> error on non_existent_commands.    The newer C version of "git" 
> correctly returns an error code.
> 
> The reason that this is a sufficiently serious problem to require a fix 
> is that the broken version of "git" is in the 
> git-core-0.99.9a-2.fc5.i386.rpm that is currently in Fedora Core Extras 
> development.
> 

It has been fixed.  What's broken is that Fedora Extras still contains 
0.99.9a which is totally ancient.

	-hpa
