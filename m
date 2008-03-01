From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: Will git have a baseline feature or something alike?
Date: Sat, 1 Mar 2008 18:30:13 +0100
Message-ID: <8384AA89-4ECF-4BB8-8A3B-6A656F2D2903@orakel.ntnu.no>
References: <f17812d70802290123raa099bag17a6f7b89de65dd4@mail.gmail.com> <m3tzjrkie4.fsf@localhost.localdomain> <f17812d70803010610o39cdf327x995c9e2e75a9edba@mail.gmail.com> <200803011641.49874.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "eric miao" <eric.y.miao@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 18:31:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVVYK-0003uP-4t
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 18:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309AbYCARaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 12:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755087AbYCARaO
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 12:30:14 -0500
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:54831 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667AbYCARaN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 12:30:13 -0500
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id C199610FA28;
	Sat,  1 Mar 2008 18:30:10 +0100 (CET)
In-Reply-To: <200803011641.49874.jnareb@gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75688>

On 1. mars. 2008, at 16.41, Jakub Narebski wrote:

> On Sat, 1 Mar 2008, eric miao wrote:
>
>> I haven't ever used the shallow clone, but it looks still a bit  
>> different
>> from what I thought originally, say, if I download  
>> linux-2.6.24.tar.bz2
>> from kernel.org, that's about 40MB and should be a fair amount.
>> I then unpack and "git init", I expect it to recognize it's a  
>> v2.6.24,
>> and I can thereafter use "git fetch" to fetch those commits after
>> v2.6.24 from git.kernel.org. Is this possible?
>
> No, this doesn't work and couldn't work. The tarfile contains only
> _contents_ of the working directory, and perhaps commit-id, but it
> doesn't contain even shred of history. Git has no information of
> where this content is in linux kernel git history.

Okay, as a git n00b I'm probably on completely the wrong track, but if  
you made a git repository out of a kernel tarball (cd linux-2.6.24 &&  
git init && git add .) and then did a shallow fetch from kernel.org  
into that repository, wouldn't the blobs you added get reused  
(assuming the tarball you downloaded was fairly recent), thus reducing  
the amount of data fetch has to transfer?

I'm sure you'd end up transferring more data than just a straight  
shallow clone, but it would be cool if that worked, and might even be  
useful.  I'm downloading 2.6.25-rc3 now to try it out :)

Eyvind Bernhardsen

