From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] cg-pull: summarize the number of pulled objects
Date: Mon, 30 May 2005 17:09:29 +0200
Message-ID: <20050530150929.GA28681@diku.dk>
References: <20050530015650.GB10715@diku.dk> <429A8D21.70609@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 17:09:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DclsH-0003h3-SX
	for gcvg-git@gmane.org; Mon, 30 May 2005 17:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVE3PKY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 11:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVE3PKX
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 11:10:23 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:48636 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261630AbVE3PJa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 11:09:30 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 552D36E26BC; Mon, 30 May 2005 17:08:57 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 1FD636E26B2; Mon, 30 May 2005 17:08:57 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id C09DB61FE0; Mon, 30 May 2005 17:09:29 +0200 (CEST)
To: Frank Sorenson <frank@tuxrocks.com>
Content-Disposition: inline
In-Reply-To: <429A8D21.70609@tuxrocks.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Frank Sorenson <frank@tuxrocks.com> wrote Sun, May 29, 2005:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Jonas Fonseca wrote:
> > +			if [ "$last_objects" != "$objecst" ]; then
>                                                  ^^^^^^^^
> Did you mean 'objects' ???
> 
> > +				last_objects=$objects
> > +				echo;
> > +			fi
> > +			echo "$line"
> > +			;;
> > +		esac 
> > +	done;
> > +	[ "$last_objects" != "$objecst" ] && echo
>                                ^^^^^^^
> Here too?

Yes. Thanks.

-- 
Jonas Fonseca
