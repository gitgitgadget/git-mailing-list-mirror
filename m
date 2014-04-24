From: David Kastrup <dak@gnu.org>
Subject: Re: Harmful LESS flags
Date: Fri, 25 Apr 2014 00:44:38 +0200
Message-ID: <87ha5i9wkp.fsf@fencepost.gnu.org>
References: <4dc69237123e8962b2b2b901692ea78e.id@mailtor>
	<87lhuvb9kr.fsf@fencepost.gnu.org>
	<xmqqha5iv9eb.fsf@gitster.dls.corp.google.com>
	<87tx9ia5zq.fsf@fencepost.gnu.org>
	<xmqq8uquv84u.fsf@gitster.dls.corp.google.com>
	<20140424213529.GB7815@sigill.intra.peff.net>
	<87lhuu9z69.fsf@fencepost.gnu.org>
	<20140424221308.GA15061@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, d9ba@mailtor.net,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 25 00:45:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdSO5-0005iq-Ar
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 00:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756447AbaDXWo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 18:44:56 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:55631 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755883AbaDXWoy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 18:44:54 -0400
Received: from localhost ([127.0.0.1]:54672 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WdSNw-0005sm-Pq; Thu, 24 Apr 2014 18:44:53 -0400
Received: by lola (Postfix, from userid 1000)
	id 2B36EE0996; Fri, 25 Apr 2014 00:44:38 +0200 (CEST)
In-Reply-To: <20140424221308.GA15061@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 24 Apr 2014 18:13:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247017>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 24, 2014 at 11:48:30PM +0200, David Kastrup wrote:
>
>> > I really think the right solution here is to teach less to make it more
>> > obvious that there is something worth scrolling over to. Here's a very
>> > rough patch for less, if you want to see what I'm thinking of.
>> 
>> Still useless.  I'm not actually interested in a more prominent "I could
>> be useful" indicator.
>
> So don't set -S, then.

I don't.  Git does it unasked for.

> There are two questions here:
>
>   1. Can less do a better job of indicating what's in the input when -S
>      is in effect?
>
>   2. What should get put into $LESS by default?
>
> I was specifically addressing (1). Your comment does not help at all
> there.
>
> It could have an impact on (2), but you didn't say anything besides "I
> don't like it". That doesn't add anything to the conversation.

No, I said it is useless, which is different from "I don't like it".
The information is not copy&pastable from a terminal window since it is
cut off.  It is also useless for review since one does not actually know
what's in there.  The only thing it has going for it is that it's
prettier than the actually usable information.  Which might sometimes be
nice if one is not interested overly in the payload, like when using
--graph.  But then even a graph display wants to get copy&pasted into
windows with a different size from the terminal window, like in
<URL:http://code.google.com/p/lilypond/issues/detail?id=3723#c7>.

-- 
David Kastrup
