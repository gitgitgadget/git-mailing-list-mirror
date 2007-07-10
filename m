From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Add for_each_remote() function, and extend remote_find_tracking()
Date: Tue, 10 Jul 2007 11:38:36 -0700
Message-ID: <7vtzscqf2r.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
	<7vhcof2rur.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707081336020.4248@racer.site>
	<7vzm2620wp.fsf@assigned-by-dhcp.cox.net> <46919692.5020708@gnu.org>
	<7vhcoexqeh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707091228290.5546@racer.site>
	<7v4pkduw2f.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707092203100.5546@racer.site>
	<7vzm25tex6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707100401070.4131@racer.site>
	<7vy7hosv7v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707101848050.4047@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 20:39:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8KcH-0007Pd-Rt
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 20:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764228AbXGJSij (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 14:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752695AbXGJSij
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 14:38:39 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:35858 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250AbXGJSii (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 14:38:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070710183835.IIII1393.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 10 Jul 2007 14:38:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Muec1X00K1kojtg0000000; Tue, 10 Jul 2007 14:38:37 -0400
In-Reply-To: <Pine.LNX.4.64.0707101848050.4047@racer.site> (Johannes
	Schindelin's message of "Tue, 10 Jul 2007 18:48:40 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52106>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The function for_each_remote() does exactly what the name suggests.
>
> The function remote_find_tracking() was extended to be able to search
> remote refs for a given local ref.  You have to set the parameter
> "reverse" to true for that behavior.

The updated patch does not use "reverse" but the old description
is still there.

Daniel, one thing I fear about your "I want to store the message
in the object store so that I can reuse even after I re-polish
the series" desire on the cover letter topic is this kind of
gotcha, and that is why I suggested "*** BLURB GOES HERE ***".
Both the summary (diffstat and shortlog) part and the
description part should be kept fresh in the updated 0/N; while
we can automate the summary part whenever we re-generate 0/N,
you cannot automate the description part.
