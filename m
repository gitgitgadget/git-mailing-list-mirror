From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Wish: make commiter email address configurable per-repo
Date: Fri, 7 Jan 2011 14:20:40 +0100
Message-ID: <201101071420.40570.trast@student.ethz.ch>
References: <ig73o1$lbg$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 14:21:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbCFc-0006RR-44
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 14:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122Ab1AGNUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 08:20:43 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:38739 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686Ab1AGNUm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 08:20:42 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 7 Jan
 2011 14:19:53 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 7 Jan
 2011 14:20:41 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc8-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <ig73o1$lbg$1@dough.gmane.org>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164709>

Stephen Kelly wrote:
> So for some git repos in KDE which I work on on work time, I'd like to set a 
> different committer address. I can't just set GIT_COMMITTER_EMAIL or 
> whatever in my bashrc, because in other repos I want to use a different 
> committer email, and don't want it set globally for all git repos I work on.
> 
> This doesn't seem to be configurable in git config. Can that be changed?

See user.email in git-config(1).  Most people set it globally, as in

  git config --global user.email "author@example.com"

but there's nothing stopping you from doing

  git config user.email "alias@example.com"

to set it on a per-repo level.  (Or just edit .git/config, of course.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
