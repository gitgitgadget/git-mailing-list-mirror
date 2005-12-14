From: Petr Baudis <pasky@suse.cz>
Subject: Re: Tracking files across tree reorganizations
Date: Wed, 14 Dec 2005 23:36:56 +0100
Message-ID: <20051214223656.GJ22159@pasky.or.cz>
References: <43A08B8F.1000901@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 23:39:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmfF7-0004zG-I7
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 23:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVLNWg6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 17:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbVLNWg6
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 17:36:58 -0500
Received: from w241.dkm.cz ([62.24.88.241]:59580 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965044AbVLNWg6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 17:36:58 -0500
Received: (qmail 1889 invoked by uid 2001); 14 Dec 2005 23:36:56 +0100
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <43A08B8F.1000901@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13651>

Hah, here we go again. :-)

Dear diary, on Wed, Dec 14, 2005 at 10:15:59PM CET, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> said that...
> Did anything ever happen with that?

Linus is against it.

Cogito will do it anyway ;-), when someone sends me a nice patch or when
I get to it (probably not very soon). I imagine it like this:

(a) User can explicitly note file moves / renames. We follow those notes.
Probably the most viable for recording the notes is appending them at
the tail of the commit message.

(b) If there are no notes for the given commit, we do the rename
autodetection already implemented in GIT. If it yields something,
we follow it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
