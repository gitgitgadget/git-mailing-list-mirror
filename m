From: Junio C Hamano <junkio@cox.net>
Subject: Re: git push to a non-bare repository
Date: Sun, 18 Mar 2007 21:14:44 -0700
Message-ID: <7vejnlna2z.fsf@assigned-by-dhcp.cox.net>
References: <vpq648ye9w6.fsf@olympe.imag.fr>
	<20070319020053.GA11371@thunk.org>
	<7vr6rmm1y9.fsf@assigned-by-dhcp.cox.net>
	<20070319022143.GF20658@spearce.org>
	<20070319024744.GD11371@thunk.org>
	<20070319025603.GG20658@spearce.org>
	<20070319033340.GG11371@thunk.org>
	<20070319034755.GH20658@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 05:14:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT9Go-00034K-3h
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 05:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbXCSEOq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 00:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933783AbXCSEOq
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 00:14:46 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:58124 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbXCSEOp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 00:14:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070319041445.TZRD18070.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 00:14:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cUEk1W00M1kojtg0000000; Mon, 19 Mar 2007 00:14:45 -0400
In-Reply-To: <20070319034755.GH20658@spearce.org> (Shawn O. Pearce's message
	of "Sun, 18 Mar 2007 23:47:55 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42584>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>   git-diff $old $new | git-apply --index ?
>
> If the patch does not apply, nothing gets updated.  If it does apply,
> the index is also updated and stat data updated.

And if you are only checking then perhaps instead of --index
use --check, so that the actual updates are deferred?
