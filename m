From: Jeff King <peff@peff.net>
Subject: Re: Gitweb 1.7.5 and Textconv Configuration
Date: Sat, 2 Jul 2011 17:10:28 -0400
Message-ID: <20110702211027.GA16294@sigill.intra.peff.net>
References: <CALWDD1x-_rEx+c9bpAgVk-hvnGz1bt0mbJoDkSjZkbe=gLscUg@mail.gmail.com>
 <20110702104313.GA10245@sigill.intra.peff.net>
 <20110702104437.GA10538@sigill.intra.peff.net>
 <CALWDD1woB0ytL6T-DwD92f824dnpz0mek=SYgz5jwqR0efnkpw@mail.gmail.com>
 <20110702185724.GA14390@sigill.intra.peff.net>
 <CALWDD1zrOUwS2FeQs1SsFuLnaDzhCHZVFLvFXv7aLex1K2v5zw@mail.gmail.com>
 <20110702195735.GA15542@sigill.intra.peff.net>
 <m3aacw5t5x.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Al Haraka <alharaka@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 23:10:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qd7SY-0002wj-44
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 23:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714Ab1GBVKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jul 2011 17:10:32 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53281
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754617Ab1GBVKa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2011 17:10:30 -0400
Received: (qmail 19446 invoked by uid 107); 2 Jul 2011 21:10:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 02 Jul 2011 17:10:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Jul 2011 17:10:28 -0400
Content-Disposition: inline
In-Reply-To: <m3aacw5t5x.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176569>

On Sat, Jul 02, 2011 at 01:23:38PM -0700, Jakub Narebski wrote:

> > Ah, I see. That seems like a reasonable solution. Are you sure that the
> > user running gitweb as a CGI is the same as the user you log in as? That
> > is, are you sure that ~/.gitconfig is being parsed when it is called as
> > a CGI, and it's not looking in ~www/.gitconfig or something?
> > 
> > It would depend how your hosting is set up.
> 
> Well, there is also system wide $(prefix)/etc/gitconfig file...

Good point. Though if he's on shared hosting, that might not be an
option.

> The question is if --textconv works with git-diff-tree, because that
> is what gitweb uses.

It does. It just defaults to "--no-textconv", but you can enable it on
the command-line.

-Peff
