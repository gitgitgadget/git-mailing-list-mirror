From: Junio C Hamano <junkio@cox.net>
Subject: Re: Wine + GIT
Date: Tue, 06 Dec 2005 09:33:02 -0800
Message-ID: <7vacfe2ks1.fsf@assigned-by-dhcp.cox.net>
References: <4394CD68.8020500@codeweavers.com> <4394F173.6000505@pobox.com>
	<20051206170803.GD17457@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 18:37:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejggi-0008US-CA
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 18:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVLFRdF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 12:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbVLFRdF
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 12:33:05 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:34298 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932353AbVLFRdD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 12:33:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206173140.CMRF26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 12:31:40 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20051206170803.GD17457@fieldses.org> (J. Bruce Fields's message
	of "Tue, 6 Dec 2005 12:08:03 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13282>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Mon, Dec 05, 2005 at 09:03:31PM -0500, Jeff Garzik wrote:
>> 2) The "git-foo" commands are apparently uncool.  "git foo ..." is 
>> preferred.
>
> How does e.g. git-diff differ from git diff?  I thought they were
> equivalent.--b.

For now, but to futureproof your document and its readers, it is
better spelled as "git frotz" not "git-frotz".

There is a long time-horizon plan to move most of the things out
of /usr/bin/, and codewise we have the infrastructure to do it
today. The only reason we haven't done so is that it would break
scripts written by people who learned git from documents that
tell them to write things in dash form, "git-diff".
