From: David Mansfield <david@cobite.com>
Subject: Re: Change "pull" to _only_ download, and "git update"=pull+merge?
Date: Wed, 20 Apr 2005 19:58:58 -0400
Message-ID: <4266ECC2.6060202@cobite.com>
References: <Pine.LNX.4.21.0504161951160.30848-100000@iabervon.org> <20050419011206.GT5554@pasky.ji.cz> <42646967.9030903@dwheeler.com> <4264CCFF.30400@dgreaves.com> <20050419092812.GE2393@pasky.ji.cz> <1113905110.1262.1.camel@nosferatu.lan> <20050419105008.GB12757@pasky.ji.cz> <20050420070157.GA12584@elte.hu> <20050420200504.GB19112@pasky.ji.cz> <20050420203235.GA13270@elte.hu> <20050420211505.GE19112@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>,
	Martin Schlemmer <azarah@nosferatu.za.org>,
	David Greaves <david@dgreaves.com>, dwheeler@dwheeler.com,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 01:55:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOP2f-0000wQ-Ih
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 01:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVDTX7w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 19:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVDTX7w
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 19:59:52 -0400
Received: from ms-smtp-02-smtplb.rdc-nyc.rr.com ([24.29.109.6]:6032 "EHLO
	ms-smtp-02.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S261842AbVDTX7t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 19:59:49 -0400
Received: from [192.168.0.103] (cpe-66-65-159-236.nyc.res.rr.com [66.65.159.236])
	by ms-smtp-02.rdc-nyc.rr.com (8.12.10/8.12.7) with ESMTP id j3KNxXId021200;
	Wed, 20 Apr 2005 19:59:33 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050420211505.GE19112@pasky.ji.cz>
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Wed, Apr 20, 2005 at 10:32:35PM CEST, I got a letter
> where Ingo Molnar <mingo@elte.hu> told me that...
> 
>>* Petr Baudis <pasky@ucw.cz> wrote:
>>
>>
>>>>yet another thing: what is the canonical 'pasky way' of simply nuking 
>>>>the current files and checking out the latest tree (according to 
>>>>.git/HEAD). Right now i'm using a script to:
>>>>
>>>>  read-tree $(tree-id $(cat .git/HEAD))
>>>>  checkout-cache -a
>>>>
>>>>(i first do an 'rm -f *' in the working directory)
>>>>
>>>>i guess there's an existing command for this already?
>>>
>>>git cancel
>>
>>hm, that's a pretty unintuitive name though. How about making it 'git 
>>checkout' and providing a 'git checkout -f' option to force the 
>>checkout? (or something like this)
> 
> 
> Since it does not really checkout. Ok, it does, but that's only small
> part of it. It just cancels whatever local changes are you doing in the
> tree and bring it to consistent state. When you have a merge in progress
> and after you see the sheer number of conflicts you decide to get your
> hands off, you type just git cancel. Doing basically anything with your
> tree (not only local changes checkout would fix, but also various git
> operations, including git add/rm and git seek) can be easily fixed by
> git cancel.


How about 'git revert'?

Most editors and word processors use that idiom for revert to saved 
copy, with the obvious parallel here.

David
