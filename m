From: Andreas Ericsson <ae@op5.se>
Subject: Re: Possibility of a MinGW version?
Date: Sat, 24 Dec 2005 11:09:39 +0100
Message-ID: <43AD1E63.4040103@op5.se>
References: <006c01c60832$86f92620$6900a8c0@sps>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 24 11:09:54 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eq6LX-0001iW-SG
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 11:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbVLXKJm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 05:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422651AbVLXKJm
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 05:09:42 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:37329 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1422650AbVLXKJm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2005 05:09:42 -0500
Received: from [192.168.1.42] (217.210.107.34) by pne-smtpout1-sn2.hy.skanova.net (7.2.069.1)
        id 43AA7832000988AD; Sat, 24 Dec 2005 11:09:40 +0100
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Rob McDonald <robm@asdl.gatech.edu>
In-Reply-To: <006c01c60832$86f92620$6900a8c0@sps>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14014>

Rob McDonald wrote:
> 1.0 is out the door, with support (to some degree or another) for Cygwin,
> BSD, MacOS X, Solaris, and who knows what else, good job all.
> 
> What possibility is there of getting git (& assorted tools) to run natively
> on Windows (sacrilege I know) using MinGW?  What truly Unixy-only things
> does the code do?  Unfortunately, Windows is a reality for many of us.
> 
> I'd like to begin experimenting using git to track all of my data files
> acting as a synchronization mechanism.  Have all your files up-to-date
> everywhere, revision tracking, & redundancy too...  Dedicated Linux
> repository at home, dual boot laptop on the road, Windows machine at work,
> etc...
> 
> Thoughts?  Suggestions?
> 

The worst trouble you're likely to run into is all the hardcoded paths. 
They are everywhere and ofcourse use the / for path entity separation.

The fact that there are 39 bash'ish shell-scripts does little to help a 
native port, and although they can be fairly easily replaced by "real" 
programs it still means quite a bit of work with little real value for 
the unix-version, so I'm guessing you'll have to write those up for 
yourself.

Is there some reason you can't install Cygwin, which effectively 
overcomes both those problems?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
