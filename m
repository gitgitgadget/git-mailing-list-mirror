From: Gerrit Pape <pape@smarden.org>
Subject: Re: [ANNOUNCE] GIT 0.99.9l aka 1.0rc4
Date: Mon, 5 Dec 2005 18:26:01 +0100
Message-ID: <20051205172601.4980.qmail@67565db8368c55.315fe32.mid.smarden.org>
References: <7vy831p69i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Dec 05 18:28:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjK6A-0000Ml-DM
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 18:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbVLERZn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 12:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVLERZn
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 12:25:43 -0500
Received: from a.mx.smarden.org ([212.21.76.77]:12174 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S932467AbVLERZm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2005 12:25:42 -0500
Received: (qmail 4981 invoked by uid 1000); 5 Dec 2005 17:26:01 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vy831p69i.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13217>

On Sun, Dec 04, 2005 at 01:21:13AM -0800, Junio C Hamano wrote:
> *1* It appears Debian finally has an official maintainer, so I

Yes, I've taken over maintainership, and introduced the git-core package
into Debian/unstable, the git tools previously were included in the
cogito package.

> am inclined to stop building and supplying the debs starting
> from the next version --- one less thing to worry about for me.
> I hope the Debian side splits the packages along the same line
> as we do RPMs.

I'll do so and split off git-arch, git-cvs, git-svn, git-email from the
git-core package, as already done with gitk.  Additionally I have the
webdocs in a separate git-doc package, maybe that's a good idea for the
rpms also.

Regards, Gerrit.
