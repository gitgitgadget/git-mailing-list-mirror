From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v2 3/4] use new config API for worktree
 configurations of submodules
Date: Thu, 17 Jul 2014 21:53:46 +0200
Message-ID: <20140717195346.GA23563@sandbox-ub>
References: <20140628095800.GA89729@book.hvoigt.net>
 <20140628100321.GD89729@book.hvoigt.net>
 <xmqqy4w38v6r.fsf@gitster.dls.corp.google.com>
 <20140709195547.GA3081@sandbox-ub>
 <xmqqegxu9ojh.fsf@gitster.dls.corp.google.com>
 <20140714205759.GA3682@sandbox-ub>
 <xmqqfvi2tfj2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 21:55:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7rm7-00042g-MV
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 21:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbaGQTz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 15:55:27 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:50678 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbaGQTz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 15:55:27 -0400
Received: from [37.4.179.65] (helo=sandbox-ub)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1X7rkW-0003KR-Tb; Thu, 17 Jul 2014 21:53:53 +0200
Content-Disposition: inline
In-Reply-To: <xmqqfvi2tfj2.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253776>

On Tue, Jul 15, 2014 at 03:37:21PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> >> Can there be any caller that include and use submodule-config.h that
> >> does not need anythjing from submodule.h?  Or vice versa?
> >> 
> >> It just did not look like these two headers describe independent
> >> subsystems but they almost always have to go hand-in-hand.  And if
> >> that is the case, perhaps it is not such a good idea to add it as a
> >> new header.  That was where my question came from.
> >
> > The reason for a separate module was because we add quite some lines of
> > code for it.
> >
> > $ wc -l submodule.c
> > 1068 submodule.c
> > $ wc -l submodule-config.c 
> > 435 submodule-config.c
> >
> > Because of this I would like to keep the c-files separate.
> 
> OK.  I do not feel too strongly.  It just looked odd that a change
> needs to add a new header file without having to change the code in
> existing files at all.
> 
> Any other thing that still needs fixing in the series, or is it now
> ready for 'next'?

All comments addressed. From my side it should be ready for next.

Cheers Heiko
