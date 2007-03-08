From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git push failure with update hook success
Date: Thu, 08 Mar 2007 01:54:34 -0800
Message-ID: <7vvehc9i1x.fsf@assigned-by-dhcp.cox.net>
References: <17902.59497.831409.218529@lisa.zopyra.com>
	<20070307170904.GB27922@spearce.org>
	<17902.62836.920473.810183@lisa.zopyra.com>
	<200703080922.54978.andyparkins@gmail.com>
	<20070308092809.GE30289@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Bill Lear <rael@zopyra.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 10:54:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPFKk-0003bu-Cy
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 10:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbXCHJyh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 04:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030524AbXCHJyg
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 04:54:36 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:53358 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030455AbXCHJyg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 04:54:36 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070308095436.ZPWM2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Mar 2007 04:54:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Y9ub1W0021kojtg0000000; Thu, 08 Mar 2007 04:54:35 -0500
In-Reply-To: <20070308092809.GE30289@spearce.org> (Shawn O. Pearce's message
	of "Thu, 8 Mar 2007 04:28:09 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41727>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Andy Parkins <andyparkins@gmail.com> wrote:
>> Without adding some nasty switches to git-rev-list 
>> (like --all-except-this-branch), I can't see how the post-update hook could 
>> ever send emails with the necessary amount of detail.
>
> Which is why `master` now has support for a post-receive hook,
> that has the magic three parameters.  ;-)

... but do not use that yet, as its public interface will change
to take the refs parameters in different ways (and the final
interface still under discussion).
