From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Thu, 19 Apr 2012 09:06:54 -0700
Message-ID: <xmqqzka7so2p.fsf@junio.mtv.corp.google.com>
References: <vpqwr5uceis.fsf@bauges.imag.fr>
	<20120406071520.GD25301@sigill.intra.peff.net>
	<vpqr4w12tjj.fsf@bauges.imag.fr>
	<20120406080004.GA27940@sigill.intra.peff.net>
	<4F7FF19B.1060407@alum.mit.edu>
	<20120407075150.GA18168@sigill.intra.peff.net>
	<7viphaygsg.fsf@alter.siamese.dyndns.org>
	<vpq62d6dyzr.fsf@bauges.imag.fr>
	<20120412075535.GC31122@sigill.intra.peff.net>
	<vpqhawp2wxs.fsf@bauges.imag.fr>
	<20120412081407.GE31122@sigill.intra.peff.net>
	<vpqfwc9wckl.fsf@bauges.imag.fr>
	<7vpqbdeyfh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 20:35:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKwCJ-00040d-Ng
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 20:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756275Ab2DSSfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 14:35:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:49339 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754738Ab2DSSfG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 14:35:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SKwC7-0003rH-KA
	for git@vger.kernel.org; Thu, 19 Apr 2012 20:35:03 +0200
Received: from 216-239-45-4.google.com ([216.239.45.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 20:35:03 +0200
Received: from gitster by 216-239-45-4.google.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 20:35:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 216-239-45-4.google.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:/5/WuX2DqLfZbOtQxMtB3k+CxkQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195960>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Jeff King <peff@peff.net> writes:
>> ...
>>> I don't have a strong opinion either way.
>>
>> No strong opinion either, but I wanted to raise the point to make sure
>> we agree.
>>
>> With your patch, "git push" fails with
>>
>>   fatal: The current branch branch-name has no upstream branch.
>>   To push the current branch and set the remote as upstream, use
>>   
>>       git push --set-upstream origin branch-name
>>
>> so it's not really bad: the suggestion guides the user to a situation
>> where the next "git push" will succeed unambiguously. As a side effect,
>> the next "git pull" will fetch from the same branch, which is probably
>> what the user wants if he hasn't explicitely configured an upstream
>> branch yet.
>
> Sounds sensible.

So what happened to this discussion?  Does anybody want to roll the "simple"
default based on Peff's patch?
