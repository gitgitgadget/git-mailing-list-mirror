From: Petr Baudis <pasky@suse.cz>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 15:08:55 +0100
Message-ID: <20070316140855.GE4489@pasky.or.cz>
References: <20070316042406.7e750ed0@home.brethil> <20070316045928.GB31606@spearce.org> <7vejnpycu1.fsf@assigned-by-dhcp.cox.net> <20070316104715.483df0d5@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Fri Mar 16 15:09:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSD77-0005UL-8P
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 15:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbXCPOI6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 10:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933257AbXCPOI6
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 10:08:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60903 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932495AbXCPOI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 10:08:57 -0400
Received: (qmail 29611 invoked by uid 2001); 16 Mar 2007 15:08:55 +0100
Content-Disposition: inline
In-Reply-To: <20070316104715.483df0d5@localhost>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42362>

On Fri, Mar 16, 2007 at 02:47:15PM CET, Luiz Fernando N. Capitulino wrote:
>  We could start by fixing the got-an-error-die behaivor and
> define a _experimental_ API (just a few functions) just to get
> data out of git.
> 
>  This would be enough to write the Perl binding I think?

Actually, well, I've already done this. :-)

The trouble begins when you want to access multiple repositories from
the same process, etc. Without that, writing the Perl binding is
trivial; there's already a hook the binding can use to catch dies, I've
added it.

So, the main point of the work is to define a _good_ API and get rid of
the static state, I guess.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
