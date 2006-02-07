From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: git-http-push and hooks
Date: Tue, 7 Feb 2006 21:57:11 +0100
Message-ID: <20060207205709.GB7217@c165.ib.student.liu.se>
References: <20060206205203.GA20973@guybrush.melee> <20060206232231.GK3873@reactrix.com> <20060207195458.GA7217@c165.ib.student.liu.se> <20060207202351.GA3833@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	"Bertrand Jacquin (Beber)" <beber@guybrush.melee>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 21:57:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6Ztk-0005HE-1y
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 21:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWBGU5N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 15:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWBGU5N
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 15:57:13 -0500
Received: from [85.8.31.11] ([85.8.31.11]:5041 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932172AbWBGU5N (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 15:57:13 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id E3AB3411B; Tue,  7 Feb 2006 22:10:59 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1F6Ztf-0001yz-00; Tue, 07 Feb 2006 21:57:11 +0100
To: Nick Hengeveld <nickh@reactrix.com>
Content-Disposition: inline
In-Reply-To: <20060207202351.GA3833@reactrix.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15715>

On Tue, Feb 07, 2006 at 12:23:51PM -0800, Nick Hengeveld wrote:
> On Tue, Feb 07, 2006 at 08:54:58PM +0100, Fredrik Kuivinen wrote:
> 
> > I know basically nothing about DAV, but wouldn't it be possible to
> > have a CGI-script which executes the hooks upon the client's request?
> 
> It would, although if custom software can be run on the server you might
> as well run the git daemon.

You can't push to a git daemon, can you?

Furthermore, if the user has a working http/DAV server installed it
might be the case that she prefers to use that one instead of
installing a new daemon.

- Fredrik
