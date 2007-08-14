From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-apply: apply submodule changes
Date: Tue, 14 Aug 2007 02:09:35 -0700
Message-ID: <7vps1qcwj4.fsf@assigned-by-dhcp.cox.net>
References: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org>
	<20070812142340.GA10399MdfPADPa@greensroom.kotnet.org>
	<7vwsw0ipp2.fsf@assigned-by-dhcp.cox.net>
	<20070812185006.GG999MdfPADPa@greensroom.kotnet.org>
	<7vr6m8imj6.fsf@assigned-by-dhcp.cox.net>
	<20070813093740.GA4684@liacs.nl>
	<20070813171349.GL999MdfPADPa@greensroom.kotnet.org>
	<7vmywvfag3.fsf@assigned-by-dhcp.cox.net>
	<7vd4xqeilh.fsf@assigned-by-dhcp.cox.net>
	<20070814083940.GN999MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Johannes.Schindelin@gmx.de
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Tue Aug 14 11:09:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKsPJ-0005Wx-44
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 11:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbXHNJJk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 05:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbXHNJJj
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 05:09:39 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:33794 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbXHNJJh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 05:09:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070814090937.ZPKL24055.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 14 Aug 2007 05:09:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bl9b1X00l1kojtg0000000; Tue, 14 Aug 2007 05:09:36 -0400
In-Reply-To: <20070814083940.GN999MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Tue, 14 Aug 2007 10:39:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55818>

Sven Verdoolaege <skimo@kotnet.org> writes:

>> diff --git a/builtin-apply.c b/builtin-apply.c
>
> Did you remove the documentation on purpose ?

No, I just wanted to get a feedback on a (possibly partial)
cleanup, as I couldn't make heads or tails of your patch
especially around that TYPE_CHANGED part, and also the part to
write out the results.
