From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 15:14:17 +0200
Message-ID: <200610101514.20705.Josef.Weidendorfer@gmx.de>
References: <20061009205551.GO20017@pasky.or.cz> <20061010070531.GB2413@coredump.intra.peff.net> <452B54A5.4080901@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Luben Tuikov <ltuikov@yahoo.com>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Oct 10 15:14:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXHRA-00021z-L0
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 15:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWJJNOV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 09:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWJJNOV
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 09:14:21 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:49098 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1750721AbWJJNOU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 09:14:20 -0400
Received: from dhcp-3s-48.lrr.in.tum.de (dhcp-3s-48.lrr.in.tum.de [131.159.35.48])
	by mail.in.tum.de (Postfix) with ESMTP id 4FB1926EF;
	Tue, 10 Oct 2006 15:14:19 +0200 (MEST)
To: Andreas Ericsson <ae@op5.se>
User-Agent: KMail/1.9.3
In-Reply-To: <452B54A5.4080901@op5.se>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28629>

On Tuesday 10 October 2006 10:07, Andreas Ericsson wrote:
> I like my links blue and underlined. Can't be arsed to mouse over things 
> to figure out if they're clickable. If they're not blue and underlined, 
> they're not, insofar as I'm concerned.

Same opinion here.

Better be functional than beautiful but confusing.

If Gitweb would be a desktop application, we would have context menues
for different actions on list items, but that is not really possible
with web pages (?), and would be unexpected.

Gitweb is a web interface. So lets use the conventions for web pages.
One solution is to repeat the actions everytime in every row of a list,
as we do now (and I think is fine; we could use icons instead). The other
standard solution is to have checkboxes at the front of every row, and
the actions as buttons, which means two mouse clicks (which IMHO is a
really bad UI).

And as we go with the first solution, we explicitly should state all
possible actions, and not provide an hidden action which is triggered
when clicking on the entry name. Currently, it is not very clear that
* we have a "blob" action at all,
* clicking on the entry name provides the blob action. Seems to me
like an arbitrary choice. Why not "raw" or "blame" instead?
Therefore, I am in favor of reintroducing the "blob" link,
which allows the entry names to stay as they are
now (and could get the hidden redundant action).

One thing I found confusing in this regard the first time:
Why do list rows show a recoloring with mouse over?
This somehow suggest that the whole row makes up some kind of
a button and is clickable (BTW, blame pages do not do this).
Can we get rid of this?

Josef
