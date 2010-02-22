From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [BUG] git gui blame: Show History Context broken since
	29e5573d
Date: Mon, 22 Feb 2010 23:38:44 +0100
Message-ID: <20100222223802.GA9898@book.hvoigt.net>
References: <vpqaav1llpn.fsf@bauges.imag.fr> <cb7bb73a1002220718p6b6621der6df062cd2f490d89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:38:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjgvU-0002Wa-GD
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 23:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729Ab0BVWir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 17:38:47 -0500
Received: from darksea.de ([83.133.111.250]:42021 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754483Ab0BVWir (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 17:38:47 -0500
Received: (qmail 12657 invoked from network); 22 Feb 2010 23:38:44 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 22 Feb 2010 23:38:44 +0100
Content-Disposition: inline
In-Reply-To: <cb7bb73a1002220718p6b6621der6df062cd2f490d89@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140731>

On Mon, Feb 22, 2010 at 04:18:11PM +0100, Giuseppe Bilotta wrote:
> On Mon, Feb 22, 2010 at 9:27 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
> > Hi,
> >
> > In "git gui blame", right-clicking on the left fringe and chosing
> > "Show History Context" in the context-menu doesn't work for me in the
> > latest git. It says:
> >
> > couldn't change working directory to "": no such file or directory
> 
> Definitely my fault. _gitworktree was not being set up correctly when
> support for bare repositories was enabled and the repo was not bare
> (like in the blame case). Patch incoming, can you see if it does the
> job for you? It seems to fix it here.

Isn't this the same bug as this one fixes:

http://article.gmane.org/gmane.comp.version-control.git/140288

cheers Heiko
