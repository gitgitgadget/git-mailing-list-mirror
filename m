From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] minor Makefile and local-pull.c edits for Darwin
Date: Tue, 10 May 2005 14:12:00 -0700
Message-ID: <428123A0.3070000@zytor.com>
References: <20050510021105.53984.qmail@web41213.mail.yahoo.com>	<428038D0.5000706@zytor.com> <7vpsvzpolp.fsf@assigned-by-dhcp.cox.net>	<4280C883.6080209@zytor.com> <4280CAC6.4000805@zytor.com> <7vekceyeo9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Allen <mrallen1@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 23:13:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVc24-0005pQ-I6
	for gcvg-git@gmane.org; Tue, 10 May 2005 23:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVEJVSz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 17:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVEJVPU
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 17:15:20 -0400
Received: from terminus.zytor.com ([209.128.68.124]:25988 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261814AbVEJVMX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 17:12:23 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4ALC6Fs026796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 May 2005 14:12:06 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vekceyeo9.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.0 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
>>>>>>"HPA" == H Peter Anvin <hpa@zytor.com> writes:
> 
> 
> HPA> That being said, there are also a whole bunch of assumptions that any
> HPA> object can be memory-mapped *plus* fit uncompressed in
> HPA> memory... that's obviously not going to be the case for large files.
> 
> HPA> On the other hand, one has to start cleaning up somewhere...
> 
> I agree to that, but on the other hand one also has to know
> where to stop.  The primary purpose of GIT being to manage the
> source files for the Linux kernel project, not worrying about
> _huge_ files that would cause mmap+uncompressed or st.st_size
> not fitting in unsigned long may just be fine.
> 

Using the correct data types is a good start, though.

	-hpa

