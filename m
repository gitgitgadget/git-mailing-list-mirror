From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 20 Apr 2007 21:31:42 +0200
Message-ID: <20070420193142.GA13080@uranus.ravnborg.org>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net> <7vr6qlxexe.fsf@assigned-by-dhcp.cox.net> <7v647tcjr6.fsf@assigned-by-dhcp.cox.net> <20070419100757.GB27208@admingilde.org> <7vmz13z4au.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 21:31:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Heyoq-0007Ye-Mt
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 21:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767212AbXDTTax (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 15:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767217AbXDTTax
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 15:30:53 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:60719 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767212AbXDTTaw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 15:30:52 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 30764801117;
	Fri, 20 Apr 2007 21:30:51 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 1000)
	id 37E21580D5; Fri, 20 Apr 2007 21:31:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vmz13z4au.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45128>

On Fri, Apr 20, 2007 at 04:14:01AM -0700, Junio C Hamano wrote:
> 
> Making git.git the first guinea pig has a unique bootstrapping
> problem involved, however.  These kind of changes in git.git
> itself has to wait at least until what we have in 'next' today
> is in everybody's hands.  Otherwise, people who want to use git
> for their real work need to first grab a tarball snapshot that
> has the plumbing subproject support, and then update to
> 'master', because we are still too fast moving for any distro
> binary packaged version to be satisfactory solution for people
> who want to have all the bells and whistles.  Also, I cannot
> have subproject in git.git until kernel.org starts running git
> with subproject support -- otherwise nobody can clone or pull
> from git.git X-<.

The bootstrapping issue could be fixed by having a separate
git-subproject.git on kernel.org.

But I see no easy solution for the requireent for kernel.org to
a new git (and I doubt kernel.org sysadmin is too keen to
update to a next-based git).

	Sam
