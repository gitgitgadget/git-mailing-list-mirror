From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Sparse fixes for http-fetch
Date: Thu, 13 Oct 2005 10:51:29 -0700
Message-ID: <434E9EA1.3030002@zytor.com>
References: <20051013174203.GA6860@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 19:56:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQ7F8-0007dm-Dm
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 19:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVJMRvr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 13:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVJMRvr
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 13:51:47 -0400
Received: from terminus.zytor.com ([192.83.249.54]:38370 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932124AbVJMRvq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 13:51:46 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9DHpYkK031965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Oct 2005 10:51:35 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Peter Hagervall <hager@cs.umu.se>
In-Reply-To: <20051013174203.GA6860@peppar.cs.umu.se>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10085>

Peter Hagervall wrote:
> This patch cleans out all sparse warnings from http-fetch.c
> 
> I'm a bit uncomfortable with adding extra #ifdefs to avoid either
> 'mixing declaration with code' or 'unused variable' warnings, but I
> figured that since those functions are already littered with #ifdefs I
> might just get away with it. Comments?
> 

For the first, you can use extra brackets to create blocks in which 
declarations can happen; for the latter, you can (void)var; to specify 
that a certain variable may be legitimately unused under some circumstances.

	-hpa
