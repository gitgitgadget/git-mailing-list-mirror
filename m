From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: importing cvs logical modules
Date: Thu, 25 May 2006 09:02:19 +0200
Organization: At home
Message-ID: <e53kpq$ddf$1@sea.gmane.org>
References: <93c3eada0605242148u4656bc31p96d84a16703f0fe0@mail.gmail.com> <7vslmyzoit.fsf@assigned-by-dhcp.cox.net> <93c3eada0605242302x24ca1272xd7bfc3a677b32845@mail.gmail.com> <46a038f90605242316l4b0a0963m638f7a2e47936000@mail.gmail.com> <93c3eada0605242359k204bfe79vabc323eddfafa5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu May 25 09:02:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj9rm-0002lS-Mh
	for gcvg-git@gmane.org; Thu, 25 May 2006 09:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWEYHCk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 03:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWEYHCk
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 03:02:40 -0400
Received: from main.gmane.org ([80.91.229.2]:60853 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965019AbWEYHCj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 03:02:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fj9rc-0002jP-Rx
	for git@vger.kernel.org; Thu, 25 May 2006 09:02:32 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 May 2006 09:02:32 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 May 2006 09:02:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20733>

Geoff Russell wrote:

> On 5/25/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
>> On 5/25/06, Geoff Russell <geoffrey.russell@gmail.com> wrote:
>>> The tight linkage is absolutely essential.
>>>
>>> When we tag the system, we
>>> want to tag everything (not individually tag all 300 programs)
>>> so that later we can to branch at that tag. Very few of our
>>
>> Then you want a single git repo/tree/project. The thing is how to work
>> through your mangled CVS history.
>>
>> Two options there...
>>
>>  - Don't. Import from after the last directory reorg or from your last
>> interesting release. Keep the cvs tree for people who really want to
>> dig into the past. this has several advantages, as initial checkouts
>> will be faster, import times shorter, less pain overall.
> 
> Yes, this is definitely on the shortlist of options.
> If we can't keep all the history, we may as well make
> a clean start. Thanks for the advice.

Well, you can always copy history and graft old CVS history later. Perhaps
when "bind" (or Cogito "bind lite") mature enough...

-- 
Jakub Narebski
Warsaw, Poland
