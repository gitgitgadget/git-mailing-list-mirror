From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.org upgraded to cogito-0.10
Date: Mon, 09 May 2005 08:55:47 -0700
Message-ID: <427F8803.7030004@zytor.com>
References: <427F70F4.4030409@zytor.com> <427F828C.8070406@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Kay Sievers <kay.sievers@vrfy.org>
X-From: git-owner@vger.kernel.org Mon May 09 17:51:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVAV6-00008t-CW
	for gcvg-git@gmane.org; Mon, 09 May 2005 17:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVEIP4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 11:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVEIP4L
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 11:56:11 -0400
Received: from terminus.zytor.com ([209.128.68.124]:946 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261436AbVEIP4J
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 11:56:09 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j49FtrWi025136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 May 2005 08:55:54 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Steven Cole <elenstev@mesatop.com>
In-Reply-To: <427F828C.8070406@mesatop.com>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Steven Cole wrote:
> H. Peter Anvin wrote:
> 
>> I have installed cogito-0.10 on the kernel.org machines.
>>
>>     -hpa
>> -
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> Something seems to have broken recently with gitweb.cgi at
> http://www.kernel.org/git/.  No results from any repos.

Known issue.

> Unrelated, but the repo at .../sfrench/cifs-2.6.git gives a
> 403 Forbidden - Invalid project directory from the web interface.

That's because he has a .git directory inside another .git directory.

	-hpa

