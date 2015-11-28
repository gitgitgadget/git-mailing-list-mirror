From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2015, #04; Tue, 24)
Date: Sat, 28 Nov 2015 11:35:43 -0500
Message-ID: <20151128163543.GA26759@sigill.intra.peff.net>
References: <20151125010722.GA23632@sigill.intra.peff.net>
 <20151128154010.GA15706@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 28 17:35:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2iTT-0008Vu-7V
	for gcvg-git-2@plane.gmane.org; Sat, 28 Nov 2015 17:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbbK1Qfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2015 11:35:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:34669 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752322AbbK1Qfq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2015 11:35:46 -0500
Received: (qmail 17516 invoked by uid 102); 28 Nov 2015 16:35:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Nov 2015 10:35:46 -0600
Received: (qmail 23328 invoked by uid 107); 28 Nov 2015 16:35:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Nov 2015 11:35:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Nov 2015 11:35:43 -0500
Content-Disposition: inline
In-Reply-To: <20151128154010.GA15706@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281787>

On Sat, Nov 28, 2015 at 03:40:10PM +0000, brian m. carlson wrote:

> On Tue, Nov 24, 2015 at 08:07:23PM -0500, Jeff King wrote:
> > What's cooking in git.git (Nov 2015, #04; Tue, 24)
> > --------------------------------------------------
> > [New Topics]
> 
> I noticed the object_id series was missing from this list.  Was there
> something that needed fixing or a reroll?

Thanks for bringing this up; I meant to send a note but forgot.

I got a bunch of conflicts trying to merge it into 'next' and 'pu' and
punted on it. I think the tricky bits are coming from
dt/refs-backend-pre-vtable, where there was a lot of code movement.

-Peff
