From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Per-path attribute based hunk header selection.
Date: Sun, 08 Jul 2007 22:05:35 -0700
Message-ID: <7vd4z2xj34.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
	<alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
	<7vejjnhpap.fsf@assigned-by-dhcp.cox.net>
	<7vwsxfe96i.fsf@assigned-by-dhcp.cox.net>
	<7vlkdve93o.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707051223520.9789@racer.site>
	<7v8x9uexji.fsf_-_@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0707061051020.9434@woody.linux-foundation.org>
	<7v8x9tdlbv.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0707082320480.26459@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jul 09 07:05:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7lRS-0004m8-24
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 07:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbXGIFFi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 01:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbXGIFFh
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 01:05:37 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44472 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbXGIFFg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 01:05:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709050537.UPGF11062.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Jul 2007 01:05:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MH5b1X00D1kojtg0000000; Mon, 09 Jul 2007 01:05:36 -0400
In-Reply-To: <alpine.LFD.0.999.0707082320480.26459@xanadu.home> (Nicolas
	Pitre's message of "Sun, 08 Jul 2007 23:22:41 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51951>

Nicolas Pitre <nico@cam.org> writes:

> On Fri, 6 Jul 2007, Junio C Hamano wrote:
>
>> About the comment from Johannes regarding hunk_header vs
>> funcname, I would actually prefer hunk_header, since that is
>> what this is about ("funcname" and "find_func" were misnomer
>> from the beginning), but I'd rename hunk_header to funcname for
>> the sake of consistency and minimizing the diff.
>
> I think "minimizing the diff" in this case is a bad reason.  Using 
> hunk_header is so much better than funcname IMHO.

Well, even then it turns out to be a good reason, as the patch
to rename function and field can be a separate patch.  After
adding that "latex pattern" stuff, I am even more inclined to
rename them.
