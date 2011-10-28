From: Miles Bader <miles@gnu.org>
Subject: Re: git alias and --help
Date: Fri, 28 Oct 2011 10:51:56 +0900
Message-ID: <buoty6t9937.fsf@dhlpc061.dev.necel.com>
References: <j8clg9$ldh$1@dough.gmane.org>
 <7vfwiexe6m.fsf@alter.siamese.dyndns.org>
 <7v8vo6xd4u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Gelonida N <gelonida@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 03:52:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJbc5-0006du-V6
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 03:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190Ab1J1BwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 21:52:00 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:58839 "EHLO
	relmlor2.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab1J1Bv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 21:51:59 -0400
Received: from relmlir2.idc.renesas.com ([10.200.68.152])
 by relmlor2.idc.renesas.com ( SJSMS)
 with ESMTP id <0LTR006LA6IMNZ70@relmlor2.idc.renesas.com> for
 git@vger.kernel.org; Fri, 28 Oct 2011 10:51:58 +0900 (JST)
Received: from relmlac1.idc.renesas.com ([10.200.69.21])
 by relmlir2.idc.renesas.com ( SJSMS)
 with ESMTP id <0LTR00FRN6IMIM00@relmlir2.idc.renesas.com> for
 git@vger.kernel.org; Fri, 28 Oct 2011 10:51:58 +0900 (JST)
Received: by relmlac1.idc.renesas.com (Postfix, from userid 0)
	id 3A7A480086; Fri, 28 Oct 2011 10:51:58 +0900 (JST)
Received: from relmlac1.idc.renesas.com (localhost [127.0.0.1])
	by relmlac1.idc.renesas.com (Postfix) with ESMTP id 2CAB2800A4; Fri,
 28 Oct 2011 10:51:58 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac1.idc.renesas.com with ESMTP id LAR16415; Fri,
 28 Oct 2011 10:51:58 +0900
X-IronPort-AV: E=Sophos;i="4.69,415,1315148400";   d="scan'208";a="52179428"
Received: from unknown (HELO relay61.aps.necel.com) ([10.29.19.64])
 by relmlii1.idc.renesas.com with ESMTP; Fri, 28 Oct 2011 10:51:58 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.97.17])
	by relay61.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id p9S1puEI010816;
 Fri, 28 Oct 2011 10:51:56 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id C07E652E1FF; Fri,
 28 Oct 2011 10:51:56 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <7v8vo6xd4u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184336>

Junio C Hamano <gitster@pobox.com> writes:
>>> git branch --help
>>
>> How about "git help branch"?
>
> The reason why we do not do what you seem to be suggesting is because
> giving the same behaviour to "git b --help" as "git branch --help" is
> wrong.

I agree with Gelonida's followup:  although what you say makes sense,
it's still pretty annoying behavior for the very common case of a
simple renaming alias...

E.g., I have "co" aliased to "checkout", and so my fingers are very
very inclined to say "co" when I mean checkout... including when
asking for help.  I actually end up typing "git co --help", grumbling,
and retyping with the full command name, quite reguarly.

What I've often wished is that git's help system would output
something like:

   $ git help co
   `git co' is aliased to `checkout'

   Here's the help entry for `checkout':

   GIT-CHECKOUT(1)                   Git Manual                   GIT-CHECKOUT(1)

   NAME
          git-checkout - Checkout a branch or paths to the working tree
   ...

[with the "`git co' is aliased ..." header included in the pager
output.]

Of course, that would be the wrong thing for somebody that just wants
to be reminded what an alias expands too, but my intuition is that
this is a very tiny minority compared to people that want to examine
the options for the underlying command...

-Miles

-- 
Suburbia: where they tear out the trees and then name streets after them.
