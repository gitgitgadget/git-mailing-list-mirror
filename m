From: Anteru <newsgroups@catchall.shelter13.net>
Subject: Re: Deciding between Git/Mercurial
Date: Sun, 27 Sep 2009 21:18:49 +0200
Message-ID: <h9odqq$ig9$1@ger.gmane.org>
References: <81b0412b0909271144o26743e05uac3132cdc5b530b@mail.gmail.com> <585748.13758.qm@web27802.mail.ukl.yahoo.com>
Reply-To: newsgroups@catchall.shelter13.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 27 21:19:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrzHF-0000zp-Hx
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 21:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbZI0TTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 15:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbZI0TTM
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 15:19:12 -0400
Received: from lo.gmane.org ([80.91.229.12]:37133 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383AbZI0TTL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 15:19:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MrzH7-0000yP-PI
	for git@vger.kernel.org; Sun, 27 Sep 2009 21:19:13 +0200
Received: from lmontsouris-156-26-18-33.w80-14.abo.wanadoo.fr ([80.14.177.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Sep 2009 21:19:13 +0200
Received: from newsgroups by lmontsouris-156-26-18-33.w80-14.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Sep 2009 21:19:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: lmontsouris-156-26-18-33.w80-14.abo.wanadoo.fr
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <585748.13758.qm@web27802.mail.ukl.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129216>

Mark Struberg schrieb:
> Another thing to consider: For what kind of project/language do you need git? What build tools are you using and how good is the integration into both git and hg?
The project is running on Windows/Linux (Windows being the primary
development platform, and we also expect most users to run Windows.)

For tooling, we use Trac at the moment (good integration with SVN), but
we're evaluating GitTrac, Trac/Mercurial and Redmine now (+ possible
migration paths.) For our build system, it's a non-issue anyway, as
git/mercurial have command line clients, and that's all we need.

Don't get me wrong with Git+msysgit on Windows, the point is simply if
we switch to git, can we expect that Windows will be supported for the
foreseeable future or is it possible that git may simply drop Windows
support completely? For Mercurial, this is a non-issue, as it is written
in Python, and Python will support both Windows and Linux.

As I said, I'm happy with using msysgit, but I cannot find any roadmap
etc. which helps me to determine how git and Windows is going to
continue (for instance, I can find some complaints that git's
performance is bad on Windows due to cygwin's fork()/exec(), is this
likely to get ever "fixed"? I guess git# will solve this as soon as it's
ready?)

Cheers,
  Anteru
