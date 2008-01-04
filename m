From: Jeff King <peff@peff.net>
Subject: Re: git-walkthrough-add script
Date: Fri, 4 Jan 2008 02:26:50 -0500
Message-ID: <20080104072650.GA24685@coredump.intra.peff.net>
References: <1199426431-sup-6092@south>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: William Morgan <wmorgan-git@masanjin.net>
X-From: git-owner@vger.kernel.org Fri Jan 04 08:27:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAgxf-0001og-Cf
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 08:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbYADH0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 02:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbYADH0y
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 02:26:54 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2234 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752488AbYADH0x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 02:26:53 -0500
Received: (qmail 15638 invoked by uid 111); 4 Jan 2008 07:26:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 04 Jan 2008 02:26:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2008 02:26:50 -0500
Content-Disposition: inline
In-Reply-To: <1199426431-sup-6092@south>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69554>

On Thu, Jan 03, 2008 at 10:14:31PM -0800, William Morgan wrote:

> I've written a little script to do darcs-style hunk-by-hunk
> walkthroughs. It's based on the git-hunk-commit script that was floating
> around. Maybe someone else will find it useful.
> 
> http://git-wt-commit.rubyforge.org/

It didn't work for me, since the diff parsing failed to match my
particular colors (I needed /^.....diff/ instead of /^....diff/). I
suspect the color matching needs to be more flexible to be generally
useful.

However, I'm not clear what advantages this has over "git add -p".

-Peff
