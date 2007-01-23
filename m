From: Andre Masella <andre@masella.no-ip.org>
Subject: Re: Repository Security
Date: Tue, 23 Jan 2007 08:23:17 -0500
Message-ID: <200701230823.17938.andre@masella.no-ip.org>
References: <200701221433.13257.andre@masella.no-ip.org> <Pine.LNX.4.63.0701231036400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 14:23:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Lce-0008BM-14
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 14:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbXAWNXY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 08:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbXAWNXX
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 08:23:23 -0500
Received: from tomts20.bellnexxia.net ([209.226.175.74]:42681 "EHLO
	tomts20-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965050AbXAWNXV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jan 2007 08:23:21 -0500
Received: from masella.no-ip.org ([74.14.39.184])
          by tomts20-srv.bellnexxia.net
          (InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP
          id <20070123132320.SBDP24907.tomts20-srv.bellnexxia.net@masella.no-ip.org>;
          Tue, 23 Jan 2007 08:23:20 -0500
Received: by masella.no-ip.org (Postfix, from userid 1003)
	id D7A76508FB; Tue, 23 Jan 2007 08:23:18 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0701231036400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37516>

> > As I understand it, none of the repository backends allow any per-user
> > per-branch access control.
> The idea in git (unless you really want to get the same setup as in CVS,
> which would be rather sad) is that every developer has at least one
> repository. Write-access: only one developer.

Believe me: I was ready to throw a party when I got to shutdown CVS last week.

Say I have two utterly separate repositories with two integrators. I want to 
put them on a web server (and so same DAV share). There is little to stop the 
integrator of one project (by intention or accident) from modifying the other 
repository. It can be done, but doing it requires one section of the 
httpd.conf per repository.

Using SSH requires many real user accounts on the system and then if there are 
more than one integrator, groups to administrate.

> I already hear the complaint: "But you need a central repository!". If you
> _have_ to have a central repository, designate the integrator's repository
> central.

Okay, say one regular developer wants share his changes with another 
developer. He either has to mail patches, create an SSH account, or set up 
one of git-daemon or WebDAV. And most of those require knowing the 
workstation name which is inconvienient. I would rather have each user able 
to push to a branch with their name on it on a central server.
-- 
--Andre Masella (andre at masella.no-ip.org)
