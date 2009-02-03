From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cvs2git migration - cloning CVS repository
Date: Tue, 3 Feb 2009 13:55:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902031348570.6573@intel-tinevez-2-302>
References: <286817520902020624y7f4c2942l34fafc0fe0fa0b48@mail.gmail.com> <49883C52.3060102@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rostislav Svoboda <rostislav.svoboda@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 03 13:56:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUKpI-0006eJ-Ud
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 13:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbZBCMzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 07:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbZBCMzG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 07:55:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:48922 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754690AbZBCMzF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 07:55:05 -0500
Received: (qmail invoked by alias); 03 Feb 2009 12:55:02 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp008) with SMTP; 03 Feb 2009 13:55:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19o5d1HPVtoSTMH2N4V5QvojPgJ3uFGkACgfVvcSc
	awf9Lj3JSUA6dY
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49883C52.3060102@alum.mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108183>

Hi,

On Tue, 3 Feb 2009, Michael Haggerty wrote:

> If you do not have filesystem access to your CVS repository, you might 
> be able to clone it using CVSSuck [2,3].

A substantially faster option would be to go with cvsclone:

	http://samba.org/ftp/tridge/rtc/cvsclone.l

(in my case, cvsclone was not only faster, but it actually worked, too, 
which is more than I could say of CVSSuck).

Note: it only works for anonymous access so far.

Note also: for my use case, it was necessary to edit the rlog, as those 
brilliant geniuses included verbatim cvs logs for files they moved. *sigh*
If you need something like that, I can give you my patched version.

Ciao,
Dscho
