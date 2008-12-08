From: Nick Andrew <nick@nick-andrew.net>
Subject: Re: How to clone git repository with git-svn meta-data included?
Date: Mon, 8 Dec 2008 11:03:44 +1100
Message-ID: <20081208000344.GD27057@mail.local.tull.net>
References: <493A6CEC.4060601@tuffmail.com> <8c9a060812070043r472e10abu7a76152b5fe1314d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Grzegorz Kossakowski <grek@tuffmail.com>, git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 01:05:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9TcY-0008IO-7q
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 01:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbYLHADt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 19:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbYLHADs
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 19:03:48 -0500
Received: from vps1.tull.net ([66.180.172.116]:34159 "HELO vps1.tull.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750919AbYLHADs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 19:03:48 -0500
Received: (qmail 21602 invoked by uid 1015); 8 Dec 2008 11:03:47 +1100
Received: from [10.0.0.67] (HELO tull.net) (10.0.0.67) by vps1.tull.net (qpsmtpd/0.26) with SMTP; Mon, 08 Dec 2008 11:03:47 +1100
Received: (qmail 29127 invoked by uid 1000); 8 Dec 2008 11:03:44 +1100
Content-Disposition: inline
In-Reply-To: <8c9a060812070043r472e10abu7a76152b5fe1314d@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SMTPD: qpsmtpd/0.26, http://develooper.com/code/qpsmtpd/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102513>

On Sun, Dec 07, 2008 at 12:43:32AM -0800, Jacob Helwig wrote:
> I use git-svn quite a bit at $work, but I haven't seen a way to clone
> a git repo, and have it Just Work(TM) with git-svn in the new clone,
> unfortunately.

At $work I nightly publish a .tar.gz file of a pristine git repo
synced from svn, with the metadata. So if a developer wants to start
using git they untar the file into their directory and start working,
and after that they have to do "git svn fetch" themselves.

Nick.
