From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-rev-list bug?
Date: Fri, 10 Mar 2006 14:42:03 -0800
Message-ID: <7voe0dylac.fsf@assigned-by-dhcp.cox.net>
References: <b0943d9e0603080819i227c637fo@mail.gmail.com>
	<7vacc0iten.fsf@assigned-by-dhcp.cox.net>
	<7vmzfy1zjb.fsf@assigned-by-dhcp.cox.net>
	<7virqmzlhb.fsf@assigned-by-dhcp.cox.net>
	<7v4q26zklx.fsf@assigned-by-dhcp.cox.net>
	<7vslpqy4u7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603101030160.18022@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 10 23:42:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHqJF-0006WA-JS
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 23:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbWCJWmG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 17:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbWCJWmG
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 17:42:06 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:10206 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1752010AbWCJWmF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 17:42:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060310224211.NYVS25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Mar 2006 17:42:11 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603101030160.18022@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 10 Mar 2006 10:31:31 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17484>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 10 Mar 2006, Junio C Hamano wrote:
>> 
>> So we would need a combination of both, something like this?
>
> Looks good to me.
>
> As does the 'revs.prune_fn' abstraction by Fredrik Kuivinen, for that 
> matter. Ack to both.

Thanks.  I'm swamped by day-job today so will apply it sometime
tomorrow.
