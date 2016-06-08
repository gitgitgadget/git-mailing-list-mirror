From: Alfred Perlstein <alfred@freebsd.org>
Subject: Re: `git help svn` missing description of `propset`
Date: Wed, 8 Jun 2016 16:54:16 -0700
Organization: FreeBSD
Message-ID: <a87422f0-0717-1e1b-5bae-c4e779783b6a@freebsd.org>
References: <2A4EC08B-3095-4063-BDF3-5B1CD1CEA2C3@apple.com>
 <20160607200828.GA29701@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Fraser <davidf@sjsoft.com>
To: Eric Wong <e@80x24.org>, Joseph Pecoraro <pecoraro@apple.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 02:03:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAnRR-000309-0D
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 02:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbcFIADG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 20:03:06 -0400
Received: from elvis.mu.org ([192.203.228.196]:57961 "EHLO elvis.mu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932086AbcFIADF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 20:03:05 -0400
X-Greylist: delayed 526 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jun 2016 20:03:05 EDT
Received: from Alfreds-MacBook-Pro-2.local (unknown [IPv6:2601:645:8003:a4d6:c9f0:5c55:b2b3:cc8])
	by elvis.mu.org (Postfix) with ESMTPSA id CB968346DFAC;
	Wed,  8 Jun 2016 16:54:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
In-Reply-To: <20160607200828.GA29701@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296863>

Eric,

Would love to contribute more to git!  I'm in the middle of a major 
product launch, so I can do this next week.  Of course no hard feelings 
will be had if someone else wants to do it.  I'm making myself a 
calendar invite to remind myself right now.

I'll ping y'all in a week hopefully with a patch.

thank you,

-Alfred



On 6/7/16 1:08 PM, Eric Wong wrote:
> +Cc Alfred, David
>
> Joseph Pecoraro <pecoraro@apple.com> wrote:
>> `git help svn` does not mention `propset` but it does mention `proplist` and `propget`. This seems like an oversight.
>>
>>
>>      $ git help svn
>>      ...
>>          proplist
>>              Lists the properties stored in the Subversion repository about a given file or directory.
>>              Use -r/--revision to refer to a specific Subversion revision.
>>          
>>          propget
>>              Gets the Subversion property given as the first argument, for a file. A specific revision
>>              can be specified with -r/--revision.
>>      ...
>>
>>
>> Interestingly, the generic `git svn` help does mention `propset`.
>>
>>
>>      $ git svn
>>      ...
>>        propget          Print the value of a property on a file or directory
>>                           --revision, -r <num>
>>        proplist         List all properties of a file or directory
>>                           --revision, -r <num>
>>        propset          Set the value of a property on a file or directory - will be set on commit
>>      ...
>>    
>> It seems Documentation/git-svn.txt is missing text for `propset`.
> Thanks Joseph, indeed it is missing from the manpage.
>
> Alfred / David: either of you have a few cycles to spare to write
> a manpage entry for this feature you worked on?
>
> If not, let us know, too, so others can work on it.  Thanks.
>
