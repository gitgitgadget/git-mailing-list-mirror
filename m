From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: git-upload-pack bandwidth cap over SSH?
Date: Fri, 24 Sep 2010 13:42:32 -0600
Message-ID: <4C9CFF28.3050506@workspacewhiz.com>
References: <4C9CB9E9.8010901@workspacewhiz.com> <4C9CFC56.3030501@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 24 21:42:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzEAK-0002ez-BX
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 21:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757968Ab0IXTme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 15:42:34 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:34723 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699Ab0IXTme (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 15:42:34 -0400
Received: (qmail 21930 invoked by uid 399); 24 Sep 2010 13:42:33 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.196.230.186)
  by hsmail.qwknetllc.com with ESMTPAM; 24 Sep 2010 13:42:33 -0600
X-Originating-IP: 75.196.230.186
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <4C9CFC56.3030501@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157046>

  ----- Original Message -----
From: Joshua Jensen
Date: 9/24/2010 1:30 PM
>  ----- Original Message -----
> From: Joshua Jensen
> Date: 9/24/2010 8:47 AM
>>  Our Git repository central server is running on some kind of 
>> enterprise VM software.  I can push repository changes through the 
>> Gitolite-monitored SSH tunnel at 10+ megabytes per second.
>>
>> A 'git pull' operation (even a fresh clone of the packed repository) 
>> always caps at 1.55 MiB/s, according to the "Receiving objects" line 
>> in the status text.
> Replying to my own message... I take that back.  I'm not sure what I 
> was seeing, but I can consistently run scp and copy files at 6+ 
> megabytes per second.
>
> With that in mind, I'm back to looking at Git's pull performance over 
> SSH.  It never exceeds 1.55 MiB/s.
I'm taking this over to the msysGit mailing list.  I used a Linux 
machine to clone the same repository, and it receives objects at 6 
megabytes per second.

Sorry for the noise.

Josh
