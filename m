From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 05:00:28 -0500
Message-ID: <20061022100028.GQ75501@over-yonder.net>
References: <45382120.9060702@utoronto.ca> <87irie1wvv.wl%cworth@cworth.org> <20061021130111.GL75501@over-yonder.net> <87ac3p1jn7.wl%cworth@cworth.org> <1161472030.9241.174.camel@localhost.localdomain> <20061021192539.4a00cc3e.seanlkml@sympatico.ca> <1161478005.9241.210.camel@localhost.localdomain> <20061021212645.2f9ba751.seanlkml@sympatico.ca> <1161487417.9241.220.camel@localhost.localdomain> <20061021233014.d4525a1d.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Licquia <jeff@licquia.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 12:00:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gba8A-0000zH-JS
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 12:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWJVKAb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 06:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWJVKAb
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 06:00:31 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:29397 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S932321AbWJVKAa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 06:00:30 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id 543532842F;
	Sun, 22 Oct 2006 05:00:29 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id C548F61C5A; Sun, 22 Oct 2006 05:00:28 -0500 (CDT)
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20061021233014.d4525a1d.seanlkml@sympatico.ca>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29714>

On Sat, Oct 21, 2006 at 11:30:14PM -0400 I heard the voice of
Sean, and lo! it spake thus:
> On Sat, 21 Oct 2006 23:23:37 -0400
> Jeff Licquia <jeff@licquia.org> wrote:
> > 
> > OK.  So you are conflating the two.  Could someone who isn't
> > comment?
> 
> No, actually i'm not.  Single revno's or your dotted revno's _both_
> have the same property.

I think Jeff's actually meaning the other way around.  We're confident
through experience of the utility of the single revnos.  We're NOT (at
least, I'm not) so convinced of the utility and usability of the
dotted ones; they haven't gone through the crucible of experience yet.

During the dotted-decimal discussion, I favored numbering from the
merge point (rather than the ancestral point) for a lot of the same
reasons brought up here.  e.g., the log-ish output would look
something like:

200
199
 199.3
 199.2
 199.1
198
[...]

See <https://lists.ubuntu.com/archives/bazaar-ng/2006q3/017773.html>
for instance.

Of course, now we have them, and they  number from ancestors.  So
after that's in a couple releases, we'll get to see how it works in
practice.


-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.
