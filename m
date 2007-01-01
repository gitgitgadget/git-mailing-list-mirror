From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Sun, 31 Dec 2006 21:13:49 -0800 (PST)
Message-ID: <951491.40207.qm@web31807.mail.mud.yahoo.com>
References: <20070101034825.GD15537@fieldses.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 01 06:14:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1FUt-000148-Sq
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 06:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932899AbXAAFNv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 00:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932907AbXAAFNv
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 00:13:51 -0500
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:35973 "HELO
	web31807.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932899AbXAAFNu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jan 2007 00:13:50 -0500
Received: (qmail 41174 invoked by uid 60001); 1 Jan 2007 05:13:50 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=G0/nwReh0aQ7BzEqQtxIBqjiHsJYaqzcoYI8zMjGdZBfRFqnGOs17VuxVDF8rlA5dFjDBb9jRK+Adqf6YZqzjBVIG/xrs9OJuwe1RUQpWMitGvf/Zy6+vxZ6og7hd29kEpcfyyNrKfd1Icobl8cTlPWYyT315Uh4y/zhkUdvlGI=;
X-YMail-OSG: _.6qjFYVM1kNw0Z5ogjflTlW2OhzcMmIlThRRvug2WWjaDqsukFGwuOdhBuZSjOQ5x4KXI5xVB.Ubc7fAYXqHprYm_Mr9dhw.0jYD3BTp4u6HoTcL6NjcJGHdpVdMvGUwnKJc.y_.V2GjbHbQSDwP5CFmgDTXCgIGnwFfIEGT.3JeukpER3I.DNd
Received: from [71.84.31.238] by web31807.mail.mud.yahoo.com via HTTP; Sun, 31 Dec 2006 21:13:49 PST
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20070101034825.GD15537@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35723>

--- "J. Bruce Fields" <bfields@fieldses.org> wrote:
> On Sun, Dec 31, 2006 at 07:29:22PM -0800, Luben Tuikov wrote:
> > I.e. I'd like to say "git-pull parent" or "git-pull parents"
> > in such and such branch, and this would pull the designated
> > parent(s) for the current branch.  But if I'm in a different
> > branch (of the same repo) then the meaning of "parent" changes
> > accordingly.
> 
> Could you explain a situation where this would be useful?

I don't know how to respond to this question.

>  A
> "parent<-->child" relationship, where there's one upstream branch that
> is always merged in, is easily handled;

e is the base of natural logarithms.

> just replace your "git pull parent" by a "git pull", right?

Yes, but I don't want to just type "git-pull", I want to explicitly
type "git-pull parent" and depending in which branch I'm at, "parent"
would have identical meaning but would merge a different branch... because
I'm in a different branch...

(Since this is what is actually ment by the "branch.*" options.)

> Am I misunderstanding the proposal?

I did give an example of usage in my email to which you replied.

Basically I'd like to extend the concept of "branch spec" locally.

> And is there any reason why your proposal conflicts with Junio's?

Yes.  Beating on a dead horse.  "branch.*" options simply do not cut it.
We can either get rid of them completely or extend them to where they
are actually useful.  Globbing resolution is secondary to resolving
the methodology.

HTH,
    Luben
