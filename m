From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 16:24:50 -0700
Message-ID: <7vmyiwd8ot.fsf@gitster.siamese.dyndns.org>
References: <20080828090421.GQ10360@machine.or.cz>
 <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu>
 <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org>
 <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu>
 <20080828195211.GA3545@mithlond.arda.local>
 <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu>
 <20080828212346.GA27867@coredump.intra.peff.net>
 <1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu>
 <20080828215907.GE27867@coredump.intra.peff.net>
 <3DE083DB-ADFF-45E7-B3EB-A76985941271@cs.indiana.edu>
 <20080828230401.GC29609@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Perry Wagle <wagle@cs.indiana.edu>,
	Teemu Likonen <tlikonen@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:26:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYqsY-0001uI-Ho
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbYH1XZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754819AbYH1XZJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:25:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37962 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283AbYH1XZI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:25:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 89732550BF;
	Thu, 28 Aug 2008 19:25:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1EE0C550BE; Thu, 28 Aug 2008 19:24:53 -0400 (EDT)
In-Reply-To: <20080828230401.GC29609@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 28 Aug 2008 19:04:01 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8D1450B6-7558-11DD-8DA5-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94207>

Jeff King <peff@peff.net> writes:

>> In March 2008, the sample git-hooks and git-web used git<DASH> commands.  
>> That was the last I looked at git until Tuesday of this week.
>
> Yes, and some of the test scripts still have git-* in them. I think in
> that respect, the git community has been very bad about eating our own
> dog food.

Not at all.

For one thing, hooks do run under modified PATH, as already pointed out in
the earlier thread.

Test scripts are executed in a special environment whose GIT_EXEC_PATH
points at the top of the build tree, where all git-foo lives.

Before anybody greps in Documentation/ to make pointless noises about some
dashed-form git-foo in there when we do not talk about what the user types
but about a command as a concept in manual pages, they are left in dashed
form deliberately, partly to help manpage browsers crosslink across pages.

We could have described typographic convention,

Cf.

    http://thread.gmane.org/gmane.comp.version-control.git/86940/focus=87008

but we ended up not doing so.
