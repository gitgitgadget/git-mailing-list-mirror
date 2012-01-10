From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [bug] submodule --update insufficiently verbose
Date: Tue, 10 Jan 2012 11:43:24 +0100
Message-ID: <87k44zj0s3.fsf@thomas.inf.ethz.ch>
References: <m239bqnctf.fsf@pluto.luannocracy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Git Mailing List <git@vger.kernel.org>
To: Dave Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 11:43:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkZBC-0004Fh-CV
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 11:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805Ab2AJKn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 05:43:27 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:51900 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247Ab2AJKn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 05:43:27 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 10 Jan
 2012 11:43:24 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 10 Jan
 2012 11:43:25 +0100
In-Reply-To: <m239bqnctf.fsf@pluto.luannocracy.com> (Dave Abrahams's message
	of "Sat, 07 Jan 2012 21:33:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188244>

Dave Abrahams <dave@boostpro.com> writes:

> When a "git submodule --update" fails, e.g., due to a dirty working
> directory in one of the submodules, nothing is printed out indicating
> the submodule or directory in which the failure occurred.  This seems
> like a usability bug to me.

I assume you mean 'git submodule update'.  What git version is this, and
how do you reproduce?  I get a message like

  error: Your local changes to the following files would be overwritten by checkout:
          foo
  Please, commit your changes or stash them before you can switch branches.
  Aborting
  Unable to checkout '1fac3675a8c65b14e0a98e0136b5c43db97706fe' in submodule path 'sub'

in a simple test.  I am using a development version, but a brief glance
at the history seems to indictate that the 'Unable to ... in submodule
...' has always been there.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
