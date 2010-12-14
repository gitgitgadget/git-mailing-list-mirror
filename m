From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: subdirectory-filter does not delete files before the directory came into existence?
Date: Wed, 15 Dec 2010 00:03:29 +0100
Message-ID: <201012150003.30127.trast@student.ethz.ch>
References: <1292365295.6666.22.camel@ct>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jan Wielemaker <J.Wielemaker@cs.vu.nl>
X-From: git-owner@vger.kernel.org Wed Dec 15 00:03:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSduD-0007k7-EZ
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 00:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759035Ab0LNXDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 18:03:32 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:11034 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756177Ab0LNXDb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 18:03:31 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Dec
 2010 00:03:24 +0100
Received: from pctrast.inf.ethz.ch (84.74.105.24) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Dec
 2010 00:03:30 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc5-16-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <1292365295.6666.22.camel@ct>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163715>

Jan Wielemaker wrote:
> I try to extract a directory.  The result is fine, but there is a lot
> of history in the result from *before* the directory was added to the
> project.  Why?  How can I get rid of this?
[...]
> Now use e.g. qgit to look at the history.  As from 03/07/2002, when
> the packages/odbc directory was created, all looks just fine.  Before
> though ...

That history is not connected to the filtered one.  git-filter-branch
alerts you to it with messages like

  WARNING: Ref 'refs/tags/V5.0.4' is unchanged
  WARNING: Ref 'refs/tags/V5.0.5' is unchanged
  WARNING: Ref 'refs/tags/V5.0.6' is unchanged
  WARNING: Ref 'refs/tags/V5.0.7' is unchanged

I haven't made up my mind if this is a bug report or a feature
request, but in any case you can delete all of them and the problem
goes away.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
