From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase -i: clean error message for --continue after
 failed exec
Date: Wed, 24 Aug 2011 16:22:33 -0400
Message-ID: <20110824202233.GB28900@sigill.intra.peff.net>
References: <vpqk4a3rkwb.fsf@bauges.imag.fr>
 <1314194508-12067-1-git-send-email-Matthieu.Moy@imag.fr>
 <7v62lmps6k.fsf@alter.siamese.dyndns.org>
 <20110824202027.GA28900@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 22:22:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwJyC-0006XE-BE
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 22:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630Ab1HXUWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 16:22:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56908
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752622Ab1HXUWf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 16:22:35 -0400
Received: (qmail 5996 invoked by uid 107); 24 Aug 2011 20:23:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Aug 2011 16:23:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2011 16:22:33 -0400
Content-Disposition: inline
In-Reply-To: <20110824202027.GA28900@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180035>

On Wed, Aug 24, 2011 at 04:20:27PM -0400, Jeff King wrote:

> Certainly my only user has ever been "exec make test". But I wonder if

Er, s/user/use.

> somebody is crazy enough to auto-generate some content and commit it.
> OTOH, shouldn't it then be their responsibility to make the commit?
> I.e., I can see at least the potential for mucking with the index, but I
> really don't see a reason for _leaving_ the index in a mucked state.

Having just read your followup patch, it looks sane. Exec commands are
free to do whatever they like with the index as long as it is left in a
clean state. That keeps the door open for semi-sane use cases, but will
catch unintended index manipulation.

-Peff
