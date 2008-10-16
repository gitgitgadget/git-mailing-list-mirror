From: Jeff King <peff@peff.net>
Subject: Re: What's in git.git (Oct 2008, #03; Tue, 14)
Date: Thu, 16 Oct 2008 06:08:05 -0400
Message-ID: <20081016100805.GA20762@sigill.intra.peff.net>
References: <7vej2i7rt9.fsf@gitster.siamese.dyndns.org> <bsftmRx17krWBpVlulipoJEO1fWsD0hZfF3HOZcajX6GV66RKW8W6A@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Arjen Laarhoven <arjen@yaph.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mike Ralphson <mike@abacus.co.uk>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Oct 16 12:09:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqPnM-0003pV-7Y
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 12:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbYJPKIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 06:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753077AbYJPKIL
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 06:08:11 -0400
Received: from peff.net ([208.65.91.99]:1178 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231AbYJPKIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 06:08:09 -0400
Received: (qmail 6166 invoked by uid 111); 16 Oct 2008 10:08:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 16 Oct 2008 06:08:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Oct 2008 06:08:05 -0400
Content-Disposition: inline
In-Reply-To: <bsftmRx17krWBpVlulipoJEO1fWsD0hZfF3HOZcajX6GV66RKW8W6A@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98360>

On Wed, Oct 15, 2008 at 10:35:30AM -0500, Brandon Casey wrote:

>   2) Do we want to stick with compat/regex on
> 
>       Darwin: Arjen
>      FreeBSD: Jeff
>          AIX: Mike
> 
>      now that the builtin funcname patterns have been converted to Extended
>      Regular Expressions?

t4018 passes without compat/regex on FreeBSD. Is that a sufficient test?

-Peff
