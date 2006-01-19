From: Andreas Ericsson <ae@op5.se>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Thu, 19 Jan 2006 14:44:15 +0100
Message-ID: <43CF97AF.9060300@op5.se>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com>	 <cda58cb80601170932o6f955469y@mail.gmail.com>	 <7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net> <43CF739F.2030204@op5.se> <cda58cb80601190531q238a8f40r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jan 19 14:44:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eza5Y-0000Q6-Ij
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 14:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161199AbWASNoR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 08:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161201AbWASNoQ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 08:44:16 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:60133 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1161199AbWASNoQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 08:44:16 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 5877E6BD03
	for <git@vger.kernel.org>; Thu, 19 Jan 2006 14:44:15 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <cda58cb80601190531q238a8f40r@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14907>

Franck wrote:
> 2006/1/19, Andreas Ericsson <ae@op5.se>:
>>
>>I'm a bit curious about how this was done for the public kernel repo.
>>I'd like to import glibc to git, but keeping history since 1972 seems a
>>bloody waste, really.
>>
> 
> 
> That's exactly my point. Futhermore make your downloaders import that
> useless history spread this waste.
> 
> I guess kernel repo will encounter this problem in short term. It's
> being bigger and bigger and developpers may be borred to deal with so
> many useless objects.


Ach, no. The current kernel repo only has history since April 17 (around 
155 MB of objects, with less than optimal packing), when it started 
using git for versioning. The kernel repo also sees a lot of very rapid 
development.

The full kernel tree, with history since 1991 or some such, is about 3.2 
GB. It was for this reason that the early history was dropped. I don't 
think another drop will be necessary any time soon, since incremental 
updates are fairly cheap over git and git+ssh. Only gitk suffers, but 
that's just for a short while.


> But I'm not saying that it's bad thing to keep
> that history. It just would be nice to allow developpers that don't
> care about old history to get rid of it.
> 

You could ofcourse create a new repository with the files from the 
version you want, but then you'd have a hard time merging the two repos 
if you ever want to import the old history.

Linus; Is this what you did with the public kernel repo?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
