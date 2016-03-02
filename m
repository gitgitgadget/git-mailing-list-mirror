From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/10] setup: drop GIT_REPO_VERSION constants
Date: Tue, 1 Mar 2016 21:52:15 -0500
Message-ID: <20160302025215.GC20625@sigill.intra.peff.net>
References: <20160301143546.GA30806@sigill.intra.peff.net>
 <20160301144538.GJ12887@sigill.intra.peff.net>
 <1456877582.5981.6.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 03:52:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aawti-0006rY-Mc
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 03:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbcCBCwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 21:52:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:52945 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752148AbcCBCwS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 21:52:18 -0500
Received: (qmail 28352 invoked by uid 102); 2 Mar 2016 02:52:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 21:52:18 -0500
Received: (qmail 19417 invoked by uid 107); 2 Mar 2016 02:52:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 21:52:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2016 21:52:15 -0500
Content-Disposition: inline
In-Reply-To: <1456877582.5981.6.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288094>

On Tue, Mar 01, 2016 at 07:13:02PM -0500, David Turner wrote:

> On Tue, 2016-03-01 at 09:45 -0500, Jeff King wrote:
> > -	char repo_version_string[10];
> >  
> >  	/* This forces creation of new config file */
> > -	xsnprintf(repo_version_string, sizeof(repo_version_string),
> > -		  "%d", GIT_REPO_VERSION);
> > -	git_config_set("core.repositoryformatversion",
> > repo_version_string);
> > +	git_config_set("core.repositoryformatversion", "0");
> 
> I'm about to use that in my series, so let's not get rid of it here.

Thanks. I floated this one up to the end exactly to make it easy to drop
in case there were objections. :)

-Peff
