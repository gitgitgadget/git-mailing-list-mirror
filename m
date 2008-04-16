From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Friendly refspecs
Date: Tue, 15 Apr 2008 21:41:17 -0700
Message-ID: <7vabjuv2c2.fsf@gitster.siamese.dyndns.org>
References: <20080409101428.GA2637@elte.hu>
 <20080409145758.GB20874@sigill.intra.peff.net>
 <20080409200836.GA19248@mithlond>
 <20080409203453.GA10370@sigill.intra.peff.net>
 <20080409222500.GB19248@mithlond>
 <20080409225112.GB12103@sigill.intra.peff.net>
 <20080413093102.GC12107@mithlond.arda.local>
 <20080416034823.GA11727@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 16 07:49:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlzTM-0003Ma-FR
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 06:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbYDPElb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 00:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbYDPElb
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 00:41:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42810 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbYDPEla (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 00:41:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 803E62F6B;
	Wed, 16 Apr 2008 00:41:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BE9DC2F69; Wed, 16 Apr 2008 00:41:24 -0400 (EDT)
In-Reply-To: <20080416034823.GA11727@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 15 Apr 2008 23:48:23 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79668>

Jeff King <peff@peff.net> writes:

> On Sun, Apr 13, 2008 at 12:31:02PM +0300, Teemu Likonen wrote:
>
>> There is still one thing (at least) that I don't quite understand. It's
>> about "git push". When I do
>> 
>>   $ git push <remote> <branch>
>> 
>> the refs/heads/<branch> is updated or created on the remote side. But if
>> I do
>> 
>>   $ git push <remote> <branch1>:<branch2>
>> 
>> the refs/heads/<branch2> is not automatically created.

Eh, there is no way unless you force an assumption of a particular
workflow to everybody else.

What you would say on the second command is not literally "<branch2>" but
something like "work-in-progress", or "crap".  Even an AI would not be
able to guess if you wanted to create a branch on the other side, or
wanted to put a lightweight tag to let people know where you are (possibly
with the intention of removing it once you are done), and git is not an AI.
