From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] describe: Add unlisted option
Date: Mon, 23 Jul 2007 00:41:13 -0700
Message-ID: <7vabtnmusm.fsf@assigned-by-dhcp.cox.net>
References: <87sl7fmyca.wl@mail2.atmark-techno.com>
	<20070723070308.GH32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yasushi SHOJI <yashi@atmark-techno.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 09:41:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICsXg-00071M-ER
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 09:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758431AbXGWHlR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 03:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791AbXGWHlQ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 03:41:16 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:39056 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757602AbXGWHlP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 03:41:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070723074113.WUBQ1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Jul 2007 03:41:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SvhD1X00P1kojtg0000000; Mon, 23 Jul 2007 03:41:14 -0400
In-Reply-To: <20070723070308.GH32566@spearce.org> (Shawn O. Pearce's message
	of "Mon, 23 Jul 2007 03:03:08 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53403>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Yasushi SHOJI <yashi@atmark-techno.com> wrote:
>> added unlisted options, --contains, --candidates and --debug, to usage
>> line.  also, prints some info when --contains and --debug are given.
>
> That makes sense.  Especially telling the user why --debug --contains
> doesn't actually print anything.  ;-)
>
> Originally I left out --candidates and --debug when I wrote the code
> for them as I thought they were a tad too internal for casual use.
> But maybe it makes sense to include them in the usage string.

I was actually going to suggest removing these options, that
were primarily meant for debugging and tweaking while we figure
out what the optimum default should be.  Do you think they are
worth keeping?
