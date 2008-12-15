From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: "git gc" doesn't seem to remove loose objects any more
Date: Mon, 15 Dec 2008 14:08:08 +0000
Message-ID: <80oczdy1iv.fsf@tiny.isode.net>
References: <808wqhzjl9.fsf@tiny.isode.net>
            <237967ef0812150538n671c22b8gaf7a7b5dcaf68433@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 15:09:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCE8d-0005Yw-Oi
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 15:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbYLOOIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 09:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbYLOOIL
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 09:08:11 -0500
Received: from rufus.isode.com ([62.3.217.251]:60345 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044AbYLOOIL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 09:08:11 -0500
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SUZkyAB05SD2@rufus.isode.com> for <git@vger.kernel.org>;
          Mon, 15 Dec 2008 14:08:08 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Mon, 15 Dec 2008 14:08:08 +0000
X-Hashcash: 1:20:081215:git@vger.kernel.org::lG4cSnNMzyx6/nYV:0000000000000000000000000000000000000000001KtD
In-Reply-To: <237967ef0812150538n671c22b8gaf7a7b5dcaf68433@mail.gmail.com> (Mikael Magnusson's message of "Mon\, 15 Dec 2008 14\:38\:56 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103166>

"Mikael Magnusson" <mikachu@gmail.com> writes:

[...]

> IIRC git gc only removes loose objects older than two weeks, if you
> really want to remove them now, run git prune. But make sure no other
> git process can be active when you run it, or it could possibly step
> on something.

OK, that makes sense.  Obviously I misunderstood this.  That doesn't
explain why the number of objects might increase after "git gc", but
perhaps that's for a good reason too.

Surely "git gui"'s warning is unhelpful, then: it warns I have more
than 2000 loose objects (in another checkout), offers to compress my
database, and I end up with an unchanged repository (which it still
complains about)?  Is this warning just redundant now that we've got
"git gc --auto"?
