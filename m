From: Jeff King <peff@peff.net>
Subject: Re: Where do all the tips go? (Was: Re: Sharing a massive
 distributed merge)
Date: Thu, 17 Mar 2011 04:01:17 -0400
Message-ID: <20110317080117.GA16202@sigill.intra.peff.net>
References: <4D8119BE.2090208@workspacewhiz.com>
 <AANLkTim0TL5X8rKoBceK3nLA4JrtuftqkJDkRi0Lok0A@mail.gmail.com>
 <10061287.5697.1300343903667.JavaMail.trustmail@mail1.terreactive.ch>
 <4D81BD9E.1050601@terreactive.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Chacon <schacon@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Victor Engmark <victor.engmark@terreactive.ch>
X-From: git-owner@vger.kernel.org Thu Mar 17 09:01:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0899-0002Td-BO
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 09:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193Ab1CQIBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 04:01:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54624
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595Ab1CQIBU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 04:01:20 -0400
Received: (qmail 21666 invoked by uid 107); 17 Mar 2011 08:01:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Mar 2011 04:01:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Mar 2011 04:01:17 -0400
Content-Disposition: inline
In-Reply-To: <4D81BD9E.1050601@terreactive.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169222>

On Thu, Mar 17, 2011 at 08:51:58AM +0100, Victor Engmark wrote:

> > Take all of my scripting there as illustrative of the concept, but not
> > necessarily a good idea. In particular, it doesn't handle quoting of
> > filenames at all, and it probably doesn't handle files whose resolution
> > was to be deleted (since the checkout will fail).
> 
> This discussion is great! Is there some place where this sort of a thing
> usually ends up, such as a wiki or the Git Community Book
> <http://book.git-scm.com/>?

There's an FAQ section on the wiki:

  https://git.wiki.kernel.org/index.php/GitFaq

though I am not sure this is frequently asked. The Git Community Book
seems pretty inactive these days. The last work on it is about 2 years
old:

  https://github.com/schacon/gitbook

These days Pro Git is freely available and seems much more active:

  https://github.com/progit/progit

I know Scott is collecting random advanced topics like this for an
eventual second edition. Maybe this topic would be of interest.

-Peff
