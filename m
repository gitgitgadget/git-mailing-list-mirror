From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Thu, 10 Nov 2005 09:09:27 -0800
Message-ID: <43737EC7.6090109@zytor.com>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 18:12:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaFvk-000071-5m
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 18:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVKJRJk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 12:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVKJRJk
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 12:09:40 -0500
Received: from terminus.zytor.com ([192.83.249.54]:31879 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751057AbVKJRJj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 12:09:39 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAAH9RWo007486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Nov 2005 09:09:29 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11491>

Junio C Hamano wrote:
> 
>    - Add git-lost+found.  Currently the implementation stores
>      found refs under .git/lost+found/{commit,other}
>      directories, but writing out their object names to the
>      standard output and let the users decide what to do with
>      them was suggested on the list by Daniel, which makes sense
>      as well.  There are pros and cons so until we know if it is
>      useful and if so in what form, it will not come out of "pu"
>      branch.
> 

May I *STRONGLY* urge you to name that something different. 
"lost+found" is a name with special properties in Unix; for example, 
many backup solutions will ignore a directory with that name.

	-hpa
