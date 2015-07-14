From: Jeff King <peff@peff.net>
Subject: Re: Git has a healthy truck factor..
Date: Tue, 14 Jul 2015 08:39:50 -0700
Message-ID: <20150714153950.GA17709@peff.net>
References: <2E436A2846834D6CBD77FBEAD1EFB43C@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 17:40:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF2JM-0005ms-IY
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 17:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbbGNPj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 11:39:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:59642 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751298AbbGNPjy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 11:39:54 -0400
Received: (qmail 4833 invoked by uid 102); 14 Jul 2015 15:39:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jul 2015 10:39:54 -0500
Received: (qmail 10128 invoked by uid 107); 14 Jul 2015 15:39:54 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jul 2015 11:39:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jul 2015 08:39:50 -0700
Content-Disposition: inline
In-Reply-To: <2E436A2846834D6CBD77FBEAD1EFB43C@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273963>

On Tue, Jul 14, 2015 at 12:05:58AM +0100, Philip Oakley wrote:

> It looks like Git has a healthy truck factor of 8, as reported in
> https://mtov.github.io/Truck-Factor/, which has Git eighth in the list of
> projects it analyzed, with Linux at second place.
> 
> The analysis method paper is behind a pay wall, so I couldn't see how
> sensible the methodology, but it's nice to know Git's a broad team.

One thing I noticed is that Homebrew has an extremely high number. But I
suspect this is because it has a very large number of somewhat silo'd
files. That is, people work on package formulas for projects that
interest them, but what you really care about for the health of the
project is who is working on the base system. Maybe those formula
authors could step up, or maybe not, but I'm not sure that is reflected
in this analysis.

-Peff
