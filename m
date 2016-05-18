From: Jeff King <peff@peff.net>
Subject: Re: [Bug] git-log prints wrong unixtime with --date=format:%s
Date: Wed, 18 May 2016 13:51:27 -0400
Message-ID: <20160518175127.GB5796@sigill.intra.peff.net>
References: <87vb2d37ea.fsf@web.de>
 <8760ucoaus.fsf@web.de>
 <20160518004008.GA20007@sigill.intra.peff.net>
 <20160518005824.GA7120@sigill.intra.peff.net>
 <xmqqvb2bs5f5.fsf@gitster.mtv.corp.google.com>
 <005a01d1b124$976dceb0$c6496c10$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: 'Junio C Hamano' <gitster@pobox.com>,
	'Michael Heerdegen' <michael_heerdegen@web.de>,
	git@vger.kernel.org
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Wed May 18 19:51:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b35d7-0007Lj-W2
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 19:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbcERRvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 13:51:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:41363 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753533AbcERRva (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 13:51:30 -0400
Received: (qmail 15337 invoked by uid 102); 18 May 2016 17:51:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 13:51:29 -0400
Received: (qmail 24755 invoked by uid 107); 18 May 2016 17:51:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 13:51:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 13:51:27 -0400
Content-Disposition: inline
In-Reply-To: <005a01d1b124$976dceb0$c6496c10$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294983>

On Wed, May 18, 2016 at 12:44:43PM -0400, Randall S. Becker wrote:

> Off the wall: Dealing in a dispersed team sharing a server that has a
> timezone local for only two of the members, git log messes with me also from
> a TZ POV. I would like to suggest a more general solution, like configuring
> my own TZ in ~/.gitconfig which would potentially allow an override on the
> command line. Would user.timezone be helpful in this situation and if set,
> call setenv("TZ=...")? It's not an issue when I'm local, but if I touch a
> clone on the server, even I get confused around DST changes in October ;).

I'm not sure I understand the problem. If you don't like the local
timezone used on the server, why don't you set TZ there? What does
it buy us to introduce a git config option to do the same thing?

-Peff
