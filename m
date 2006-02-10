From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add git-annotate - a tool for annotating files with the
 revision and person that created each line in the file.
Date: Fri, 10 Feb 2006 12:55:03 +0100
Message-ID: <43EC7F17.6050007@op5.se>
References: <11394103753694-git-send-email-ryan@michonline.com> <cda58cb80602080835s38713193t@mail.gmail.com> <Pine.LNX.4.63.0602081843220.20568@wbgn013.biozentrum.uni-wuerzburg.de> <7v3bitr73q.fsf@assigned-by-dhcp.cox.net> <20060210112541.GA3513@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 12:55:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7Ws5-0007ui-Vz
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 12:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWBJLzH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 06:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWBJLzH
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 06:55:07 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:63921 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751090AbWBJLzF
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 06:55:05 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id E9F026BD12; Fri, 10 Feb 2006 12:55:03 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <20060210112541.GA3513@linux-mips.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15874>

Ralf Baechle wrote:
> On Wed, Feb 08, 2006 at 11:19:37AM -0800, Junio C Hamano wrote:
> 
> 
>>Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>
>>>>Are there any rules on the choice of the script language ?
>>>
>>>Yes. Do not try to introduce unnecessary dependencies. But if it is 
>>>the right tool to do the job, you should use it. As of now, we have perl, 
>>>python and Tcl/Tk.
>>
>>Very well said.  That's what currently stands.
> 
> 
> The dependency on Python 2.4 already is a problem for installation on some
> systems ...
> 

Not many though. Since Python is only required on the workstation where 
the developer does his/her work it's not a very cumbersome requirement. 
The same holds for Perl, btw. It's not a requirement on the server 
hosting the public repositories, unless some of the scripts are used 
from the hooks (git shortlog is used from the default update-hook, but 
that can be changed with no trouble at all).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
