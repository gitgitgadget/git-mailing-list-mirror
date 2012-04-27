From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/2] git-svn: Configure a prompt callback for
 gnome_keyring.
Date: Fri, 27 Apr 2012 08:28:40 +0000
Message-ID: <20120427082840.GB7257@dcvr.yhbt.net>
References: <20120426183634.GA4023@login.drsnuggles.stderr.nl>
 <1335468843-24653-1-git-send-email-matthijs@stdin.nl>
 <1335468843-24653-2-git-send-email-matthijs@stdin.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Fri Apr 27 10:29:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNgXw-00061v-Jm
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 10:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759231Ab2D0I2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 04:28:47 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44836 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759125Ab2D0I2l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 04:28:41 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41F5A1F449;
	Fri, 27 Apr 2012 08:28:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1335468843-24653-2-git-send-email-matthijs@stdin.nl>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196455>

Matthijs Kooijman <matthijs@stdin.nl> wrote:
> This allows git-svn to prompt for a keyring unlock password, when a
> the needed gnome keyring is locked.
> 
> This requires changes in the subversion perl bindings which have been
> committed to trunk (1241554 and some followup commits) and should be
> available with the (as of yet unreleased) 1.8.0 release.

I'm a hesitant to use/depend on unreleased functionality in SVN.

Is there a chance the API could change before the release.  Also,
what kind of tests do the SVN guys do on the Perl bindings + GNOME?
I'm especially concerned since we just worked around segfault
bugs in the other patch.

Can we put this on hold until somebody can test the 1.8.0 release?
