From: Jeff King <peff@peff.net>
Subject: Re: Gitweb 1.7.5 and Textconv Configuration
Date: Sat, 2 Jul 2011 15:57:36 -0400
Message-ID: <20110702195735.GA15542@sigill.intra.peff.net>
References: <CALWDD1x-_rEx+c9bpAgVk-hvnGz1bt0mbJoDkSjZkbe=gLscUg@mail.gmail.com>
 <20110702104313.GA10245@sigill.intra.peff.net>
 <20110702104437.GA10538@sigill.intra.peff.net>
 <CALWDD1woB0ytL6T-DwD92f824dnpz0mek=SYgz5jwqR0efnkpw@mail.gmail.com>
 <20110702185724.GA14390@sigill.intra.peff.net>
 <CALWDD1zrOUwS2FeQs1SsFuLnaDzhCHZVFLvFXv7aLex1K2v5zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Al Haraka <alharaka@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 21:57:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qd6Jz-00075g-Tg
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 21:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855Ab1GBT5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jul 2011 15:57:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50363
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268Ab1GBT5i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2011 15:57:38 -0400
Received: (qmail 19014 invoked by uid 107); 2 Jul 2011 19:57:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 02 Jul 2011 15:57:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Jul 2011 15:57:36 -0400
Content-Disposition: inline
In-Reply-To: <CALWDD1zrOUwS2FeQs1SsFuLnaDzhCHZVFLvFXv7aLex1K2v5zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176566>

On Sat, Jul 02, 2011 at 10:18:55PM +0300, Al Haraka wrote:

> > which will make the repository-wide non-version-controlled gitattributes
> > the same as the last committed version. The problem is that it won't be
> > automatically updated as you commit and push changes to .gitattributes.
> 
> I thought my plan was to try and avoid this by using the
> core.attributesfile directive, forcing this stuff to operate system
> (well, account, besides the point here) wide on all repos with
> specifying a .gitattributes (or, since it base bare, as you pointed
> out yourself, $GIT_REPO_DIR/info/attributes) every single time.  Did I
> misunderstand the mailing list thread that mentioned this a while
> back?

Ah, I see. That seems like a reasonable solution. Are you sure that the
user running gitweb as a CGI is the same as the user you log in as? That
is, are you sure that ~/.gitconfig is being parsed when it is called as
a CGI, and it's not looking in ~www/.gitconfig or something?

It would depend how your hosting is set up.

> This is the reason I went through the trouble of compiling an updated
> version in my account (as opposed to the installed version on the
> Dreamhost box; they are stuck at version 1.7.1.1; I saw this mentioned
> on a thread somewhere and wanted to get the "latest" (well latest
> stable version) to avoid this kind of problem?  Was that the right
> thing to do?  Will it even work in this case?  I get the feeling from
> your response I was expecting a lot with RTFM'ing more.

It sounds like it should work to me, but I've not tested it (nor do I
even run gitweb; I just have an interest in textconv).

> Thanks again for your help.  I really appreciate it.  I am new to git,
> but LOVE what you guys have being doing.  I never used any DRCS before
> this, personally or professionally, but read snippets of howtos and so
> much good press I decided it was time I mooch off you guys to organize
> my life.  :-)

You're welcome. Hopefully we can resolve your problem and get the answer
at least in the list archive. And then you will have made the world a
better place. :)

-Peff
