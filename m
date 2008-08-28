From: Petr Baudis <pasky@suse.cz>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 23:53:35 +0200
Message-ID: <20080828215335.GA10360@machine.or.cz>
References: <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu> <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu> <20080828090421.GQ10360@machine.or.cz> <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu> <20080828212346.GA27867@coredump.intra.peff.net> <1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Teemu Likonen <tlikonen@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Thu Aug 28 23:54:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYpS0-0002S3-Ps
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 23:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756054AbYH1Vxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 17:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755835AbYH1Vxi
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 17:53:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52280 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756054AbYH1Vxh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 17:53:37 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 34EF43939B57; Thu, 28 Aug 2008 23:53:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94187>

It's getting repetitive. :-(

On Thu, Aug 28, 2008 at 02:41:52PM -0700, Perry Wagle wrote:
> I now have to TEST to find those crazy backwards-incompatibility bugs 
> before I can upgrade us to 1.6.0.  To test, I have to try to imagine what I 
> and others were assuming about git.  And this episode means that I can't 
> make any assumptions about the sanity of any changes since March, which is 
> the version I'm thinking of upgrading.

All changes of this kind, including this one, should be carefully
described in the release notes. Since you say you are effectively a Git
packager, you really should be one of the persons who do actually read
them. :-)

You can't ask us to stop making any incompatible changes - Git is still
too young for that and it's UI got evolved, not designed. But we do
document the changes we do, even though we might do a better job
*spreading* the word.

				Petr "Pasky" Baudis
