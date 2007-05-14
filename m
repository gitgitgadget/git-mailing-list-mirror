From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 14 May 2007 01:38:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705140121030.5520@beast.quantumfyre.co.uk>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0705132348290.4791@beast.quantumfyre.co.uk>
 <7vzm48pacj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 02:38:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnOaY-00028r-Eg
	for gcvg-git@gmane.org; Mon, 14 May 2007 02:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbXENAic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 20:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755181AbXENAic
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 20:38:32 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:36526 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752696AbXENAib (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2007 20:38:31 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 0C95CC6087
	for <git@vger.kernel.org>; Mon, 14 May 2007 01:38:30 +0100 (BST)
Received: (qmail 13044 invoked by uid 103); 14 May 2007 01:36:41 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3233. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.041412 secs); 14 May 2007 00:36:41 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 14 May 2007 01:36:41 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <7vzm48pacj.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47204>

On Sun, 13 May 2007, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> On Sun, 13 May 2007, Junio C Hamano wrote:
>>
>>> * db/remote (Sat May 12 11:46:03 2007 -0400) 3 commits
>>> - Add handlers for fetch-side configuration of remotes.
>>> - Move refspec parser from connect.c and cache.h to remote.{c,h}
>>> - Move remote parsing into a library file out of builtin-push.
>>>
>>> Hopefully be in 'next' after v1.5.2; I haven't really played
>>> with it.  The next step would probably be to add some stuff that
>>> use this series in fetch--tool, to further rewrite git-fetch
>>> itself in C, or maybe wholesale rewrite of git-fetch in C.
>>
>> FWIW, I've got a largely functional C version of git-fetch ... the
>> main functionality is there - but it's not complete yet.  In addition
>> to some of the non-core functionality being missing (e.g. --tags or
>> --no-tags in tagopt), I haven't been keeping up with recent updates to
>> fetch/fetch-tool.  I was hoping to have it ready for post-1.5.2 -
>> unfortunately I've been rather busy the last couple of weeks, and
>> haven't managed to get as far as I'd hoped.
>
> Thanks for the status updates.  Although I do not recall Daniel
> saying it explicitly, I have been assuming that his series was
> aiming for the same all along.  It might be a good idea for you
> two to compare notes sometime between now and v1.5.2?

Well, it can't be a bad idea, can it? ;)

Apart from the code itself (which can be found at 
http://git.q42.co.uk/w/fetch2.git), I don't have any actual notes, and 
since I haven't had a chance to work on it for a couple of weeks I'm 
not 100% sure of where I was at - due to lack of time I have tended to 
just spend a few hours adding some missing part when I found the time but 
I don't actually have a TODO list or similar (though I really should).

I'm also out of town with work for the first half of the coming week ... 
but I'm certainly willing to talk about what I have and haven't done.

(Daniel, hope you don't mind me adding you to CC ...)

-- 
Julian

  ---
The cable TV sex channels don't expand our horizons, don't make us better
people, and don't come in clearly enough.
 		-- Bill Maher
