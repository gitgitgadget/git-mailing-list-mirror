From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH 7/7] archive: provide builtin .tar.gz filter
Date: Thu, 16 Jun 2011 08:56:21 +0100
Message-ID: <20110616075621.GA12413@arachsys.com>
References: <20110616003800.GC20355@sigill.intra.peff.net>
 <7v39jai94h.fsf@alter.siamese.dyndns.org>
 <20110616065146.GA30672@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ren?? Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Jeff King <peff@github.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 10:26:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QX7tq-0003Ro-Iv
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 10:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985Ab1FPIZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 04:25:59 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:37467 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab1FPIZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 04:25:56 -0400
Received: from [81.2.114.212] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1QX7RP-000774-UH; Thu, 16 Jun 2011 08:56:40 +0100
Content-Disposition: inline
In-Reply-To: <20110616065146.GA30672@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175885>

Jeff King <peff@github.com> writes:

> No, I mean that people may _want_ the timestamp in day to day use. Using
> "-n" all the time suppresses it. And there is no reason to suppress it,
> except that our test does not account for it properly. So your patch is
> hurting people who don't want "-n" (i.e., want the timestamp) just to
> make our test happy.

It's useful to omit the timestamp outside of git too. Source-based package
management systems generally store a URL from which to fetch a source
tarball, and a hash of that source tarball to ensure it hasn't been tampered
with. It's nice to be able to use a gitweb URL like

  http://git.kernel.org/?p=git/git.git;a=snapshot;h=e5af0de202e885b793482d416b8ce9d50dd2b8bc;sf=tgz

as the tarball source, and still be able to verify its integrity against a
prestored hash.

Cheers,

Chris.
