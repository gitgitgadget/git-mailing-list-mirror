From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Unresolved issues
Date: Mon, 26 Feb 2007 05:10:33 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702260455020.16708@beast.quantumfyre.co.uk>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702260112160.12555@beast.quantumfyre.co.uk>
 <7vtzx9oaeb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, sbejar@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 06:10:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLY8P-00052n-1W
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 06:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbXBZFKg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 00:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbXBZFKg
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 00:10:36 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:53486 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbXBZFKg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 00:10:36 -0500
Received: (qmail 10648 invoked by uid 103); 26 Feb 2007 05:10:34 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.88.7/2653. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.033376 secs); 26 Feb 2007 05:10:34 -0000
Received: from unknown (HELO beast.quantumfyre.co.uk) (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 26 Feb 2007 05:10:34 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <7vtzx9oaeb.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40610>

On Sun, 25 Feb 2007, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> On Mon, 19 Feb 2007, Junio C Hamano wrote:
>>
>>> * "git fetch" between repositories with hundreds of refs.
>>>
>>> 	$gmane/39330
>>>
>>>  There are partial rewrite of the most expensive parts of git-fetch in
>>>  C parked in 'pu'.  It might be good enough for public consumption
>>>  without going the whole nine yards.  I dunno.  I am not very keen on
>>>  rewriting all of "git fetch" in C right now, as people seem to be
>>>  still interested in touching it (including "git bundle" topic).
>>
>> The current changes in jc/fetch take things from "unusable" to "a bit
>> slow", which I think could quite easily be considered a separate task
>> from "a bit slow" to "something that even Linus would consider
>> reasonable".  So my opinion would be to get the current improvements
>> in so that they can be combined with the other good work happening in
>> this area, and wait for things to settle before going the last mile
>> (after all anyone converting from Subversion or CVS probably won't
>> find 30s to be slow anyway ... ;)).
>
> I was kind of waiting for dust from Santi's code shuffling to
> settle down, because the series moderately conflicts with it.  I
> wanted to take Santi's patch first as it was supposed to be a
> clean-up without any functionality changes, although it was kind
> of painful to really make sure there is no regression.

Indeed.  I was thinking pretty much the same.  It seems unnecessary to 
make Santi rebase his patch without any evidence that the jc/fetch topic 
is actually urgently needed by anyone.

I was advocating a two step approach, but I didn't mean to give the 
impressions that I wanted the topic merged now.  I envisioned both steps 
as being after the current active work that is affecting git-fetch. 
Thanks to the power of git I have got myself a master+jc/fetch branch so 
I'm happy - so unless there is anyone else out there working with stupidly 
large numbers of refs I'm quite happy to let Santi's work go in first. 
I'll even have a go at rebasing the fetch improvements ontop of Santi's 
work ...

>
> If what jc/fetch topic tries to do helps real users, let's merge
> it in 'next' first, as Santi's change is not supposed to bring
> any improvements by itself even when it proves regression-free.
>
> In the short term, this means we have to ask Santi to rebase his
> patch instead of the other way around as I planned first, which
> is a bit unfortunate.

Unless there is someone else out there that wants jc/fetch badly, I would 
say "after you" ...

-- 
Julian

  ---
   This report is filled with omissions.
