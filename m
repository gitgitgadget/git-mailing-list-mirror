From: Jeff King <peff@peff.net>
Subject: Re: git list files
Date: Mon, 14 Jan 2013 07:28:36 -0800
Message-ID: <20130114152836.GA18370@sigill.intra.peff.net>
References: <CAGL0X-rfrwtbtdN7O0=iMhVRYv1m0_czW8zmgT5QA3irkaeu5Q@mail.gmail.com>
 <20130113175602.GD5973@elie.Belkin>
 <20130113201027.GA4436@sigill.intra.peff.net>
 <20130114070832.GA4820@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?0KHRgtC+0LnRh9C+INCh0LvQtdC/0YbQvtCy?= 
	<stoycho.sleptsov@gmail.com>, git@vger.kernel.org,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 16:29:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TulyA-0004X8-8D
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 16:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756829Ab3ANP2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 10:28:41 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:32949 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756055Ab3ANP2l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 10:28:41 -0500
Received: (qmail 20293 invoked by uid 107); 14 Jan 2013 15:29:57 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jan 2013 10:29:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jan 2013 07:28:36 -0800
Content-Disposition: inline
In-Reply-To: <20130114070832.GA4820@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213497>

On Sun, Jan 13, 2013 at 11:08:32PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > As far as I recall, that script works. However, I have a pure-C
> > blame-tree implementation that is much faster, which may also be of
> > interest. I need to clean up and put a few finishing touches on it to
> > send it to the list, but it has been in production at GitHub for a few
> > months. You can find it here:
> >
> >   git://github.com/peff/git jk/blame-tree
> 
> Oh, neat.  Would that make sense as an item in
> <https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools>?

I'd rather finish cleaning it up and actually get it merged. It's on my
todo list.

-Peff
