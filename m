From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to commit removed file?
Date: Fri, 05 Jan 2007 17:57:16 -0800
Message-ID: <7vzm8wapdv.fsf@assigned-by-dhcp.cox.net>
References: <20061231102444.GD26552@mellanox.co.il>
	<20070102201041.GB10451@mellanox.co.il>
	<Pine.LNX.4.63.0701022211100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfyatt8di.fsf@assigned-by-dhcp.cox.net>
	<87lkklgc8v.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 02:57:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H30oC-00024r-PE
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 02:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbXAFB5S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 20:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbXAFB5R
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 20:57:17 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:41102 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbXAFB5R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 20:57:17 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070106015716.BAOM97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 20:57:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7dwT1W00o1kojtg0000000; Fri, 05 Jan 2007 20:56:28 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87lkklgc8v.wl%cworth@cworth.org> (Carl Worth's message of "Tue,
	02 Jan 2007 16:55:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36069>

Carl Worth <cworth@cworth.org> writes:

> On Tue, 02 Jan 2007 13:40:41 -0800, Junio C Hamano wrote:
>> Personally I never saw the point of having "git rm".  Maybe we
>> should remove it to prevent this confusion from happening.
>
> The one place where it's really "necessary", (as opposed to some users
> just expecting it to be there), is to "undo" a git-add, (and I mean a
> git-add that actually adds a new path to the index, not one of these
> newfangled git-adds that simply updates content for an existing path).

"git reset" (i.e. --mixed) is the way to revert the index back
to HEAD and start over.
