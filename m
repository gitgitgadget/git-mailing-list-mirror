From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Perl warning in git-svn (git v1.5.3-rc7-16-ge340d7d)
Date: Sat, 1 Sep 2007 00:51:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709010049490.28586@racer.site>
References: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com>
 <7vveav21uv.fsf@gitster.siamese.dyndns.org> <20070831152153.GA30745@muzzle>
 <7v4pifzawc.fsf@gitster.siamese.dyndns.org> <7vd4x3xuu3.fsf@gitster.siamese.dyndns.org>
 <46D8A886.5060701@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Sep 01 01:51:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRGHI-0006KP-NZ
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 01:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbXHaXvt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 19:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbXHaXvt
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 19:51:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:51128 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750851AbXHaXvs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 19:51:48 -0400
Received: (qmail invoked by alias); 31 Aug 2007 23:51:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 01 Sep 2007 01:51:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Ff2xtGUQFp0uaT+sMbv9xFkW6wAG75d1MoCOkYr
	rJwzJ9J+KoJJM7
X-X-Sender: gene099@racer.site
In-Reply-To: <46D8A886.5060701@vilain.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57233>

Hi,

On Sat, 1 Sep 2007, Sam Vilain wrote:

> Junio C Hamano wrote:
> >> I was almost going to suggest us to change "*.color = true" to
> >> mean 'auto'.  Because git can internally use pager and has a way
> >> for the user to control enabling/disabling colors when the pager
> >> is used, there is no _logical_ reason to enable pager when the
> >> output is not going to a tty.
> >>     
> >
> > Gaah, sorry; I meant "no logical reason to enable _color_ when
> > the output is not going to a tty".
> 
> Sure there is, when the output is "less -R"

This argument was already raised by Junio himself.  But your _option_ to 
use "git log | less -R" does not make it a good option.  Since "git log" 
is so much more elegant already.

Hth,
Dscho
