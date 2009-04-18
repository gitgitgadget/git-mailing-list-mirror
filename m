From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git & ssh on F10 server
Date: Sat, 18 Apr 2009 16:34:01 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0904181632150.20139@reaper.quantumfyre.co.uk>
References: <489CF11BD65F439998B6CF3FCC610576@HPLAPTOP> <alpine.LNX.2.00.0904171716150.8346@reaper.quantumfyre.co.uk> <FD77671D77E2465097BD60A1E144BB91@HPLAPTOP> <alpine.LNX.2.00.0904171812330.8773@reaper.quantumfyre.co.uk>
 <DD909F216D254CDAB2A0C0847AEB75C0@HPLAPTOP>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 17:36:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvCai-0002xe-4U
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 17:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756355AbZDRPev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 11:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754837AbZDRPev
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 11:34:51 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:39183 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756512AbZDRPeu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Apr 2009 11:34:50 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id D6A8D1F25B6
	for <git@vger.kernel.org>; Sat, 18 Apr 2009 16:34:48 +0100 (BST)
Received: (qmail 22917 invoked by uid 103); 18 Apr 2009 16:34:02 +0100
Received: from darkphoton.datavampyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9254. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.025885 secs); 18 Apr 2009 15:34:02 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 18 Apr 2009 16:34:01 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <DD909F216D254CDAB2A0C0847AEB75C0@HPLAPTOP>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116830>

On Sat, 18 Apr 2009, Aaron Gray wrote:

>>  On Fri, 17 Apr 2009, Aaron Gray wrote:
>> > >   On Fri, 17 Apr 2009, Aaron Gray wrote:
>> > > 
>> > > >   Hi,
>> > > > 
>> > > >  we have a Fedora 10 server in SELinux enforcing mode setup running 
>> > > >  git-deamon and gitweb (with home grown SElinux policy).
>> > > > 
>> > > >  Anyway now we find out you cannot do a 'push' over the basic git 
>> > > >  protocol, back to the server repository.
>> > > 
>> > >  You can push over git://, but you get no authentication mechanism so 
>> > >  it's
>> > >   disabled by default.  It's only really useful if you trust everyone 
>> > >   who
>> > >   has IP access to the server.
>> > 
>> >  How do go about I enabling it ?
>>
>>  You have to enable the receive-pack service.  You can either enable it for
>>  all repositories by using the --enable=<service> option to git-daemon, or
>>  on a per-repository basis by setting daemon.receivepack to true in the
>>  repositories that you want to enable push for.
>
> Okay I have added the following to 'config' :-
>
> [daemon]
>        receivepack = true
>
> and done an 'service xinetd restart' just in case, probably not needed.
>
> I have tried a 'git push git://.../repo' but it is hanging, btw I am using 
> Cygwin on the client, and F10 on the server.

What output do you get?  What version of git are you using (client and 
server)?

Do you get any output logged by the git daemon?

> Trying to clone an empty repository also hangs. btw I have sucessfully cloned 
> big repositories.
>
> Aaron

-- 
Julian

  ---
Yes, but every time I try to see things your way, I get a headache.
