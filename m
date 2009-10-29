From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v4 26/26] test smart http fetch and push
Date: Thu, 29 Oct 2009 07:32:45 -0700
Message-ID: <20091029143245.GT10505@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org> <1256774448-7625-27-git-send-email-spearce@spearce.org> <20091029003117.GA18299@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Oct 29 15:32:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3W3b-0004J2-S2
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 15:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbZJ2Ocl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 10:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbZJ2Ocl
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 10:32:41 -0400
Received: from george.spearce.org ([209.20.77.23]:60598 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbZJ2Ock (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 10:32:40 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E7BB2381D3; Thu, 29 Oct 2009 14:32:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091029003117.GA18299@localhost>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131593>

Clemens Buchacher <drizzd@aon.at> wrote:
> On Wed, Oct 28, 2009 at 05:00:48PM -0700, Shawn O. Pearce wrote:
> 
> > --- /dev/null
> > +++ b/t/t5541-http-push.sh
> [...]
> > +LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5550'}
> 
> This should be 5541. We need different ports to be able to run the tests
> simultenously.

Thanks, I also realized this myself this morning on my way into work.
I've adjusted my two new test scripts, and inserted your patch to
fix the older test script into the series.
 
-- 
Shawn.
