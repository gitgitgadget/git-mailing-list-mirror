From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Fri, 25 May 2007 15:11:12 -0700
Message-ID: <7vsl9kpn9b.fsf@assigned-by-dhcp.cox.net>
References: <20070518220826.GM942MdfPADPa@greensroom.kotnet.org>
	<20070518224209.GG10475@steel.home>
	<7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
	<20070519130542.GR942MdfPADPa@greensroom.kotnet.org>
	<7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net>
	<20070520155407.GC27087@efreet.light.src>
	<7vbqgfmjki.fsf@assigned-by-dhcp.cox.net>
	<20070521165938.GA4118@efreet.light.src>
	<20070521211133.GD5412@admingilde.org>
	<7viraixeme.fsf@assigned-by-dhcp.cox.net>
	<20070525203505.GB4493@efreet.light.src>
	<7vwsywpqaj.fsf@assigned-by-dhcp.cox.net>
	<46575220.2070604@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>, Martin Waitz <tali@admingilde.org>,
	skimo@liacs.nl, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat May 26 00:11:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hri0I-0003Fa-7K
	for gcvg-git@gmane.org; Sat, 26 May 2007 00:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbXEYWLQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 18:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbXEYWLQ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 18:11:16 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:60094 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbXEYWLP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 18:11:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070525221114.GNBU2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 25 May 2007 18:11:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3aBD1X0081kojtg0000000; Fri, 25 May 2007 18:11:13 -0400
In-Reply-To: <46575220.2070604@midwinter.com> (Steven Grimm's message of "Fri,
	25 May 2007 14:16:16 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48425>

Steven Grimm <koreth@midwinter.com> writes:

> Junio C Hamano wrote:
>> If you were doing an efficient cgi script that renders history
>> of git managed projects, binding git as its subproject, and that
>> system can be built with either 'maint' (i.e. 1.5.2 series) or
>> 'master' (i.e. ultrastable WIP towards 1.5.3), even though they
>> both might come from git://git.kernel.org/pub/scm/git/git.git/,
>> I think they should be registered as two separate logical
>> subprojects.
>
> I agree strongly with this, and it's another good reason that we have
> to be able to use something other than the URL as the key to look up a
> subproject's repository location. If you use the URL it is impossible
> to differentiate the two subprojects in this case.

Heh, you do not have to rub it in ;-)  I already agreed that
your three-level arrangement is easier to work with.
