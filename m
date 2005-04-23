From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] #!/bin/sh --> #!/usr/bin/env bash
Date: Sat, 23 Apr 2005 16:16:13 +1000
Message-ID: <4269E82D.9010009@zytor.com>
References: <426734DE.3040606@timesys.com> <426736AF.7000900@timesys.com> <4267387A.6040602@timesys.com> <20050421102326.GA22541@xdt04.mpe-garching.mpg.de> <20050421143102.GA830@alc.bsd.st> <20050421194255.GA8479@alc.bsd.st> <4268A9C5.5090102@zytor.com> <4269B424.8010406@dwheeler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alecs King <alecsk@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 08:12:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPDsT-0002Fk-3P
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 08:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVDWGQl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 02:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVDWGQl
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 02:16:41 -0400
Received: from terminus.zytor.com ([209.128.68.124]:63621 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261282AbVDWGQj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 02:16:39 -0400
Received: from [172.24.2.78] ([150.203.247.9])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3N6GJY0032390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Apr 2005 23:16:25 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: dwheeler@dwheeler.com
In-Reply-To: <4269B424.8010406@dwheeler.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	MANY_EXCLAMATIONS autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David A. Wheeler wrote:
> 
> If # of execs is that critical, it probably should not be in
> bash anyway.  OpenBSD (at least 3.1)'s bash appears to be in
> /usr/local/bin/bash, NOT /bin/bash.
> I'd go with the /bin/env solution for now;
> it maximizes the "it just works" factor, and
> when it comes time for .in files much of the cogito code (at least)
> will probably be rewritten in Perl, and anything performance-sensitive
> will be in C.
> 

Makes sense.

	-hpa
