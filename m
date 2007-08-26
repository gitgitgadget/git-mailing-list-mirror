From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Improve error message: not a valid branch name
Date: Sun, 26 Aug 2007 18:25:00 -0400
Message-ID: <20070826222500.GA9116@fieldses.org>
References: <y7fyfh7x.fsf@cante.net> <7vd4xang1n.fsf@gitster.siamese.dyndns.org> <ejhqeynj.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Aug 27 00:25:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPQXc-0001wx-El
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 00:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbXHZWZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 18:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752422AbXHZWZE
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 18:25:04 -0400
Received: from mail.fieldses.org ([66.93.2.214]:50357 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387AbXHZWZD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 18:25:03 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IPQXU-0003yX-Vu; Sun, 26 Aug 2007 18:25:00 -0400
Content-Disposition: inline
In-Reply-To: <ejhqeynj.fsf@cante.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56740>

On Mon, Aug 27, 2007 at 01:09:20AM +0300, Jari Aalto wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Two possible improvements that are mutually incompatible would
> > be:
> >
> >  - refactor that part of the manual to be included in the pages
> >    for any and all commands that can take refname from the user;
> >    this is inpractical as almost all command would be affected.
> >
> >  - move that to more central place, say git(7), and everybody
> >    refer to that page;
> >
> > I'd personally prefer the latter, as "naming things" is such a
> > central thing for the use of the system (this applies to the
> > description of "SHA-1 expression" that we curently have in
> > git-rev-parse(1) as well) and it is better for users to have
> > understanding of such fundamental syntaxes and concepts before
> > even using any individual commands.
> 
> Wholeheartedly concur.

Sounds good to me too, but...

> Should I re-submit the patch to refer to git(7) instead?

... git(7) is pretty long, so finding the referred-to information in
that man page might take a while.  Would it be possible to put this in a
(section 7?) man page of its own?

--b.
