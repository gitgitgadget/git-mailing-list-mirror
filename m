From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Draft release notes for v1.5.3, as of -rc1
Date: Fri, 13 Jul 2007 08:31:10 -0700
Message-ID: <7v644opbgh.fsf@assigned-by-dhcp.cox.net>
References: <7vmyzv1acz.fsf@assigned-by-dhcp.cox.net>
	<7vejl0546b.fsf@assigned-by-dhcp.cox.net>
	<7v4plqoyg5.fsf@assigned-by-dhcp.cox.net>
	<7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net>
	<7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com>
	<7vy7idydqa.fsf@assigned-by-dhcp.pobox.com>
	<7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com>
	<7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net>
	<7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net>
	<7vlkdkq00o.fsf_-_@assigned-by-dhcp.cox.net>
	<20070713135034.GK19073@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bdowning@lavos.net (Brian Downing)
X-From: git-owner@vger.kernel.org Fri Jul 13 17:31:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9N71-0004Q1-G2
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 17:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbXGMPbM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 11:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761248AbXGMPbM
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 11:31:12 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:48995 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822AbXGMPbL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 11:31:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070713153111.LQWP1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 13 Jul 2007 11:31:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id P3XA1X00D1kojtg0000000; Fri, 13 Jul 2007 11:31:10 -0400
In-Reply-To: <20070713135034.GK19073@lavos.net> (Brian Downing's message of
	"Fri, 13 Jul 2007 08:50:34 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52398>

bdowning@lavos.net (Brian Downing) writes:

> On Thu, Jul 12, 2007 at 11:40:39PM -0700, Junio C Hamano wrote:
>> GIT v1.5.3 Release Notes (draft)
>> ========================
>> 
>> * New commands and options.
>
>   - "git repack" learned a "window-memory" limit which dynamically
>     reduces the window size to stay within the specified memory usage.

Thanks.

> "git-repack -a -d -f --window=100000 --window-memory=512m" seems to be
> good for those overnight make-it-smaller-damn-the-torpedoes archival
> repackings.  (You can't just set --window to BIGNUM as it still
> allocates an array of that size.)  Thanks to Nicolas Pitre's depth bias
> patch a high --depth doesn't seem to be quite as critical anymore to
> save space; it still helps, but things much much better at a lower
> depth.

This probably should go to Documentation/git-repack.txt
somewhere.
