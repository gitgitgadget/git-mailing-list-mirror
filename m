From: Junio C Hamano <junkio@cox.net>
Subject: Re: Log message printout cleanups
Date: Mon, 17 Apr 2006 15:45:53 -0700
Message-ID: <7vodyzkehq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org>
	<7vbqv1oxie.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604171149330.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 00:46:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVcTn-00062Z-Cs
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 00:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWDQWpz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 18:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWDQWpz
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 18:45:55 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:65519 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751359AbWDQWpz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Apr 2006 18:45:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060417224554.EFCI18224.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 17 Apr 2006 18:45:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604171149330.3701@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 17 Apr 2006 11:59:32 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18840>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 16 Apr 2006, Junio C Hamano wrote:
>> 
>> In the mid-term, I am hoping we can drop the generate_header()
>> callchain _and_ the custom code that formats commit log in-core,
>> found in cmd_log_wc().
>
> Ok, this was nastier than expected, just because the dependencies between 
> the different log-printing stuff were absolutely _everywhere_, but here's 
> a patch that does exactly that.

I like the new cmd_log_wc() loop very much; I was planning to do
this myself, but I was too slow ;-).

Thanks.
