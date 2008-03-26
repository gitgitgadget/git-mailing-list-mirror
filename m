From: Jeff King <peff@peff.net>
Subject: Re: git failure on Solaris t3701-add-interactive.sh -- git version
	5cc8f372509298d13632d8784bc851a587937550
Date: Wed, 26 Mar 2008 14:34:54 -0400
Message-ID: <20080326183453.GA4471@coredump.intra.peff.net>
References: <8ec76080803250529i5765cc9ar2d6fc3356800cb14@mail.gmail.com> <8ec76080803250534x5373b0c6p6165a7dc17971e4a@mail.gmail.com> <20080325234033.GA18348@coredump.intra.peff.net> <8ec76080803260519s6088b773qc3a9cf982993f53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 19:36:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeaTM-0002pl-B7
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 19:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758210AbYCZSe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 14:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758078AbYCZSe5
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 14:34:57 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1688 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755246AbYCZSe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 14:34:56 -0400
Received: (qmail 29204 invoked by uid 111); 26 Mar 2008 18:34:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 26 Mar 2008 14:34:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2008 14:34:54 -0400
Content-Disposition: inline
In-Reply-To: <8ec76080803260519s6088b773qc3a9cf982993f53@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78297>

On Wed, Mar 26, 2008 at 08:19:48AM -0400, Whit Armstrong wrote:

> You mean for Solaris 5.8, you don't get as far as this test?  All the
> systems here are on Solaris 5.9, but they are years away from
> upgrading to Solaris 10.

I mean when I run t3701, add-interactive barfs way before the error you
mention. It doesn't even like the 'our' keyword.

> we have perl 5.6.1 on our systems:

Ah, that's recent-ish. Solaris 5.8 comes with perl 5.005. I think in
general git tries to target perl 5.6.

I'll see if I can dig up perl 5.6.1 to do some testing on.

-Peff
