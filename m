From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 16:31:26 -0700 (PDT)
Message-ID: <m3ljygra2o.fsf@localhost.localdomain>
References: <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu>
	<BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu>
	<20080828090421.GQ10360@machine.or.cz>
	<18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu>
	<alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org>
	<7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu>
	<20080828195211.GA3545@mithlond.arda.local>
	<4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu>
	<20080828212346.GA27867@coredump.intra.peff.net>
	<1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu>
	<20080828215907.GE27867@coredump.intra.peff.net>
	<3DE083DB-ADFF-45E7-B3EB-A76985941271@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Teemu Likonen <tlikonen@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:32:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYqyg-000429-NN
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755095AbYH1Xba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754910AbYH1Xba
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:31:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:41821 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754906AbYH1Xb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:31:29 -0400
Received: by nf-out-0910.google.com with SMTP id d3so150243nfc.21
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 16:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=uuc7y/+O9txpoH3LClud946RjekcaNs5UQOlHDGGTQ0=;
        b=o/0jpr4QToVWRRPgEt/OMs2shb/6IIPtL+1KhK+UAp6xsPyL9UfsgGnX2nSMvLurEC
         rCiMpExBigd7YUF9I8qd3rSN8TJSixuHRDDHUPDftCXznm2gzZLlyfKqB1HBx+uVd1FN
         9NigUCCMdqSmykQm3EDR0/XHukYhlM+3Fk04w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=RthZSq5IcsKqGhcwDSZ5bKwmrPQ7jDxzlaXX77vwM9f5+GmrDKjxi3uE8lf6Cjy0Ab
         4cIjSmGHk7oN8I300voqUfpW7mnSj3bYvegAgN29iF4VrheersrQQNdwoqWkhD5lzkys
         erAA3X2hkn/cPDVz2kYjcvRD9af/0HSBW3zXo=
Received: by 10.210.116.14 with SMTP id o14mr669488ebc.8.1219966287768;
        Thu, 28 Aug 2008 16:31:27 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.255.225])
        by mx.google.com with ESMTPS id c22sm1533474ika.1.2008.08.28.16.31.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Aug 2008 16:31:26 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7SNVKkF024120;
	Fri, 29 Aug 2008 01:31:21 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7SNVBN3024117;
	Fri, 29 Aug 2008 01:31:11 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <3DE083DB-ADFF-45E7-B3EB-A76985941271@cs.indiana.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94211>

Perry Wagle <wagle@cs.indiana.edu> writes:

> On Aug 28, 2008, at 2:59 PM, Jeff King wrote:
> 
>>> I now have to TEST to find those crazy backwards-incompatibility
>>> bugs before I can upgrade us to 1.6.0.  To test, I have to try to
>>> imagine what I and others were assuming about git.  And this
>>> episode means that I can't make any assumptions about the sanity
>>> of any changes since March, which is the version I'm thinking of
>>> upgrading.
>>>
>>> But note that THIS upward compatibility bug has been declared to
>>> not be a bug.  Will any others receive the same stamp?
>>>
>>> So please put on your engineer hat, and stop talking about "specious
>>> claims" and hurting feelings.

>>  - there has been _one_ such problem, and the person responsible for
>>    vetting such changes has solicited suggestions for doing better in
>>    the future. I don't think that is indicative of a pattern of such
>>    changes.
> 
> Ok.  My suggestion is that it shouldn't have been done in the first
> place, and we should now revert.  But others are saying over and over
> "its done!  live with it!".  I came in late.  What did I miss in the
> last 6 months.  Sounds like people have lots of practice with these
> water-over-the-dam's, surely this isn't the first time?

Errr... what last 6 months? Using "git <cmd>" over "git-<cmd>"
(also in scripts) was recommended for a long, long time' much more
than those 6 months.

Besides, the question stated in this thread was not whether to move
"git-*" commands outside $(bindir) (usually '/usr/bin'), but whether
to not create or not links (or symlinks, or hardcopy) in gitexecdir.
 
>>  - But let's say you have lost some faith in the git development
>>    process due to _this_ bug. But let's look at the history of this
>>    bug. It has been discussed several times for the past 2 years, along
>>    with a mention in the release notes several versions ago. It was not
>>    a surprise to anybody who has been developing git.
> 
> In March 2008, the sample git-hooks and git-web used git<DASH>
> commands.  That was the last I looked at git until Tuesday of this
> week.

As I said earlier in this thread, if by git-web you mean gitweb this
is simply not true.  _At least_ since commit 25691fb (gitweb: Use
--git-dir parameter instead of setting $ENV{'GIT_DIR'}) gitweb used
dashless form.

> But I think I'll still remain wary because 1.6 introduced a nearly
> complete renaming of the API for what, in this thread anyway,
> completely silly reasons.  If there are good reasons, I haven't seen
> them.

IIRC the reasons are git wrapper options linke --paginate or
--git-dir, equal treatment of git aliases, and cluttering of bindir
(which might be ~/bin).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
