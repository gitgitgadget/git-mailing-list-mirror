From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] #!/bin/sh --> #!/usr/bin/env bash
Date: Fri, 22 Apr 2005 17:37:41 +1000
Message-ID: <4268A9C5.5090102@zytor.com>
References: <426734DE.3040606@timesys.com> <426736AF.7000900@timesys.com> <4267387A.6040602@timesys.com> <20050421102326.GA22541@xdt04.mpe-garching.mpg.de> <20050421143102.GA830@alc.bsd.st> <20050421194255.GA8479@alc.bsd.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 09:34:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOsfV-00071p-4I
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 09:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVDVHiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 03:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVDVHiE
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 03:38:04 -0400
Received: from terminus.zytor.com ([209.128.68.124]:65492 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262012AbVDVHhz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 03:37:55 -0400
Received: from [172.24.2.78] ([150.203.247.9])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3M7bisM013728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Apr 2005 00:37:49 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Alecs King <alecsk@gmail.com>
In-Reply-To: <20050421194255.GA8479@alc.bsd.st>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	MANY_EXCLAMATIONS autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Alecs King wrote:
> 
> And as for bash, only gitdiff-do and gitlog.sh 'explicitly' use bash
> instead of /bin/sh.  On most Linux distros, /bin/sh is just a symbolic
> link to bash.  But not on some others.  I found gitlsobj.sh could not
> work using a plain /bin/sh on fbsd.  To make life easier, i think it
> might be better if we all explicitly use bash for all shell scripts.
> 

How about #!/bin/bash (build from .in files if you feel it necessary to 
support systems which don't have bash in /bin) instead of doubling the 
number of execs?

	-hpa
