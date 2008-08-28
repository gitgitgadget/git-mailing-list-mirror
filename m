From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: [PATCH v2] allow user aliases for the --author parameter
Date: Thu, 28 Aug 2008 10:53:23 +0200
Message-ID: <48B66783.4050305@fastmail.fm>
References: <20080822165047.GA3339@sigill.intra.peff.net> <7vzln492pc.fsf@gitster.siamese.dyndns.org> <20080822211902.GA31884@coredump.intra.peff.net> <48B3B8B0.4020609@fastmail.fm> <7vsksr1hgt.fsf@gitster.siamese.dyndns.org> <20080827001944.GA7347@coredump.intra.peff.net> <7v7ia3rnnq.fsf@gitster.siamese.dyndns.org> <48B52037.7030405@fastmail.fm> <20080827123656.GB11986@coredump.intra.peff.net> <7vmyiyqt08.fsf@gitster.siamese.dyndns.org> <20080827171846.GA14300@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 10:54:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYdHA-0002mB-HF
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 10:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbYH1Ixj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 04:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbYH1Ixj
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 04:53:39 -0400
Received: from main.gmane.org ([80.91.229.2]:55654 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbYH1Ixi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 04:53:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KYdG4-0006h0-Uu
	for git@vger.kernel.org; Thu, 28 Aug 2008 08:53:36 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 08:53:36 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 08:53:36 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <20080827171846.GA14300@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King venit, vidit, dixit 27.08.2008 19:18:
> On Wed, Aug 27, 2008 at 10:15:19AM -0700, Junio C Hamano wrote:
> 
>>> I wonder if there is a good way to warn that we have multiple matches.
>>> Of course we expect many _exact_ matches if the author has multiple
>>> commits, but we could look for distinct matches. However, even that will
>>> turn up false positives, since some authors have multiple email
>>> addresses.
>> In order to prove unique match you would need an exhaustive check, don't
>> you?
> 
> Yes, though you also do exhaustive check in the worst case already (when
> the name doesn't match anything). It takes about .7s on a warm cache on
> my git.git.
> 
> Anyway, I think it is already not a good idea because of the semantics,
> let alone the performance.

By "it" you are referring to
- checking for uniqueness or
- the whole approach combing through commits?

I'd be happy with the patch as is (+"-i" maybe) now that I understand
the template... (I tried --author=key with a key expanding to the
(default) committer, in which case the commit template does not show
author nor committer. Duh.)

> -Peff
> 
> PS Your message also didn't go to git@vger, so I think you are having
> the same problem with Michael's message that I am.

OK: I send this To: Jeff, Cc: Junio, Nntp:
gmane.comp.version-control.git (using Thunderbird 2). (This is the
result of hitting "reply all" and deleting git@vger, because it's
duplicated by gmane...git.)

Could the two of you please tell me what you are receiving? I'm sorry
for this, but if this is a systematic problem with gmane I should switch
(and others should be warned); if it's a TB thing I will cope.

Michael
