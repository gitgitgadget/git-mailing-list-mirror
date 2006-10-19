From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 10:17:36 -0500
Message-ID: <20061019151736.GY75501@over-yonder.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca> <845b6e870610190002u420118b8ud634bb9594572c48@mail.gmail.com> <20061019113731.GC20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik B?gfors <zindar@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 17:18:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaZeQ-0000wu-Oq
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 17:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161449AbWJSPRj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 11:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161450AbWJSPRj
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 11:17:39 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:62189 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S1161449AbWJSPRi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 11:17:38 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id 1B5C52842A;
	Thu, 19 Oct 2006 10:17:37 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id 8879B61C52; Thu, 19 Oct 2006 10:17:36 -0500 (CDT)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20061019113731.GC20017@pasky.or.cz>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29356>

[ trim back CC a bit ]

On Thu, Oct 19, 2006 at 01:37:31PM +0200 I heard the voice of
Petr Baudis, and lo! it spake thus:
> 
> [...] you probably primarily show revnos everywhere and UUIDs only
> in few special places and/or when asked specifically through a
> command (correct me if I'm wrong).

The primary place you'd see either is in 'log'.  To show the UUID,
you'd add a "--show-ids" arg to it (and via per-user config aliasing,
you could just alias 'log' to 'log --show-ids' if you always wanted to
see them, so you wouldn't have to type it.  The output looks something
like:

revno: 1
revision-id: fullermd@over-yonder.net-20061019151437-5b99dff6ed1d76cd
committer: Matthew Fuller <fullermd@over-yonder.net>
branch nick: a
timestamp: Thu 2006-10-19 10:14:37 -0500
message:
  Foo

(without --show-ids, it's the same, except not showing the
revision-id: line)


> Also, do you support "UUID autocompletion" so that you can type just
> the unique UUID prefix instead of the whole thing?

With the form of bzr UUID's, that's not particularly useful, since
you're probably into the minutes/seconds of the timestamp before it
becomes unique, at which points you're close to 2/3 of the way through
the whole string.



-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.
