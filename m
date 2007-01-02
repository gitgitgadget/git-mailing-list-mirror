From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 01 Jan 2007 16:12:29 -0800
Message-ID: <7vhcva4782.fsf@assigned-by-dhcp.cox.net>
References: <20070101213906.GA23857@fieldses.org>
	<535252.4420.qm@web31811.mail.mud.yahoo.com>
	<20070102000606.GA32148@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Luben Tuikov <ltuikov@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Jan 02 01:12:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1XGd-0007h0-JR
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 01:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbXABAMc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 19:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbXABAMc
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 19:12:32 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:48238 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932616AbXABAMb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 19:12:31 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102001231.KLSQ29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Mon, 1 Jan 2007 19:12:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 60Ck1W00e1kojtg0000000; Mon, 01 Jan 2007 19:12:45 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20070102000606.GA32148@fieldses.org> (J. Bruce Fields's message
	of "Mon, 1 Jan 2007 19:06:06 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35755>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Mon, Jan 01, 2007 at 03:59:44PM -0800, Luben Tuikov wrote:
>> --- "J. Bruce Fields" <bfields@fieldses.org> wrote:
>> > +git pull origin next::
>> 
>> No.
>> 
>> > +	Merge into the current branch the remote branch `next`;
>> 
>> So, "origin" now means "current branch".
>
> No, "origin" refers to the remote repository that you originally cloned
> from.
>
> Pulls always merge into the current branch.  So it wouldn't make sense
> to specify the current branch on the command line.

I was also somewhat confused by these examples.  I think the
description is fine as long as we make it clear that they are
not meant to describe what an advanced user _could_ do with
various customizations, but to describe what happens with the
default configuration set up by git-clone.
