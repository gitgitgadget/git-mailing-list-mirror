From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make tests independent of global config files
Date: Wed, 6 Feb 2008 04:27:54 -0500
Message-ID: <20080206092753.GA32264@coredump.intra.peff.net>
References: <20080206083817.GA19710@coredump.intra.peff.net> <7vodau1m6t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 10:28:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMga4-0002Dl-43
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 10:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760739AbYBFJ17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 04:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760694AbYBFJ16
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 04:27:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2017 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760640AbYBFJ15 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 04:27:57 -0500
Received: (qmail 27490 invoked by uid 111); 6 Feb 2008 09:27:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 06 Feb 2008 04:27:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2008 04:27:54 -0500
Content-Disposition: inline
In-Reply-To: <7vodau1m6t.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72780>

On Wed, Feb 06, 2008 at 01:14:18AM -0800, Junio C Hamano wrote:

> > GIT_ETC_CONFIG=$(pwd)/.git/nonexistant
> 
> Instead how about "GIT_NO_ETC_CONFIG" when set _ignores_ /etc/gitconfig
> altogether?
> 
> Then you do not have to make excuses like "eh, you can do this
> more or less with local config but...".

I'm fine with that, as well. And for our purposes, a little cleaner,
since we don't have to use the hack-ish "nonexistent" file (which is
clearly a spelling nightmare).

Updated patch series to follow.

-Peff
