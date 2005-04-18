From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Yet another base64 patch
Date: Mon, 18 Apr 2005 16:28:24 +1000
Message-ID: <42635388.90207@zytor.com>
References: <425DEF64.60108@zytor.com> <20050415165532.05ed5dc4.paul@permanentmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 08:24:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNPga-00087z-Ev
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 08:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVDRG2j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 02:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVDRG2j
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 02:28:39 -0400
Received: from terminus.zytor.com ([209.128.68.124]:32397 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261695AbVDRG2h
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 02:28:37 -0400
Received: from [192.168.1.101] ([150.203.164.151])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3I6SUfB008005
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 17 Apr 2005 23:28:33 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Paul Dickson <paul@permanentmail.com>
In-Reply-To: <20050415165532.05ed5dc4.paul@permanentmail.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Dickson wrote:
> 
> Since 160-bits does not go into base64 evenly anyways, what happens if
> you use 2^10 instead of 2^12 for the subdir names?  That will be 1/4 the
> directories of the base64 given above.
> 

I was going to try one-character subdirs, so 2^6, but I haven't had a 
chance to do that since I'm at LCA.

Anyway, I'm starting to suspect it's too late to change the format, 
especially since Linus seems highly disinclined.

	-hpa
