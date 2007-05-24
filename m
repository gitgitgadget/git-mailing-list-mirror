From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Thu, 24 May 2007 13:59:56 -0700
Message-ID: <7vps4quecz.fsf@assigned-by-dhcp.cox.net>
References: <7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net>
	<20070520155407.GC27087@efreet.light.src>
	<7vbqgfmjki.fsf@assigned-by-dhcp.cox.net>
	<20070521165938.GA4118@efreet.light.src>
	<20070521211133.GD5412@admingilde.org>
	<7viraixeme.fsf@assigned-by-dhcp.cox.net>
	<20070524184549.GW942MdfPADPa@greensroom.kotnet.org>
	<7vy7jevyjx.fsf@assigned-by-dhcp.cox.net>
	<20070524191438.GZ942MdfPADPa@greensroom.kotnet.org>
	<7vy7jeufmn.fsf@assigned-by-dhcp.cox.net>
	<20070524205535.GP4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven Verdoolaege <skimo@kotnet.org>,
	Martin Waitz <tali@admingilde.org>, Jan Hudec <bulb@ucw.cz>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 24 23:00:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrKPn-0007sY-Cz
	for gcvg-git@gmane.org; Thu, 24 May 2007 23:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbXEXU77 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 16:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbXEXU77
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 16:59:59 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:33963 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbXEXU76 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 16:59:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070524205958.NSZB15717.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 May 2007 16:59:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 38zw1X00U1kojtg0000000; Thu, 24 May 2007 16:59:57 -0400
In-Reply-To: <20070524205535.GP4489@pasky.or.cz> (Petr Baudis's message of
	"Thu, 24 May 2007 22:55:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48307>

Petr Baudis <pasky@suse.cz> writes:

> On Thu, May 24, 2007 at 10:32:32PM CEST, Junio C Hamano wrote:
> ...
>> It's just bare/pure layout is easier to understand because it is
>> essentially a "mirror" of the upstream.
>
> I OTOH think that it's less confusing to just keep it the same for all
> the normal repositories - and you yourself did not rule out the
> possibility to have local changes in the repository, in which case we
> certainly should use the separate-remotes layout or we go back to last
> year's refs mess.

That "local changes in the repository" will happen in the clone
created in kernel-src/ directory and I do not have any problem
using separate remotes there.  I was talking about the refs
layout used in .git/subproject/kernel26/, which is a mirror of
the upstream and the clone source for that (temporarily checked
out) repository at kernel-src/ directory.  After all, the
"mirror" is where you would push your local changes back into,
and it is more common to use non-separate-remote layout (without
even 'master'->'origin' mapping, hence I had to come up with a
new name 'pure', but I realize that what I meant really is a
'mirror') there.
