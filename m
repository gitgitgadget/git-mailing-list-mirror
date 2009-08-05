From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 07/13] Add a config option for remotes to specify a
 foreign vcs
Date: Wed, 5 Aug 2009 01:19:58 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908050119230.2147@iabervon.org>
References: <alpine.LNX.2.00.0908050055500.2147@iabervon.org> <825BD79D-F4F0-404F-A320-2D6AE94DE6D7@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 07:20:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYYuw-0002dj-6s
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 07:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581AbZHEFT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 01:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755553AbZHEFT6
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 01:19:58 -0400
Received: from iabervon.org ([66.92.72.58]:54257 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755498AbZHEFT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 01:19:58 -0400
Received: (qmail 19240 invoked by uid 1000); 5 Aug 2009 05:19:58 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 05:19:58 -0000
In-Reply-To: <825BD79D-F4F0-404F-A320-2D6AE94DE6D7@silverinsanity.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124868>

On Wed, 5 Aug 2009, Brian Gernhardt wrote:

> On Aug 5, 2009, at 1:02 AM, Daniel Barkalow wrote:
> 
> > If this is set, the url is not required, and the transport always uses
> > a helper named "git-remote-<value>".
> 
> > +remote.<name>.vcs::
> > +	Setting this to a value <vcs> will cause git to interact with
> > +	the remote with the git-vcs-<vcs> helper.
> 
> 
> I can't tell from the code, but one of these has to be wrong.

True; git-remote-<vcs> is the correct name.

	-Daniel
*This .sig left intentionally blank*
