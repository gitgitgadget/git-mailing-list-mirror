From: Matt Kern <matt.kern@undue.org>
Subject: Re: Git SVN Rebranching Issue
Date: Tue, 4 Nov 2008 11:24:10 +0000
Message-ID: <20081104112409.GA21758@deimos.cyantechnology.local>
References: <20081103140746.GA5969@mars.cyantechnology.local> <20081104084111.GB14405@untitled> <20081104094224.GC24100@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 12:25:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxK2O-00025v-M2
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 12:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbYKDLYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 06:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753112AbYKDLYR
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 06:24:17 -0500
Received: from ceres.undue.org ([93.93.129.86]:48315 "EHLO ceres.undue.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297AbYKDLYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 06:24:16 -0500
Received: from mail.cyantechnology.com ([62.189.175.250] helo=deimos.cyantechnology.local)
	by ceres.undue.org with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <mwk@ceres.undue.org>)
	id 1KxK16-0002Jk-Bo; Tue, 04 Nov 2008 11:24:13 +0000
Content-Disposition: inline
In-Reply-To: <20081104094224.GC24100@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score: -4.3
X-Spam-Score-Int: -42
X-Spam-Bar: ----
X-Spam-Report: Spam detection software, running on the system "ceres.undue.org", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  > > It was actually an intentional design decision on my part
	preserve > > parents based on branch name. We would eventually otherwise
	lose > > history of the now-deleted branches, as reflogs can expire. > > Would
	it not be better to save the old branch using "@SVN-NUMBER" as > suffix?
	Thus, those do not need the old branch can easily delete it. [...] 
	Content analysis details:   (-4.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.8 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100069>

> > It was actually an intentional design decision on my part preserve
> > parents based on branch name.  We would eventually otherwise lose
> > history of the now-deleted branches, as reflogs can expire.
> 
> Would it not be better to save the old branch using "@SVN-NUMBER" as
> suffix? Thus, those do not need the old branch can easily delete it.

I would second this approach.  

Our svn repository isn't particularly big or old, but if someone were to
make a branch now, there is a fair chance it will have the same name as
an old branch but have absolutely nothing to do with that old branch.
The situation will only get worse as our svn repository grows and more
branches are created/deleted.

Matt

-- 
Matt Kern
http://www.undue.org/
