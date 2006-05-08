From: Pavel Roskin <proski@gnu.org>
Subject: Re: Implementing branch attributes in git config
Date: Sun, 07 May 2006 20:36:27 -0400
Message-ID: <1147048587.17371.13.camel@dv>
References: <1147037659.25090.25.camel@dv>
	 <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 08 02:36:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fctjn-0003q5-8s
	for gcvg-git@gmane.org; Mon, 08 May 2006 02:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWEHAgc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 20:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWEHAgc
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 20:36:32 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:4018 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751251AbWEHAgb
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 7 May 2006 20:36:31 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fctji-0008Kb-PJ
	for git@vger.kernel.org; Sun, 07 May 2006 20:36:30 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fctjf-0007vs-Ta; Sun, 07 May 2006 20:36:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19731>

Hello, Linus!

On Sun, 2006-05-07 at 17:05 -0700, Linus Torvalds wrote:

> The downside is that if you start using config files like this, you 
> literally can't go back to older git versions. They'll refuse to touch 
> such a config file (rather than just ignoring the new entries) and will 
> exit with nasty messages. That might be unacceptable.

You code faster that I write e-mails :-)

I like your approach, even though it breaks compatibility.  I understand
we are going to more .git/remotes to the config, so compatibility will
be broken anyways.

I'm only concerned that we would be hardcoding the word "branch".  We
could need fancy section names for other things in the future.

-- 
Regards,
Pavel Roskin
