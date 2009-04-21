From: "David E. Wheeler" <david@kineticode.com>
Subject: Re: Again with git-svn: File was not found in commit
Date: Tue, 21 Apr 2009 11:16:37 -0700
Message-ID: <8EDD65AC-9C25-4281-86F6-E52A41331B00@kineticode.com>
References: <747CFDA3-AC27-44EB-A69C-BF9C29B05A31@kineticode.com> <20090421180231.GB16642@dcvr.yhbt.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 21 20:19:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwKYm-0002Ic-Gp
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 20:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511AbZDUSQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 14:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753968AbZDUSQm
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 14:16:42 -0400
Received: from host-201.commandprompt.net ([207.173.203.201]:55289 "EHLO
	smtp.kineticode.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbZDUSQl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 14:16:41 -0400
Received: from [192.168.1.120] (c-76-105-135-51.hsd1.or.comcast.net [76.105.135.51])
	by smtp.kineticode.com (Postfix) with ESMTPSA id D735550805D;
	Tue, 21 Apr 2009 11:15:45 -0700 (PDT)
In-Reply-To: <20090421180231.GB16642@dcvr.yhbt.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117146>

On Apr 21, 2009, at 11:02 AM, Eric Wong wrote:

>>    bricolage/branches/rev_1_8/lib/Bric/App/ApacheConfig.pm was not
>> found in commit
>>    e5145931069a511e98a087d4cb1a8bb75f43f899 (r5256)
>>
>> This seemed strange to me, so I had a look at SVN:
>>
>>    svn list -r5256 http://svn.bricolage.cc/bricolage/branches/rev_1_8/lib/Bric/App/ApacheConfig.pm
>>    ApacheConfig.pm
>>
>> So the file *is* there in that revision. I had been running  
>> 1.6.1.2, so I
>> upgraded to 1.6.2.2 and ran `git svn fetch` again to see if it  
>> would pick
>> up where it left off, but it returned the same error (please don't  
>> tell
>> me I have to start over!).
>
> Interesting.  I finally managed to reproduce it over the weekend.   
> I'll
> try to look into it later tonight.

Thanks, appreciate it. I've gotten around it by going back to the old  
CVS repository on SourceForge and migrating that, and then migrating  
the SVN repo only from after we moved to SVN. Then I'll just have to  
stitch the CVS and SVN migrations together and I'll be done.

Best,

David
