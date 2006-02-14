From: Greg KH <greg@kroah.com>
Subject: Re: older git archive access broken in 1.2.0?
Date: Mon, 13 Feb 2006 22:15:29 -0800
Message-ID: <20060214061529.GA853@kroah.com>
References: <20060214050616.GA28528@kroah.com> <7vek26wkwu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tglx@kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 07:15:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8tTI-0001Lw-Ud
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 07:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbWBNGPa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 01:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbWBNGPa
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 01:15:30 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:64918
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030487AbWBNGP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 01:15:29 -0500
Received: from press.kroah.org ([192.168.0.25] helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1F8tTD-0001yi-P4; Mon, 13 Feb 2006 22:15:27 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vek26wkwu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16119>

On Mon, Feb 13, 2006 at 09:48:17PM -0800, Junio C Hamano wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > I was trying to find where something changed in the historical Linux
> > kernel git tree:
> > 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/
> >
> > when I noticed that the latest version of git doesn't seem to like this
> > archive.  I can't clone it, but 'git log' and 'git whatchanged' seems to
> > work fine.
> 
> I think 1.2.0 may be a coincidence.  history.git/ mistakenly has
> an extra .git subdirectory underneath it.  Removing it should
> make things to work again I suspect.

Ah, doh, that was simple.  Thanks for the quick response.

greg k-h
