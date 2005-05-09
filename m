From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Use backticks instead of $(command) to maintain /bin/sh
 compatibility
Date: Mon, 09 May 2005 07:47:18 -0700
Message-ID: <427F77F6.1090308@zytor.com>
References: <20050507084549.GF23680@cip.informatik.uni-erlangen.de> <7v3bszbeoo.fsf@assigned-by-dhcp.cox.net> <20050507090543.GG23680@cip.informatik.uni-erlangen.de> <20050507172429.GJ3562@admingilde.org> <20050507231539.GB2497@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 17:01:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DV9Ue-0004bI-7i
	for gcvg-git@gmane.org; Mon, 09 May 2005 16:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVEIOvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 10:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVEIOvf
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 10:51:35 -0400
Received: from terminus.zytor.com ([209.128.68.124]:943 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261388AbVEIOvd
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 10:51:33 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j49ElP1e023326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 May 2005 07:47:26 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050507231539.GB2497@cip.informatik.uni-erlangen.de>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Thomas Glanzmann wrote:
> Hello Coworker,
> 
> 
>>huh? which broken shell does not understand $()?
> 
> 
> /bin/sh under Solaris 9 for example. That is where I hit it initial.
> 

Shoot Sun.

$(...) is in POSIX and has been for oh, what, 15 years now?

	-hpa
