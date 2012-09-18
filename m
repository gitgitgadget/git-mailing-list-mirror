From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make test output coloring more intuitive
Date: Tue, 18 Sep 2012 17:59:29 -0400
Message-ID: <20120918215929.GA30346@sigill.intra.peff.net>
References: <1347882637-21766-1-git-send-email-git@adamspiers.org>
 <7vboh4tluo.fsf@alter.siamese.dyndns.org>
 <20120918213617.GB2567@atlantic.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:00:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE5px-0000Gs-Dr
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 00:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606Ab2IRV7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 17:59:32 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47577 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755355Ab2IRV7b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 17:59:31 -0400
Received: (qmail 25987 invoked by uid 107); 18 Sep 2012 21:59:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Sep 2012 17:59:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2012 17:59:29 -0400
Content-Disposition: inline
In-Reply-To: <20120918213617.GB2567@atlantic.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205881>

On Tue, Sep 18, 2012 at 10:36:17PM +0100, Adam Spiers wrote:

> > > +	say_color error "ok $test_count - $@ # TODO known breakage vanished"
> > >  }
> > 
> > Also I wonder if this is still a "TODO".
> 
> Hah, I should trust my first instincts more; my first version of the
> patch dropped the "TODO", but then I put it back in because I thought
> people would object :-)

TODO is a special token[1] respected by TAP harnesses like "prove". I'm
not sure what practical impact it has, but it should probably remain.

-Peff

[1] http://testanything.org/wiki/index.php/TAP_specification#TODO_tests
