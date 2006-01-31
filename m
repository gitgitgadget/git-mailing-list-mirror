From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 12:43:30 -0800
Message-ID: <7v8xsww2kt.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<1138529385.9919.185.camel@evo.keithp.com>
	<43DCA495.9040301@gorzow.mm.pl> <20060129181240.GA11721@kroah.com>
	<43DFAD91.4080105@gorzow.mm.pl> <43DFBF9A.2020409@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>, Keith Packard <keithp@keithp.com>,
	cworth@cworth.org, Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 21:43:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F42Lg-0007gI-VS
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 21:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWAaUne (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 15:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWAaUne
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 15:43:34 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:37512 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751469AbWAaUnd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 15:43:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060131204212.QXBC6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 Jan 2006 15:42:12 -0500
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
In-Reply-To: <43DFBF9A.2020409@gorzow.mm.pl> (Radoslaw Szkodzinski's message
	of "Tue, 31 Jan 2006 20:50:50 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15341>

Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl> writes:

> Radoslaw Szkodzinski wrote:
>> Cloning without -l option is much slower - some minutes vs below a minute.
>> I could have time(8)d it, but it's no use.
>> 
>
> Make that time(1)d.
>
> Results for the kernel follow. Disc cache has been preheated with find.

While you are at it, "git clone -l -s -n" might be more interesting.
