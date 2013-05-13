From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH 0/2] merge-base: add --merge-child option
Date: Mon, 13 May 2013 08:52:31 +0100
Message-ID: <20130513075230.GO2299@serenity.lan>
References: <cover.1368274689.git.john@keeping.me.uk>
 <518FB8DE.7070004@bracey.fi>
 <20130512162823.GK2299@serenity.lan>
 <20130512165829.GM2299@serenity.lan>
 <518FD182.5020606@bracey.fi>
 <7vppwvqxow.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Bracey <kevin@bracey.fi>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 09:52:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbnYu-00028e-R5
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 09:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954Ab3EMHwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 03:52:44 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:40052 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382Ab3EMHwo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 03:52:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 842C760657A;
	Mon, 13 May 2013 08:52:43 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 51jV08tRMZwQ; Mon, 13 May 2013 08:52:43 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 093346064EC;
	Mon, 13 May 2013 08:52:33 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vppwvqxow.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224102>

On Sun, May 12, 2013 at 10:02:39PM -0700, Junio C Hamano wrote:
> Kevin Bracey <kevin@bracey.fi> writes:
> 
> > On 12/05/2013 19:58, John Keeping wrote:
> >>
> >> With the patch below, the --ancestry-path version drops to under 2
> >> seconds.
> >>
> >> I'm not sure if this is a good idea though.  It helps me say "I know
> >> nothing that isn't on the ancestry path can be patch-identical, so don't
> >> bother checking if it is" but it regresses users who want the full
> >> cherry-pick check while only limiting the output.
> >
> > Hmm. Should an excluded commit be a valid comparator? Is it
> > sensible/correct to show a left commit as "=" to a right commit that
> > has been excluded by the revision specifiers? Doesn't sound right to
> > me.
> 
> Neither to me.

OK.  I'll add some tests and send a proper patch once 1.8.3 is out of
the way.
