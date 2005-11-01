From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal bars
Date: Wed, 2 Nov 2005 00:43:02 +0100
Message-ID: <20051101234302.GD1431@pasky.or.cz>
References: <20051027203945.GC1622@pe.Belkin> <20051028015642.GA31822@vrfy.org> <20051028023833.GA19939@pe.Belkin> <20051101233035.GB1431@pasky.or.cz> <46a038f90511011533q177328fdrf4b0dd68f188282e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Shoemaker <c.shoemaker@cox.net>,
	Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 00:43:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX5mX-000828-BY
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 00:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbVKAXnF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 18:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVKAXnF
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 18:43:05 -0500
Received: from w241.dkm.cz ([62.24.88.241]:7355 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751441AbVKAXnE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 18:43:04 -0500
Received: (qmail 32757 invoked by uid 2001); 2 Nov 2005 00:43:02 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511011533q177328fdrf4b0dd68f188282e@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10974>

Dear diary, on Wed, Nov 02, 2005 at 12:33:38AM CET, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> told me that...
> On 11/2/05, Petr Baudis <pasky@suse.cz> wrote:
> > What about having the color indicate the number of affected files (let's
> > say on a blue..red scale) and the width the size of patch?
> 
> I'm a /little bit/ colour blind on the red scale -- so I vote for 2
> bars, each half the heigth of the current bar.  ;-)

That's certainly possible as well (if you make each of the bars of
different color), but for most people not equally visually obvious.
Perhaps we could have a knob at the bottom of the page, but that isn't
very satisfying a solution either... :-(

Another possibility is to make the height dynamic and in proportion with
the number of affected files. Or combine both the color and dynamic
height. I believe changing the color to red would make it appear as
black for the red-color-blind people?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
