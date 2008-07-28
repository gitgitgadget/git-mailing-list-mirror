From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Make use of stat.ctime configurable
Date: Mon, 28 Jul 2008 18:20:43 +0200
Message-ID: <20080728162043.GG32184@machine.or.cz>
References: <7vr69lihkt.fsf@gitster.siamese.dyndns.org> <20080723164614.GB5283@blimp.local> <alpine.DEB.1.00.0807231757550.8986@racer> <20080723191647.GF5283@blimp.local> <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org> <20080725055547.GA3699@blimp.local> <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness> <20080726153802.GA16868@blimp.local> <7v1w1f155p.fsf@gitster.siamese.dyndns.org> <20080728063128.GA4234@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 18:22:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNVUH-0002AE-Po
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 18:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759149AbYG1QUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 12:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759113AbYG1QUq
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 12:20:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44467 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759018AbYG1QUp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 12:20:45 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 1980C393BABF; Mon, 28 Jul 2008 18:20:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080728063128.GA4234@blimp.local>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90471>

On Mon, Jul 28, 2008 at 08:31:28AM +0200, Alex Riesen wrote:
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1a13abc..552c134 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -149,6 +149,13 @@ core.safecrlf::
>  	`core.autocrlf`, git will reject the file.  The variable can
>  	be set to "warn", in which case git will only warn about an
>  	irreversible conversion but continue the operation.
> +
> +core.trustctime::
> +	If false, the ctime differences between the index and the
> +	working copy are ignored; useful when the inode change time
> +	is regularly modified by something outside Git (file system
> +	crawlers and some backup systems).
> +	See linkgit:git-update-index[1]. True by default.
>  +
>  CRLF conversion bears a slight chance of corrupting data.
>  autocrlf=true will convert CRLF to LF during commit and LF to

Somehow, this particular position of the new hunk does not feel like the
best choice. ;-)

				Petr "Pasky" Baudis
