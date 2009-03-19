From: Jeff King <peff@peff.net>
Subject: Re: Gnome chose Git
Date: Thu, 19 Mar 2009 16:14:06 -0400
Message-ID: <20090319201405.GD17028@coredump.intra.peff.net>
References: <877i2lbvt7.fsf@iki.fi> <49C249B9.7010001@drmicha.warpmail.net> <1cd1989b0903190643p19a40718yc4fd2730aab0a9a0@mail.gmail.com> <49C24D9B.1060301@drmicha.warpmail.net> <1cd1989b0903190701uac4602dl1d2c3cace45a9938@mail.gmail.com> <20090319151610.GO23521@spearce.org> <1cd1989b0903190850p1a08991y754904e7799c7879@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git <git@vger.kernel.org>
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 21:15:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkOeZ-0004VF-U6
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 21:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034AbZCSUOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 16:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754273AbZCSUOQ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 16:14:16 -0400
Received: from peff.net ([208.65.91.99]:45724 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754200AbZCSUOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 16:14:16 -0400
Received: (qmail 3288 invoked by uid 107); 19 Mar 2009 20:14:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Mar 2009 16:14:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2009 16:14:06 -0400
Content-Disposition: inline
In-Reply-To: <1cd1989b0903190850p1a08991y754904e7799c7879@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113822>

On Thu, Mar 19, 2009 at 09:50:39AM -0600, Pat Notz wrote:

> On Thu, Mar 19, 2009 at 9:16 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> >
> > Why are people reinventing the reflog, and core.logallrefupdates ?
> >
> 
> Hmmm, lack of awareness of core.logallrefupdates in my case.  Thanks
> for the pointer.

But do note that reflogs expire eventually, so you will want to also
look at gc.reflogexpire and gc.reflogexpireunreachable if you want to
keep this as an activity log forever.

-Peff
