From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Does git belong in root's $PATH?
Date: Sat, 07 Jan 2006 19:00:23 -0800
Message-ID: <43C08047.6090701@zytor.com>
References: <Pine.LNX.4.64.0601070838470.6317@x2.ybpnyarg> <43C0025A.9080406@op5.se> <43C02725.2020702@zytor.com> <43C05ED5.1090603@op5.se> <43C05F4C.8050908@zytor.com> <dpppg4$qkd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 04:00:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvQnf-0004Io-Vo
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 04:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161154AbWAHDA3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 22:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161155AbWAHDA3
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 22:00:29 -0500
Received: from terminus.zytor.com ([192.83.249.54]:32717 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161154AbWAHDA3
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 22:00:29 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k0830N7V016449
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 7 Jan 2006 19:00:24 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <dpppg4$qkd$1@sea.gmane.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14307>

walt wrote:
> H. Peter Anvin wrote:
> 
>>/usr used to be what is now called /home.  What you're describing above
>>is the current usage.
> 
> History lessons are valuable for us youngsters ;o)  Can you give us a
> brief description of what motivated such a change?  (Just as important,
> of course, is whether the original motives have changed or disappeared.)
> 

This is the history as far as I understand it.  Keep in mind I was only 
8 years old in 1980, and I think I first learned about how Unix worked 
in 1985 or 1986, so not all of this is first-hand.

/usr was initially used for home directories (user directories.)  Both 
fore reasons as have been previously discussed (remember, most easy 
multi-user systems were a lot friendlier than one would expect today), 
and because the root disk often filled up, it became common for users to 
put binaries in /usr/bin, and often the sysadmin, too.

As the need for system security tightened, by the 80's this was a pretty 
unusable configuration.  Since home directories were specified in 
/etc/passwd, those could, and often were, located elsewhere -- much 
easier than trying to change the now-established conventions of /usr/bin 
et al.  A lot of systems in the 80's were massively multiuser anyway 
(workstations were coming in but were rare), and so you'd frequently see 
paths like /u2/h/hpa for example (my actual home directory location on 
our college server.)

The convention of using /home for home directories seems to have evolved 
out of necessity when networking came in use on a large scale (NFS, 
automounter, etc), probably in the late 80's-early 90's.  By the time 
Linux emerged in 1991 it was pretty well-established on smaller systems; 
larger systems still tended to use local conventions inherited from 
previous generation systems.

	-hpa
