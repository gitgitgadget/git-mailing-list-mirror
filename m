From: Andreas Ericsson <ae@op5.se>
Subject: Re: Can't use gitk.
Date: Mon, 14 Nov 2005 13:09:18 +0100
Message-ID: <43787E6E.8030702@op5.se>
References: <cda58cb80511140253s92f28e2g@mail.gmail.com>	 <437870AF.8060607@op5.se>	 <cda58cb80511140322v686e4ee0g@mail.gmail.com>	 <43787831.3030404@op5.se> <cda58cb80511140355q1add0ba5n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 13:11:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebd9I-0002IO-9p
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 13:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVKNMJU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 07:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVKNMJU
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 07:09:20 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:20161 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751099AbVKNMJU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 07:09:20 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id D92446BCBE; Mon, 14 Nov 2005 13:09:18 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80511140355q1add0ba5n@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11792>

Franck wrote:
> 2005/11/14, Andreas Ericsson <ae@op5.se>:
> 
>> The default
>>installation directory for git is $HOME/bin which might not necessarily
>>be in the $PATH once "wish" and friends have had their say.
> 
> 
> nope every commands I'm running are not run as root. $HOME/bin is in my path.
> 

Yes, but wish or some such might strip $HOME/bin away from it.

Try doing

make clean; make prefix=/usr
sudo make prefix=/usr install

and see if it works.

If it does, some program somewhere is manipulating your $PATH.
Otherwise I'm at my wits end. Perhaps someone more clever than myself 
will take a stab at answering tonight when it's daytime in the US.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
