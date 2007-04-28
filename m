From: Junio C Hamano <junkio@cox.net>
Subject: Re: FEATURE REQUEST: git-format-path: Add option to encode patch content
Date: Fri, 27 Apr 2007 17:53:49 -0700
Message-ID: <7vtzv1l3oi.fsf@assigned-by-dhcp.cox.net>
References: <ps5qyry4.fsf@cante.net> <7vslalmwcx.fsf@assigned-by-dhcp.cox.net>
	<87y7kdo6pn.wl%cworth@cworth.org>
	<alpine.LFD.0.98.0704271430490.9964@woody.linux-foundation.org>
	<87wszxo2b5.wl%cworth@cworth.org>
	<alpine.LFD.0.98.0704271636130.9964@woody.linux-foundation.org>
	<87tzv1nzd4.wl%cworth@cworth.org>
	<alpine.LFD.0.98.0704271719240.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, Jari Aalto <jari.aalto@cante.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 28 02:53:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhbCE-00088U-UO
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 02:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbXD1Axv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 20:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754680AbXD1Axv
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 20:53:51 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:43810 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbXD1Axu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 20:53:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070428005350.BVMX1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Apr 2007 20:53:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id sQtp1W0081kojtg0000000; Fri, 27 Apr 2007 20:53:49 -0400
In-Reply-To: <alpine.LFD.0.98.0704271719240.9964@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 27 Apr 2007 17:20:48 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45764>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 27 Apr 2007, Carl Worth wrote:
>> > And the reason I _hate_ attachements is that you cannot say "no, that one
>> > is wrong", and just skip/edit it.
>> 
>> Well, skipping it while applying the rest is bad form anyway, isn't
>> it?
>
> Why would it be?
>
> Maybe for small projects with strictly linear development, but I get a 
> _lot_ of patch-series where the patches are independent of each other. 
> Andrew's patch-series are one example, but so is a lot of the "trivial 
> tree" patch-series too.

Seconded, even for a small project like git.git, I do that all
the time.
