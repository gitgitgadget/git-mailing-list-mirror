From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Trying to use AUTHOR_DATE
Date: Fri, 29 Apr 2005 20:49:53 -0700
Message-ID: <42730061.5010106@zytor.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Edgar Toernig <froese@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 05:46:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRivd-0008MA-Ki
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 05:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVD3Dvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 23:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbVD3Dvv
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 23:51:51 -0400
Received: from terminus.zytor.com ([209.128.68.124]:13762 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262498AbVD3Dvt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 23:51:49 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3U3nrXq019937
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Apr 2005 20:49:54 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=ham 
	version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Luck, Tony wrote:
>>Another dependency :-(   I can live without http-pull but not
>>without commit-tree.
> 
> Yes, the extra dependency sucks ... libcurl is missing from one of
> the systems that I'd like to use GIT on ... so I'd prefer a solution
> that doesn't involve libcurl.

...

> I'd much rather see your version fixed up to preserve the timezone
> than have the libcurl dependency.

For gawd's sake people, just grab a copy of the working code in libcurl, 
and turn it into a standalone .c file.  It'll even let you merge in 
future fixes, and you could even use autoconf to use libcurl or the 
standalone code depending on what's available.

	-hpa
