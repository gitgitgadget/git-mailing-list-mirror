From: Jeff King <peff@peff.net>
Subject: Re: cant get git to work over http
Date: Tue, 19 Feb 2008 14:57:45 -0500
Message-ID: <20080219195745.GB5427@coredump.intra.peff.net>
References: <20080219063937.GB3819@glandium.org> <e26d18e40802182309l693b2099wb42573aca7348091@mail.gmail.com> <alpine.LSU.1.00.0802191115440.30505@racer.site> <e26d18e40802191019j48a1ceadk4887ffc35100ab0a@mail.gmail.com> <47BB1EC0.601@freescale.com> <e26d18e40802191106v51c907bdn6aa51acef5f530a3@mail.gmail.com> <alpine.LSU.1.00.0802191916020.7797@racer.site> <e26d18e40802191127v7cc9f051l7002b56b41dc9f86@mail.gmail.com> <alpine.LSU.1.00.0802191940260.7826@racer.site> <e26d18e40802191153w691ac5fcl3fa972ca6503b9fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jon Loeliger <jdl@freescale.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Anatoly Yakovenko <aeyakovenko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 20:58:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRYbi-000822-1D
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 20:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625AbYBST5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 14:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753068AbYBST5t
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 14:57:49 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1129 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539AbYBST5s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 14:57:48 -0500
Received: (qmail 24921 invoked by uid 111); 19 Feb 2008 19:57:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 19 Feb 2008 14:57:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Feb 2008 14:57:45 -0500
Content-Disposition: inline
In-Reply-To: <e26d18e40802191153w691ac5fcl3fa972ca6503b9fb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74451>

On Tue, Feb 19, 2008 at 11:53:58AM -0800, Anatoly Yakovenko wrote:

> but for the life of me i cant do this:
> 
> $ git-clone http://aeyakovenko@localhost/var/www/localhost/htdocs/git/repo/ repo
> Initialized empty Git repository in /home/aeyakovenko/projects/repo/.git/
> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?

Is your webserver exporting "/"? Or should it be
"http://aeyakovenko@localhost/git/repo"? If the path is correct, did you
run git-update-server-info in the repository you are trying to clone?

-Peff
