From: Petr Baudis <pasky@suse.cz>
Subject: Re: Latest cogito broken with bash-3.1
Date: Mon, 12 Dec 2005 01:59:44 +0100
Message-ID: <20051212005944.GX22159@pasky.or.cz>
References: <1134220724.15125.4.camel@blade> <20051211001106.GV22159@pasky.or.cz> <1134289867.9541.9.camel@blade> <20051212002631.GW22159@pasky.or.cz> <46a038f90512111658x5fe3198ey38515fc2745dd42b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcel Holtmann <marcel@holtmann.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 02:01:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Elc2h-0001Rp-4m
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 01:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbVLLA7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 19:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbVLLA7s
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 19:59:48 -0500
Received: from w241.dkm.cz ([62.24.88.241]:52655 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750984AbVLLA7s (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2005 19:59:48 -0500
Received: (qmail 2949 invoked by uid 2001); 12 Dec 2005 01:59:44 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90512111658x5fe3198ey38515fc2745dd42b@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13511>

Dear diary, on Mon, Dec 12, 2005 at 01:58:00AM CET, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> On 12/12/05, Petr Baudis <pasky@suse.cz> wrote:
> >   Then that's quite funny, one-line broken pipe message has been always
> > there (in the past it looked much worse, we thankfully managed to bring
> > it down to this at least).
> 
> I assume there's no reasonable workaround to that then?

The trapping is apparently the best we can do - at least I know of
nothing better.

> What would take to get rid of that (say, if I had a boring weekend ;)?

Fixing bash, IIRC - and more importantly, convincing its maintainers to
take the patch. ;-) Sometime in the spring someone even posted the exact
location in bash where this is broken.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
