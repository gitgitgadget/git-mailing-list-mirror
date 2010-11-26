From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: git-gui: commit message box doesn't respond to enter (only
 return)
Date: Sat, 27 Nov 2010 02:28:25 +0300
Message-ID: <20101126232825.GE3264@localhost.localdomain>
References: <20101126170956.25856.63131.reportbug@alsuren-thinkpad.cbg.collabora.co.uk>
 <20101126203855.GA23258@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>,
	David Laban <alsuren+debbugs@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 00:28:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM7ic-0003pl-SZ
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 00:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154Ab0KZX2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 18:28:37 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:40980 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab0KZX2h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 18:28:37 -0500
Received: from proxysrv.domain007.com ([10.8.0.42])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id oAQNSQip006641;
	Sat, 27 Nov 2010 02:28:27 +0300
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id 15B2BB22E5A; Sat, 27 Nov 2010 02:28:25 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <20101126203855.GA23258@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Scanned-By: MIMEDefang 2.51 (www.roaringpenguin.com/mimedefang) on 192.168.2.20
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162284>

On Fri, Nov 26, 2010 at 02:38:55PM -0600, Jonathan Nieder wrote:

> David Laban wrote at http://bugs.debian.org/605041:
> 
> > Package: git-gui
> > Version: 1:1.7.2.3-2
> > Severity: minor
> >
> > If I click into the messagebox and hit enter, nothing happens.
> >
> > This is annoying because if I'm adding a new paragraph to my commit message, 
> > I will often do <click> <enter><enter> <start typing as normal>
> >
> > Don't ask me why I do this. I think enter is a lighter/easier to press
> > key than return, and is also on the path that my hand takes between the mouse
> > and the rest of the keyboard.
> >
> > I have also provisionally reported the following bug in tk, but I feel like
> > a bit of a n00b for doing so.
> >
> > http://sf.net/tracker/?func=detail&aid=3119824&group_id=12997&atid=112997
> 
> I can't reproduce this because this laptop does not have a distinct
> "numpad enter" key.
I've tested it on Debian Squeeze and added another comment on the
upstream bug report. In short: KP_Enter is not bound to any action in
Tk text widgets in X11, at least in 8.5.9.

But git-gui can be trivially patched to support this; that would be a
one-lineer. So if it is desired and will be accepted, I could prepare a
patch.
