From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: git-diff-files and fakeroot
Date: Tue, 17 Jan 2006 19:10:12 +0100
Message-ID: <20060117181012.GA8047@mars.ravnborg.org>
References: <43CC5231.3090005@michonline.com> <7vzmlvk2bs.fsf@assigned-by-dhcp.cox.net> <20060117052758.GA22839@mythryan2.michonline.com> <95E085A7-B910-4C01-BA6E-43971A6F5F97@mac.com> <43CC89F0.7060109@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 19:11:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyvIG-0007sI-EK
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 19:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWAQSKj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 13:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWAQSKj
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 13:10:39 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:52488 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932160AbWAQSK3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2006 13:10:29 -0500
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id 8A2F71EC329;
	Tue, 17 Jan 2006 19:10:17 +0100 (CET)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 5E3F843C2BA; Tue, 17 Jan 2006 19:10:12 +0100 (CET)
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <43CC89F0.7060109@michonline.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14802>

On Tue, Jan 17, 2006 at 01:08:48AM -0500, Ryan Anderson wrote:
> 
> I think I might take your suggestion, and fix up the builddeb script to
> do the "run as root" part itself, rather than needing to do it outside. 
> It would make it possible to just run "make oldconfig deb-pkg" which
> would make things a little bit simpler.
If we do something it must be consistent for all *-pkg targets.
So fixing up builddeb is not enough, we must fix it for rpm etc also.

Not that I have looked into what is needed, but we shall not have
inconsistent behavious between the different *-pkg targets.

	Sam
