From: Jarek Poplawski <jarkao2@o2.pl>
Subject: Re: gitweb: kernel versions in the history (feature request,	probably)
Date: Wed, 21 Nov 2007 21:16:26 +0100
Message-ID: <4744921A.6000801@o2.pl>
References: <20071120142042.GA4157@ff.dom.local> <20071120215904.GF1001@machine.or.cz> <47436E0F.6080003@o2.pl> <20071121032009.GB4175@fieldses.org> <20071121075217.GA1642@ff.dom.local> <20071121151831.GO1001@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758647AbXKUUOf@vger.kernel.org Wed Nov 21 21:15:14 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758647AbXKUUOf@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuvyc-0003HH-EU
	for glk-linux-kernel-3@gmane.org; Wed, 21 Nov 2007 21:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758647AbXKUUOf (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 21 Nov 2007 15:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754794AbXKUUOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Nov 2007 15:14:22 -0500
Received: from mx12.go2.pl ([193.17.41.142]:50240 "EHLO poczta.o2.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753294AbXKUUOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Nov 2007 15:14:21 -0500
Received: from poczta.o2.pl (mx12 [127.0.0.1])
	by poczta.o2.pl (Postfix) with ESMTP id 93C0E3E80B2;
	Wed, 21 Nov 2007 21:14:18 +0100 (CET)
Received: from [83.27.50.127] (avq127.neoplus.adsl.tpnet.pl [83.27.50.127])
	by poczta.o2.pl (Postfix) with ESMTP;
	Wed, 21 Nov 2007 21:14:18 +0100 (CET)
User-Agent: Icedove 1.5.0.14pre (X11/20071020)
In-Reply-To: <20071121151831.GO1001@machine.or.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65699>

Petr Baudis wrote, On 11/21/2007 04:18 PM:

> On Wed, Nov 21, 2007 at 08:52:17AM +0100, Jarek Poplawski wrote:
>> ...
>> tags
>> 4 days ago 	v2.6.24-rc3 	Linux 2.6.24-rc3
>> 2 weeks ago 	v2.6.24-rc2 	Linux 2.6.24-rc2
>> 4 weeks ago 	v2.6.24-rc1 	Linux 2.6.24-rc1
>> 6 weeks ago 	v2.6.23 	Linux 2.6.23
>>
>> which drives me crazy, because, without looking at the calendar, and
>> calculator, I don't really know which month was 6 weeks ago, and 4
>> days ago, either!
> 
> I have myself never been sure if the relative times are a good idea or
> not. :-) Sometimes I hate them, sometimes they are more convenient...
> 
> At any rate, if you click at the tag name, you should get tag page with
> full date.


So, it's so easy! Great! It seems I've to get used to this clicking
more. It seems I've become too cautious with this, when I've really
- really, waited after each click there. (I mean a few months ago,
and my connection was the same; sometimes, one such click took one
whole break for coffee.)

I seems, there are simply two kinds of people wrt. calendar/time. I'm
usually happy if I can figure by myself which day of week is today, but
I wouldn't even try with something like 4 days ago. But I understand
I'm not the brightest here...

So, maybe, some day, with: linux-kernel-for-dummies.org such things
could be reconsidered...

> 
>> So, I go to the: http://www.eu.kernel.org/pub/linux/kernel/v2.6/, 
>> do some scrolling, look at this:
>> ChangeLog-2.6.23             09-Oct-2007 20:38  3.8M  
>>
>> and only now I can guess, this napi patch didn't manage to 2.6.23.
>> Of course, usually I've to do a few more clicks and reading to make
>> sure where it really started.
>>
>> So, this could suggest this 2007-10-10 (probably stored with time
>> too), could be useful here... but it seems, I'm wrong.
> 
> Yes, there are three scenarios:
> 
> (i) The patch has been _created_ after the release date. It can't be in
> the release.
> (ii) The patch has been created before the release date, but _committed_
> after the release date. It can't be in the release either.
> (iii) The patch has been committed before the release date. It _still_
> might not be in the release if it comes from a different branch.
> Imagine, say, tglx accepting the patch in his branch, then Linus
> releasing new kernel version, and only _then_ Linus merging tglx's
> branch.
> 
> So the time information isn't really too useful if you want to be any
> sort of reliable.
> 
>> Of course, this problem doesn't look so hard if we forget about
>> git internals: I can imagine keeping a simple database, which
>> could simply retrieve commit numbers from these ChangeLogs, and
>> connecting this with gitweb's commit page as well... For
>> performance reasons, doing it only for stable and testing, so with
>> -rc 'precision' would be very helpful too.
> 
> It isn't too hard if we don't forget about git internals either. It's
> just that getting this information might not be cheap. But maybe I'm
> wrong and this won't be a problem for sane projects. Someone should post
> a patch. ;-)


It looks, after Kay's notice, my main problem is solved. And your current
explanations are also very precious to me. Probably some things considered
here could be done a bit better in the future, but I guess there is enough
urgent work with git or kernel too, so let's say it's OK for now!

Thanks every good git people!
Jarek P.

 
