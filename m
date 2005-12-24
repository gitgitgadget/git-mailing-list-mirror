From: Andreas Ericsson <ae@op5.se>
Subject: Re: Possibility of a MinGW version?
Date: Sat, 24 Dec 2005 11:24:23 +0100
Message-ID: <43AD21D7.5060306@op5.se>
References: <006c01c60832$86f92620$6900a8c0@sps> <43AD1E63.4040103@op5.se> <20051224101849.GY1279MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rob McDonald <robm@asdl.gatech.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 24 11:24:43 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eq6Zt-0006Zs-Qv
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 11:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422653AbVLXKYh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 05:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbVLXKYh
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 05:24:37 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:58098 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932503AbVLXKYg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2005 05:24:36 -0500
Received: from [192.168.1.42] (217.210.107.34) by pne-smtpout1-sn2.hy.skanova.net (7.2.069.1)
        id 43AA783200099211; Sat, 24 Dec 2005 11:24:24 +0100
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: skimo@liacs.nl
In-Reply-To: <20051224101849.GY1279MdfPADPa@greensroom.kotnet.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14017>

Sven Verdoolaege wrote:
> On Sat, Dec 24, 2005 at 11:09:39AM +0100, Andreas Ericsson wrote:
> 
>>The worst trouble you're likely to run into is all the hardcoded paths. 
>>They are everywhere and ofcourse use the / for path entity separation.
> 
> 
> AFAIR, '/' is a valid path separator on Windows.
> It's just command.com (does that still exist?) that insisted on '\\'
> separators.
> 

Are you sure? I've seen lots of porting patches that transliterate those 
to '\\'. Perhaps those who wrote those patches just took for granted 
that it was needed, the same as I did.

> 
>>The fact that there are 39 bash'ish shell-scripts does little to help a 
>>native port, and although they can be fairly easily replaced by "real" 
>>programs it still means quite a bit of work with little real value for 
>>the unix-version, so I'm guessing you'll have to write those up for 
>>yourself.
> 
> 
> Or just use MinGW's bash.
> 

Didn't know it had one. Live and learn, I suppose. Good to know though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
