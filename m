From: Andres Freund <andres@anarazel.de>
Subject: Re: libreoffice merge(tool?) issue #3 ... (bogus)
Date: Fri, 25 Feb 2011 21:55:12 +0100
Message-ID: <201102252155.13466.andres@anarazel.de>
References: <1298388877.32648.171.camel@lenovo-w500> <993F66D7-7659-4AA5-9931-1EB66CAA01DB@silverinsanity.com> <1298565560.32648.258.camel@lenovo-w500>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org,
	kendy@novell.com, Norbert Thiebaud <nthiebaud@gmail.com>
To: michael.meeks@novell.com
X-From: git-owner@vger.kernel.org Fri Feb 25 22:03:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt4oy-0003Dq-DN
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 22:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067Ab1BYVDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 16:03:23 -0500
Received: from mail.anarazel.de ([217.115.131.40]:51974 "EHLO mail.anarazel.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778Ab1BYVDW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 16:03:22 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Feb 2011 16:03:22 EST
Received: by mail.anarazel.de (Postfix, from userid 108)
	id 1017A448005; Fri, 25 Feb 2011 21:54:21 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from anarazel.de (f053046200.adsl.alicedsl.de [78.53.46.200])
	by mail.anarazel.de (Postfix) with ESMTPSA id A5F28448004;
	Fri, 25 Feb 2011 21:54:17 +0100 (CET)
Received: by anarazel.de (Postfix, from userid 1000)
	id CC0D91C0167; Fri, 25 Feb 2011 21:55:13 +0100 (CET)
User-Agent: KMail/1.13.5 (Linux/2.6.38-rc5-andres-00100-g0cc9d52; KDE/4.5.1; x86_64; ; )
In-Reply-To: <1298565560.32648.258.camel@lenovo-w500>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167941>

Hi,

On Thursday 24 February 2011 17:39:20 Michael Meeks wrote:
> 	Anyhow - I tried your kind advice:
> 
> On Tue, 2011-02-22 at 10:55 -0500, Brian Gernhardt wrote:
> > FYI: `git clone foo bar` will use hard-links to copy the object
> > files and is both very fast and space efficient.  (See the
> > description of `--local` in git-clone(1), which is used by
> > default for local repositories since git 1.5.3.)  It's also
> > guaranteed to work while the correctness of `cp -lR` depends
> > on implementation details of git.
> 
> 	Sounds like just what I need. Unfortunately, it didn't clone some of
> the pieces I needed; eg. other configured remotes, I ended up with just
> 'origin' - which was unexpected (and less wonderful than cp -lR ;-).
See the --mirror option for clone

Per default only local refs get copied over.

Andres
