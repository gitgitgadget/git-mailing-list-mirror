From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: How to move users from SEU (AS400) to Git?
Date: Tue, 12 May 2009 18:14:56 +0200
Message-ID: <20090512161456.GB21556@macbook.lan>
References: <1CA7E776-B216-4AA5-BFE0-63C0B066980D@npcinternational.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Brisbin <jon.brisbin@npcinternational.com>
X-From: git-owner@vger.kernel.org Tue May 12 18:15:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3udj-0006UN-6G
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbZELQO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 12:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbZELQO6
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:14:58 -0400
Received: from darksea.de ([83.133.111.250]:40702 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752284AbZELQO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 12:14:57 -0400
Received: (qmail 30397 invoked from network); 12 May 2009 18:14:46 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 12 May 2009 18:14:46 +0200
Content-Disposition: inline
In-Reply-To: <1CA7E776-B216-4AA5-BFE0-63C0B066980D@npcinternational.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118915>

On Tue, May 12, 2009 at 10:42:32AM -0500, Jon Brisbin wrote:
> I'm just wondering what the Git experts would say to someone wanting to 
> transition from say, Visual SourceSafe, and expecting the predictability 
> of having source files "locked out" while a developer is making changes 
> to them?

How about this:

With Git you effectively get a *local lock* on *all files*. These locks
are just called branches. Thus you do not have to worry about anything
getting lost (like it could happen with the svn/cvs update command).

To unlock you merge. If you merge two branches and something (although
unlikely) goes wrong you can always return to the "different locked
states" and investigate.

Seen this way git is the best from both worlds (lock/merge).

cheers Heiko
