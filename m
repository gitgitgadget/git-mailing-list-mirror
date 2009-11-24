From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git init --bare --shared=group
Date: Tue, 24 Nov 2009 14:25:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911241424280.4758@intel-tinevez-2-302>
References: <34f8975d0911240505k4727fef2n8ef0efd3533aef1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Schaefer <eric.schaefer@ericschaefer.org>
X-From: git-owner@vger.kernel.org Tue Nov 24 14:26:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCvPB-0004M0-08
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 14:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758073AbZKXNZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 08:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758070AbZKXNZx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 08:25:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:33062 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758065AbZKXNZx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 08:25:53 -0500
Received: (qmail invoked by alias); 24 Nov 2009 13:25:57 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp040) with SMTP; 24 Nov 2009 14:25:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/p61pByOvpw70WE5rIFLmk4OBQg4Z79ci6JYq2HN
	ex/miXEFSNo++Q
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <34f8975d0911240505k4727fef2n8ef0efd3533aef1e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133577>

Hi,

On Tue, 24 Nov 2009, Eric Schaefer wrote:

> according to 'git help init' would --shared=group "Make the repository
> group-writable".
> I extracted a bare repo out of my local repo and scp'ed it to the
> server. There I did a 'git init --bare --shared=group'. It created the
> branches dir (there were no branches yet) and the config file and set
> the correct permissions. But it did not do so with the existsing files
> and dirs. Is it suffient to 'chmod -R g+ws .' or is there anything
> else to do to make the repo writeable for my group?

That should be enough, if all files and directories belong to the correct
group.  Otherwise, you should 'chown -R .group .', too.

Ciao,
Dscho
