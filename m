From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Clean up compatibility definitions.
Date: Mon, 05 Dec 2005 23:58:34 -0800
Message-ID: <7v8xuy64id.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com>
	<81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
	<7vfyp7cuii.fsf@assigned-by-dhcp.cox.net>
	<7voe3vb8fh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512052135260.5944@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vk6ejb72r.fsf@assigned-by-dhcp.cox.net>
	<20051205213929.GB4443@steel.home>
	<81b0412b0512052335i43da5d34xf2ef78e66e40c6ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 08:59:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjXin-0004yz-R5
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 08:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbVLFH6h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 02:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVLFH6h
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 02:58:37 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:9919 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932489AbVLFH6g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 02:58:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206075721.ZTHW17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 02:57:21 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0512052335i43da5d34xf2ef78e66e40c6ee@mail.gmail.com>
	(Alex Riesen's message of "Tue, 6 Dec 2005 08:35:19 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13265>

Alex Riesen <raa.lkml@gmail.com> writes:

> On 12/5/05, Alex Riesen <raa.lkml@gmail.com> wrote:
>> Junio C Hamano, Mon, Dec 05, 2005 21:51:56 +0100:
>> > >> This attempts to clean up the way various compatibility
>> > >> functions are defined and used.
>> > >
>> > > You sure you want that before 1.0?
>> >
>> > I think this is mostly an obvious clean-up, but I do not have
>> > enough test environments, so ...
>> I will do cygwin. Tomorrow, that is.
>
> The patch works on cygwin. I let the tests run, too.

Thanks.  I've had a chance to try the one in the "master" branch
on cygwin myself today and it seemed to work OK.  I did a
partial build on Solaris 5.9 as well.
