From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: /bin/sh portability question
Date: Fri, 23 Sep 2005 13:00:45 -0700
Message-ID: <43345EED.5060706@zytor.com>
References: <20050923075058.GA25473@bohr.gbar.dtu.dk> <43345C17.7060402@zytor.com> <20050923195706.GV27375@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 22:03:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EItjb-0001dv-3e
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 22:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVIWUBR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 16:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVIWUBR
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 16:01:17 -0400
Received: from terminus.zytor.com ([209.128.68.124]:40675 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751199AbVIWUBQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 16:01:16 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j8NK0nIC026319
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 23 Sep 2005 13:00:50 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20050923195706.GV27375@ca-server1.us.oracle.com>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9200>

Joel Becker wrote:
> On Fri, Sep 23, 2005 at 12:48:39PM -0700, H. Peter Anvin wrote:
> 
>>Peter Eriksen wrote:
>>
>>>     path=$(dirname $0)
>>>...
>>>     ./git.sh: syntax error at line 4: `path=$' unexpected
>>
>>I think $(foo) is required by POSIX.
> 
> 
> 	I believe that Solaris and others (AIX IIRC) have /bin/sh linked
> to /bin/ksh, and it behaves as the POSIX shell when run as /bin/ksh, but
> behaves as a much more true-to-bourne shell when run as /bin/sh.
> 

But "sh" is required to be the POSIX shell (XSH page 850.)

Thus, they might have some braindamage where /usr/bin/sh is the POSIX 
shell and /bin/sh is a braindead shell.  Sigh.

	-hpa
