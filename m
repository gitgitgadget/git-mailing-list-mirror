From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 15:04:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709241502330.28395@racer.site>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz>
 <20070924060521.GB10975@glandium.org> <85k5qgk295.fsf@lola.goethe.zz>
 <ee77f5c20709232330n7b47d9e9v38677678dbf197da@mail.gmail.com>
 <86ejgowl5g.fsf@lola.quinscape.zz> <20070924080134.GA9112@artemis.corp>
 <20070924080436.GB9112@artemis.corp> <Pine.LNX.4.64.0709241128460.28395@racer.site>
 <87ps08s3zt.fsf@catnip.gol.com> <20070924113556.GI8111@void.codelabs.ru>
 <87k5qgrxcu.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eygene Ryabinkin <rea-git@codelabs.ru>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 16:06:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZoZC-0003bM-Fx
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 16:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769AbXIXOFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 10:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757131AbXIXOFg
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 10:05:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:44962 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755769AbXIXOFg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 10:05:36 -0400
Received: (qmail invoked by alias); 24 Sep 2007 14:05:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 24 Sep 2007 16:05:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+5boJtZaS5kiI7hCvzS9p1YCk3XGBjl9hvIpqA3K
	jiif8yK4a5dFqo
X-X-Sender: gene099@racer.site
In-Reply-To: <87k5qgrxcu.fsf@catnip.gol.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59050>

Hi,

On Mon, 24 Sep 2007, Miles Bader wrote:

> Eygene Ryabinkin <rea-git@codelabs.ru> writes:
> >> The comment "... holds only for a shell where [ is a builtin" doesn't
> >> make any sense to me
> >
> > The 'while case ...' construct does not invoke any external commands.
> > The 'while test ...' too, but only when 'test' is builtin.  When
> > 'test' is the external binary you get one additional fork/exec per
> > each cycle.
> 
> In practice that's not an issue though -- every reasonable shell has 
> test as a builtin these days, so the "works when test is not a builtin" 
> criteria is really important only for robustness.

AAAAAAAAAAAAAARRRRRGGGHHHHHHHHHHHH!

_Exactly_ the same reasoning can be said about the old code: _every_ 
reasonable shell can grok the code that used to be there!

<rhetoric-question>
	So what exactly was your point again?
</rhetoric-question>

Ciao,
Dscho
