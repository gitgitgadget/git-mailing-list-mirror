From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Fri, 23 Sep 2005 18:52:56 -0700
Message-ID: <4334B178.4060408@zytor.com>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 24 03:54:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIzEB-0006wv-UH
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 03:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbVIXBxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 21:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbVIXBxN
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 21:53:13 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:18626 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1751089AbVIXBxN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 21:53:13 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j8O1qvJv010671
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 23 Sep 2005 18:52:59 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050924011833.GJ10255@pasky.or.cz>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9222>

Petr Baudis wrote:
> 
> It takes loooong time, unfortunately - scp -r takes its time itself on
> many small files, and then we have to make a separate call to
> git-ssh-fetch for each tag. Isn't that braindamaged... :/
> 

Perhaps git-ssh-fetch should be fixed?  :)

	-hpa
