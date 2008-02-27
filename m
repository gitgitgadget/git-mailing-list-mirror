From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Set proxy override with http_init()
Date: Wed, 27 Feb 2008 15:39:14 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802271538200.19665@iabervon.org>
References: <20080227200551.GA6954@glandium.org> <1204144550-14175-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 21:40:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUT4D-0000xL-WF
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 21:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757265AbYB0UjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 15:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbYB0UjR
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 15:39:17 -0500
Received: from iabervon.org ([66.92.72.58]:58450 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755356AbYB0UjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 15:39:16 -0500
Received: (qmail 2747 invoked by uid 1000); 27 Feb 2008 20:39:14 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Feb 2008 20:39:14 -0000
In-Reply-To: <1204144550-14175-1-git-send-email-mh@glandium.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75302>

On Wed, 27 Feb 2008, Mike Hommey wrote:

> In transport.c, proxy setting (the one from the remote conf) was set through
> curl_easy_setopt() call, while http.c already does the same with the
> http.proxy setting. We now just use this infrastructure instead, and make
> http_init() now take the struct remote as argument so that it can take the
> http_proxy setting from there, and any other property that would be added
> later.
> 
> At the same time, we make get_http_walker() take a struct remote argument
> too, and pass it to http_init(), which makes remote defined proxy be used
> for more than get_refs_via_curl().
> 
> We leave out http-fetch and http-push, which don't use remotes for the
> moment, purposefully.
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>

Acked-by: Daniel Barkalow <barkalow@iabervon.org>

	-Daniel
*This .sig left intentionally blank*
