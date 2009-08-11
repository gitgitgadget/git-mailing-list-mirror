From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/8] Add a config option for remotes to specify a
 foreign vcs
Date: Tue, 11 Aug 2009 19:02:33 -0400
Message-ID: <20090811230233.GA25642@coredump.intra.peff.net>
References: <alpine.LNX.2.00.0908091526060.27553@iabervon.org>
 <7v1vnk79lt.fsf@alter.siamese.dyndns.org>
 <36ca99e90908110831g2ad52a5ar4a755723a6682f77@mail.gmail.com>
 <alpine.DEB.1.00.0908111817490.4638@intel-tinevez-2-302>
 <20090811214849.GA3868@sigill.intra.peff.net>
 <20090812075914.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Brian Gernhardt <benji@silverinsanity.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 01:02:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb0Mb-0003Pl-Vl
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 01:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbZHKXCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 19:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754327AbZHKXCc
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 19:02:32 -0400
Received: from peff.net ([208.65.91.99]:57861 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754124AbZHKXCc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 19:02:32 -0400
Received: (qmail 7138 invoked by uid 107); 11 Aug 2009 23:02:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 11 Aug 2009 19:02:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Aug 2009 19:02:33 -0400
Content-Disposition: inline
In-Reply-To: <20090812075914.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125615>

On Wed, Aug 12, 2009 at 07:59:14AM +0900, Nanako Shiraishi wrote:

> Then how about using a prefix that has been invalid, "vcs::$string",
> for example?

I have no problem with that, and I think it makes it even more visually
obvious what is going. For example:

  svn::http://server/path/to/repo

makes the "svn" prefix jump out a bit more.

-Peff
