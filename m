From: david@lang.hm
Subject: Re: Using a git repository on the root directory
Date: Sat, 17 Apr 2010 05:55:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.01.1004170548440.16996@asgard.lang.hm>
References: <q2k3e2876431004161344vfff638a7ncfa74aa0e3b979dc@mail.gmail.com>  <4BC9364D.7020204@gmail.com>  <alpine.DEB.2.01.1004162120490.16996@asgard.lang.hm>  <t2g3e2876431004170415r71d5f834z3bfdedfaec076c6c@mail.gmail.com>  <alpine.DEB.2.01.1004170439170.16996@asgard.lang.hm>
 <v2l3e2876431004170458ib2d40b28he1fb56906f94a7ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Gabriel Filion <lelutin@gmail.com>, git@vger.kernel.org
To: Miguel Ramos <mail@miguel.ramos.name>
X-From: git-owner@vger.kernel.org Sat Apr 17 14:55:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O37Yq-0002wo-HU
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 14:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542Ab0DQMzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 08:55:43 -0400
Received: from mail.lang.hm ([64.81.33.126]:36465 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446Ab0DQMzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 08:55:42 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id o3HCtZ5M004635;
	Sat, 17 Apr 2010 05:55:36 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <v2l3e2876431004170458ib2d40b28he1fb56906f94a7ed@mail.gmail.com>
User-Agent: Alpine 2.01 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145145>

On Sat, 17 Apr 2010, Miguel Ramos wrote:

> 2010/4/17  <david@lang.hm>:
>> On Sat, 17 Apr 2010, Miguel Ramos wrote:
>>
>>> Well, David, you certainly made a good case defending using a VCS for
>>> filesystems.
>>> However, a versioned filesystem should be more adequate for that.
>>
>> a versioned filesystem will not let you easily clone or backup your system.
>> a versioned filesystem could be a nice UI to access a DVCS that would give
>> you this sort of ability
>>
>>> Why would one want diffs, patches, branches, merges for the entire
>>> filesystem?
>>
>> these all seem like very useful things to me
>>
>> diffs to find out what changed when a system gets broken, or after something
>> new is installed.
>>
>> patches could be a way to either install software, or to propogate updates
>> between systems.
>>
>> branches could easily be different systems
>>
>> merges are for when you have two systems each doing one job and you want to
>> combine them onto one piece of hardware (could could do it with
>> virtualization, if you are willing to pay the overhead). you wouldn't want
>> to merge the binary files, but you would want to merge the branches that
>> contain binary files.
>>
>> there are many reasons why you don't just use your linux distro tools to
>> manage large numbers of machines and configurations.
>>
>> David Lang
>
> Yes, you certainly are right.
> It does open up a set of new possibilities.
> Even better if it was based on a binary diff, because otherwise you
> either had to be very conservative updating software or run out of
> space.

git works just fine on doing diffs of binary files.

shallow clones on individual systems would avoid the need to have 
huge amounts of storage on an individual system for history, and with a 
separate branch for each system you only have to have the files for your 
system locally, but on systems where you keep all the branches disk space 
is usually not that big a problem.

David Lang
