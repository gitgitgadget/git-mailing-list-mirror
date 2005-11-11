From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Fri, 11 Nov 2005 13:18:21 -0800
Message-ID: <43750A9D.7070400@zytor.com>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>	<43737EC7.6090109@zytor.com> <7v4q6k1jp0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751203AbVKKVSe@vger.kernel.org Fri Nov 11 22:19:14 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751203AbVKKVSe@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EagIW-000584-TO
	for glk-linux-kernel-3@gmane.org; Fri, 11 Nov 2005 22:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVKKVSe (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 11 Nov 2005 16:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVKKVSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 16:18:33 -0500
Received: from terminus.zytor.com ([192.83.249.54]:4805 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751203AbVKKVSc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 16:18:32 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jABLIQiR021088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Nov 2005 13:18:26 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q6k1jp0.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11635>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> 
>>May I *STRONGLY* urge you to name that something different. 
>>"lost+found" is a name with special properties in Unix; for example, 
>>many backup solutions will ignore a directory with that name.
> 
> 
> Yeah, the original proposal (in TODO list) explicitly stated why
> I chose lost-found instead of lost+found back then, and somebody
> on the list (could have been Pasky but I may be mistaken) said
> not to worry.  In any case, if we go the route Daniel suggests,
> we would not be storing anything on the filesystem ourselves so
> this would be a non-issue.
> 

Just realized one more issue with this... a lot of non-Unix filesystems 
can't deal with files with a + sign.

	-hpa
