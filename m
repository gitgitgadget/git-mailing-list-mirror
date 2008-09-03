From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] add '%d' pretty format specifier to show decoration
Date: Wed, 3 Sep 2008 16:36:16 -0400
Message-ID: <20080903203616.GB32223@coredump.intra.peff.net>
References: <alpine.LNX.1.10.0809032036270.32295@pollux> <20080903191217.GA31195@coredump.intra.peff.net> <7v4p4xat3v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 22:37:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaz6X-00074D-Gx
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 22:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756061AbYICUgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 16:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756138AbYICUgW
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 16:36:22 -0400
Received: from peff.net ([208.65.91.99]:4535 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756061AbYICUgT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 16:36:19 -0400
Received: (qmail 31591 invoked by uid 111); 3 Sep 2008 20:36:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Sep 2008 16:36:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Sep 2008 16:36:16 -0400
Content-Disposition: inline
In-Reply-To: <7v4p4xat3v.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94850>

On Wed, Sep 03, 2008 at 01:10:12PM -0700, Junio C Hamano wrote:

> I agree with the above reasoning.  If we go with surrounding parentheses,
> it might even make sense to include a SP _before_ the opening parenthesis,
> so that "%h %s%d" expands to either of these:
> 
>    $ git show -s --pretty=format:'%h %s%d' v1.6.0^0 v1.6.0^1
>    ea02eef GIT 1.6.0 (refs/tags/v1.6.0)
>    373a273 Merge git-gui 0.11.0

Isn't that what you argued against in Dscho's version of the patch?

    http://mid.gmane.org/7v1w5exfwb.fsf@gitster.siamese.dyndns.org

-Peff
