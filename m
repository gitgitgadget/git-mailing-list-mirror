From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: found some code...
Date: Wed, 18 Jan 2012 10:56:14 +0100
Message-ID: <4F16973E.8040302@ira.uka.de>
References: <loom.20120118T015734-175@post.gmane.org> <CAH5451k4bMJtMLsaFi6g_uRGTL0OdQ5Z1Pss3xuMdWYs+6VcLQ@mail.gmail.com> <2918969.0SyTOLELv0@reg-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andrew Ardill <andrew.ardill@gmail.com>, git@vger.kernel.org
To: Ron Eggler <ron.eggler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 10:56:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnSFd-00056k-Ru
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 10:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757302Ab2ARJ4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 04:56:13 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:49202 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756308Ab2ARJ4M (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2012 04:56:12 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1RnSFR-0003Mv-U2; Wed, 18 Jan 2012 10:56:11 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1RnSFR-0002if-PA; Wed, 18 Jan 2012 10:56:05 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <2918969.0SyTOLELv0@reg-desktop>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1326880571.409141000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188743>

On 18.01.2012 03:49, Ron Eggler wrote:
> On January 18, 2012 12:16:49 PM Andrew Ardill wrote:
>> Hi Ron,
>>
>> On 18 January 2012 12:02, Ron Eggler<ron.eggler@gmail.com>  wrote:
>>> Hi There,
>>>
>>> Some mishap had happened with my project:
>>> I found a piece of code that is the most recent one that never got
>>> commited to the repository. It is dated December 5th and it definitely
>>> is the most recent piece of code.
>>> Now in the mean time I switched computers so I had to reinstall git and
>>> get create new local folders. Now this directory with the most recent
>>> code, shows every file as unversioned which should not be true.
>>> Only a couple, maybe 3 files had changed with that last change. Now when
>>> I commit this now, is that gonna mess up my old repo or can I safely
>>> gio ahead and commit that most recent code (even tho it might commit
>>> the whole folder) - it almost seems like it forgot which files
>>> were in the repo vs. which files were in my local folder...

Try "git update-index --refresh", more info in this recent thread 
"http://comments.gmane.org/gmane.comp.version-control.git/188291"

If this doesn't help:
Human language is very ambiguous. What do you mean by "found a piece of 
code"? Somewhere outside the repository, in a branch inside the 
repository, in a subdirectory?
What do you mean by "get create new local folders"? Do you mean a folder 
where you copied the repository or do you mean folders inside your 
repository where you created new files with your editor?
