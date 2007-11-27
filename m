From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 20:03:50 -0500
Message-ID: <20071127010350.GE14735@spearce.org>
References: <200711252248.27904.jnareb@gmail.com> <858x4l2apc.fsf@lola.goethe.zz> <alpine.LFD.0.99999.0711261417580.9605@xanadu.home> <854pf8243i.fsf@lola.goethe.zz> <20071126195750.GD25784@efreet.light.src> <AA5ECB69-3F77-483E-AD19-04A5515779B3@wincent.com> <7vhcj8g0op.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Wincent Colaiuta <win@wincent.com>, Jan Hudec <bulb@ucw.cz>,
	David Kastrup <dak@gnu.org>, Nicolas Pitre <nico@cam.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 02:04:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwosU-0003Tb-6c
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 02:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbXK0BEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 20:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752493AbXK0BEX
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 20:04:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41352 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbXK0BEW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 20:04:22 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IworW-0003EK-9T; Mon, 26 Nov 2007 20:03:42 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 14E5120FBAE; Mon, 26 Nov 2007 20:03:51 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vhcj8g0op.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66149>

Junio C Hamano <gitster@pobox.com> wrote:
> Wincent Colaiuta <win@wincent.com> writes:
> >
> > $ git-<tab>
> > Display all 146 possibilities? (y or n)
> 
> The tab completion for bash and zsh would also help you here, but I see
> there are quite a few commands that should not be there, and it's time
> to clean it up.
...
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index cad842a..1bba68b 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -359,6 +359,15 @@ __git_commands ()
>  		upload-pack)      : plumbing;;
>  		write-tree)       : plumbing;;
>  		verify-tag)       : plumbing;;
> +		annotate)         : use blame;;
> +		checkout-index)   : plumbing;;
> +		diff-stages)      : plumbing;;
> +		get-tar-commit-id) : plumbing;;
> +		lost-found)       : deprecated;;
> +		rebase--interactive) : plumbing;;
> +		relink)           : obsolete;;
> +		whatchanged)      : plumbing;;
> +		verify-pack)      : plumbing;;
>  		*) echo $i;;
>  		esac
>  	done

Ack'd-by: Shawn O. Pearce <spearce@spearce.org>

;-)

-- 
Shawn.
