From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Reporting bugs and bisection
Date: Tue, 15 Apr 2008 00:18:24 +0200
Message-ID: <4803D830.7000206@keyaccess.nl>
References: <47FEADCB.7070104@rtr.ca>	<20080413121831.d89dd424.akpm@linux-foundation.org>	<20080413202118.GA29658@2ka.mipt.ru>	<200804132233.50491.rjw@sisk.pl>	<20080413205406.GA9190@2ka.mipt.ru>	<48028830.6020703@earthlink.net>	<alpine.DEB.1.10.0804131546370.9318@asgard>	<20080414043939.GA6862@1wt.eu>	<20080414053943.GU9785@ZenIV.linux.org.uk>	<20080413232441.e216a02c.akpm@linux-foundation.org>	<4803ACE5.4020502@keyaccess.nl> <20080414133802.4535e4da.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: viro@ZenIV.linux.org.uk, w@1wt.eu, david@lang.hm,
	sclark46@earthlink.net, johnpol@2ka.mipt.ru, rjw@sisk.pl,
	tilman@imap.cc, Valdis.Kletnieks@vt.edu, lkml@rtr.ca,
	davem@davemloft.net, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org,
	netdev@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 15 00:18:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlX0Z-0006Js-CU
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 00:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYDNWRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 18:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbYDNWRy
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 18:17:54 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:44992 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbYDNWRx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 18:17:53 -0400
Received: from [213.51.130.188] (port=51696 helo=smtp3.groni1.gr.home.nl)
	by smtpq2.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1JlWxW-0007qg-Mm; Tue, 15 Apr 2008 00:15:30 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:48671 helo=[192.168.0.3])
	by smtp3.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1JlWxW-0003xx-45; Tue, 15 Apr 2008 00:15:30 +0200
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <20080414133802.4535e4da.akpm@linux-foundation.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79537>

On 14-04-08 22:38, Andrew Morton wrote:

> On Mon, 14 Apr 2008 21:13:41 +0200
> Rene Herman <rene.herman@keyaccess.nl> wrote:
> 
>> Does that mean you're not going to take patches that align the right end of 
>> lines in comments? :-(
> 
> erm, was that ":-(" supposed to be a ":-)"?

The ":-(" was supposed to add to the implicitly obvious ":-)". That is, was 
indeed joking (Al mentioned them) but with a slightly serious undertone:

> I don't like to merge patches which fix typos and spellos and grammaros 
> in comments, simply because I'd be buried in the things. I do take such 
> fixes for user-visible text (Documentation/, kerneldoc comments and 
> printks).
> 
> Right-justification of comments would fall rather a long way below
> spelling fixes.

You, particularly, seem to be very good at picking up trivia. I've posted 
completely trivial patches from time to time for small things I encounter 
while looking at something else. Things at the "are people going to look 
funny at me for even bothering or..." level but you picking them up means 
it's still useful to post, so I sometimes do.

Now, in fact, Linux as a _whole_ doesn't seem bad at accepting that kind of 
small janitorial stuff but I have been noticing some backlash to it as well. 
I'm not sure it's worse or better than historically, but the "checkpatch 
syndrome" certainly triggers more of it.

Al specifically wanted more new eyes but the way to reward those new eyes is 
accepting their small changes. Al also specifically doesn't like those small 
changes when at the level of the automated and semi-brainless checkpatch level.

I believe the janitorial work has been over-organized, both through the 
kernel-janitors and checkpatch since while these are very useful in guiding 
a newbie in _what_ to do they cause "automated" huge tree-wide trivia storms 
which people then don't react overly favourable to and the new eyes who did 
all that work of generating it all dim again...

Frankly, the kernel really is fairly complex these days when starting at 0. 
Much more complex certainly than, say, back in 2.0 or 2.2 days and while 
Al's scenario of per-subsystem reviews might be good, I don't believe it's 
very realistic. Companies don't pay to have those done and for newbies it's 
generally too complex since understanding most parts of the kernel fully, 
requires understanding most of the rest kernel rather well also.

So you get the really promising newbies? Yeah, that, or you don't get anyone 
and if some promising newbies are building up 137 part checkpatch inspired 
patchsets that don't help none.

So, what am I saying (what _am_ I saying?!?) ...

I seemed to observe somewhat of an internal contradiction in Al's message 
about new eyes and his dislike of the trivial stuff but the contradiction 
only exists if the dislike wouldn't be limited to these kinds of huge trivia 
storms. I believe it is, and I furthermore believe that yes, it's 
over-organization that causes many new eyes to focus on the brainless aspects.

Now, do those new eyes have many other options when very few (to none) of 
the core crowd ever does things like answer question on the kernelnewbies 
list? From the established names, I only remember ever seeing Greg KH and 
Adrian Bunk there. And I'm _still_ pissed that noone would or could tell me 
what was wrong with the legacy CD-ROM driver I and Pekka Enberg were toying 
around with a while ago. Frankly, I care a whole lot less about a hundred 
sparse warning fixes.

In short -- the kernel in it's current state is already quite complex and if 
new eyes are wanted they'll need to be coached more. I'm seeing very little 
of that.

Rene.
