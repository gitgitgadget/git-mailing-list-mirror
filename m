From: Andreas Ericsson <ae@op5.se>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Thu, 19 Jan 2006 12:10:23 +0100
Message-ID: <43CF739F.2030204@op5.se>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com>	<cda58cb80601170932o6f955469y@mail.gmail.com> <7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Franck <vagabon.xyz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 12:10:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzXgV-0004qT-8k
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 12:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbWASLK0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 06:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbWASLKZ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 06:10:25 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:54500 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1161103AbWASLKY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 06:10:24 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 7F0886BD03; Thu, 19 Jan 2006 12:10:23 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14898>

Junio C Hamano wrote:
> Franck <vagabon.xyz@gmail.com> writes:
> 
> 
>>I'm wondering why the "grafts" files is not involved during
>>push/pull/clone operations ?
> 
> 
> Commit ancestry grafting is a local repository issue and even if
> you manage to lie to your local git that 300,000th commit is the
> epoch, the commit object you send out to the downloader would
> record its true parent (or parents, if it is a merge), so the
> downloader would want to go further back.  And no, rewriting
> that commit and feeding a parentless commit to the downloader is
> not an option, because such a commit object would have different
> object name and unpack-objects would be unhappy.
> 


I'm a bit curious about how this was done for the public kernel repo. 
I'd like to import glibc to git, but keeping history since 1972 seems a 
bloody waste, really.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
