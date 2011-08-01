From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Storing additional information in commit headers
Date: Mon, 1 Aug 2011 22:01:49 +0200
Message-ID: <20110801200149.GA20861@toss>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
 <CAGdFq_h5gimMkwhyOv0PFqVwx4pExL7Zri8Tki_dT5HDtFcBFA@mail.gmail.com>
 <20110801183411.GA5182@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Mon Aug 01 22:02:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnygX-0005Pz-NB
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 22:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051Ab1HAUBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 16:01:53 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:18542 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752192Ab1HAUBw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 16:01:52 -0400
Received: from localhost (p5B22CD28.dip.t-dialin.net [91.34.205.40])
	by bsmtp.bon.at (Postfix) with ESMTP id 31E81A7EB4;
	Mon,  1 Aug 2011 22:01:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110801183411.GA5182@fishbowl.rw.madduck.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178404>

On Mon, Aug 01, 2011 at 08:34:11PM +0200, martin f krafft wrote:
>
> Yes, I have considered git-notes. The issue I have with git-notes is
> that it requires every contributor to set up refspecs for fetch and
> push, or else the notes will not be exchanged/shared.

Notes are tracked using a 'branch' too. It's just a branch in the
refs/notes namespace, the notes ref. You could simply tag your
notes ref or point a ref from the refs/heads namespace to it each
time you create new notes.

> Also, git-notes are mutable (at least from the UI perspectiv) and
> I strive to encode information immutably.

Notes are also used by textconv, for example, to cache immutable
data. It's not likely a user will end up editing it by accident
unless you use the default notes ref.

Clemens
