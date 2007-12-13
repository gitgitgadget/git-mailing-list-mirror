From: Wink Saville <wink@saville.com>
Subject: Re: [egit] How-to use egit
Date: Thu, 13 Dec 2007 14:35:30 -0800
Message-ID: <4761B3B2.4040807@saville.com>
References: <476032A2.9010308@saville.com> <20071213024735.GB7492@fawkes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 23:36:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2wfg-00084r-Jy
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 23:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755761AbXLMWff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 17:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbXLMWff
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 17:35:35 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:16493 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757605AbXLMWfe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 17:35:34 -0500
Received: by rv-out-0910.google.com with SMTP id k20so707607rvb.1
        for <git@vger.kernel.org>; Thu, 13 Dec 2007 14:35:32 -0800 (PST)
Received: by 10.140.185.19 with SMTP id i19mr1457169rvf.296.1197585332609;
        Thu, 13 Dec 2007 14:35:32 -0800 (PST)
Received: from ?192.168.0.133? ( [70.91.206.233])
        by mx.google.com with ESMTPS id c3sm3807842rvf.2007.12.13.14.35.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Dec 2007 14:35:32 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20071213024735.GB7492@fawkes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68198>

Jing Xue wrote:
> On Wed, Dec 12, 2007 at 11:12:34AM -0800, Wink Saville wrote:
>   
>> Robin et. al,
>>
>>
>> I cloned egit from git://repo.or.cz/egit and imported it into my workspace
>> following the instructions in INSTALL I did successfully compile although
>> there were 1115 warnings but no compilation errors.
>>
>> I then exported to a archive org.spearce.egit.jar and then copied this file
>> to /usr/eclipse/plugin/ I then restarted Eclipse. But I don't see any 
>> evidence
>>     
>
> I have five jars:
>
> /opt/eclipse/plugins$ ll org.spearce*
> -rw-r----- 1 jingxue jingxue 2.5K 2007-12-01 20:45 org.spearce.egit_0.3.0.200712020145.jar
> -rw-r----- 1 jingxue jingxue  70K 2007-12-01 20:45 org.spearce.egit.core_0.3.0.200712020145.jar
> -rw-r----- 1 jingxue jingxue  14K 2007-12-01 20:45 org.spearce.egit.core.test_0.3.0.200712020145.jar
> -rw-r----- 1 jingxue jingxue 107K 2007-12-01 20:45 org.spearce.egit.ui_0.3.0.200712020145.jar
> -rw-r----- 1 jingxue jingxue 223K 2007-12-01 20:45 org.spearce.jgit_0.3.0.200712020145.jar
>
> Did you select all the org.spearce projects before exporting?
>
>   
Yes, I selected them all and a single jar was created which
I put in /usr/eclipse/plughins, which apparently was a mistake.
I've now unzipped the jar and placed the 5 jars in the plugin directory:

wink@ic2d1:$ pwd
/usr/eclipse/plugins
wink@ic2d1:$ ls -l *spearce*
-rw-r--r-- 1 root root   2506 2007-12-13 13:54 
org.spearce.egit_0.3.0.200712121008.jar
-rw-r--r-- 1 root root  71396 2007-12-13 13:54 
org.spearce.egit.core_0.3.0.200712121008.jar
-rw-r--r-- 1 root root  13899 2007-12-13 13:54 
org.spearce.egit.core.test_0.3.0.200712121008.jar
-rw-r--r-- 1 root root 108661 2007-12-13 13:54 
org.spearce.egit.ui_0.3.0.200712121008.jar
-rw-r--r-- 1 root root 227877 2007-12-13 13:54 
org.spearce.jgit_0.3.0.200712121008.jar

I then started eclipse and now I see: Window/Preferences/Team/Git
When I select "Git" in the above, I see "Hi, I'm an empty preference page."

Now what; currently I have my entire workspace in git:

wink@ic2d1:$ ls -al
total 36
drwxr-xr-x  9 wink wink 4096 2007-12-12 14:54 .
drwxr-xr-x 69 wink wink 4096 2007-12-13 14:22 ..
drwxr-xr-x  9 wink wink 4096 2007-12-12 15:09 android
drwxr-xr-x  3 wink wink 4096 2007-12-10 21:58 com
drwxr-xr-x  8 wink wink 4096 2007-12-13 14:21 .git
drwxr-xr-x  3 wink wink 4096 2007-12-12 10:45 .metadata
drwxr-xr-x  4 wink wink 4096 2007-12-10 21:58 test0
drwxr-xr-x  2 wink wink 4096 2007-12-10 21:58 test1
drwxr-xr-x  5 wink wink 4096 2007-12-13 14:22 testStdJavaDebug

But how do I tell the plugin where my repo is?
I also tried making a git repo in testStdJavaDebug:

wink@ic2d1:$ ls -al
total 28
drwxr-xr-x 5 wink wink 4096 2007-12-13 14:22 .
drwxr-xr-x 9 wink wink 4096 2007-12-12 14:54 ..
drwxr-xr-x 3 wink wink 4096 2007-12-10 22:03 bin
-rw-r--r-- 1 wink wink  226 2007-12-10 21:58 .classpath
drwxr-xr-x 8 wink wink 4096 2007-12-13 14:22 .git
-rw-r--r-- 1 wink wink  375 2007-12-10 21:58 .project
drwxr-xr-x 3 wink wink 4096 2007-12-10 21:58 src

But again, I don't see any new menu items that
would allow me to look at history or make commits.
Is there more I need to to install the plugin, or
maybe I just need a little guidance on how to use it.

Thanks,

Wink
