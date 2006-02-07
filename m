From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: git-http-push and hooks
Date: Tue, 7 Feb 2006 12:23:51 -0800
Message-ID: <20060207202351.GA3833@reactrix.com>
References: <20060206205203.GA20973@guybrush.melee> <20060206232231.GK3873@reactrix.com> <20060207195458.GA7217@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Bertrand Jacquin (Beber)" <beber@guybrush.melee>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 21:25:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6ZNb-0005PI-6d
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 21:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbWBGUYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 15:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbWBGUYA
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 15:24:00 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:41665 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S965064AbWBGUX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2006 15:23:59 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k17KNqMR023541;
	Tue, 7 Feb 2006 12:23:53 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k17KNq2v023539;
	Tue, 7 Feb 2006 12:23:52 -0800
To: Fredrik Kuivinen <freku045@student.liu.se>
Content-Disposition: inline
In-Reply-To: <20060207195458.GA7217@c165.ib.student.liu.se>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15711>

On Tue, Feb 07, 2006 at 08:54:58PM +0100, Fredrik Kuivinen wrote:

> I know basically nothing about DAV, but wouldn't it be possible to
> have a CGI-script which executes the hooks upon the client's request?

It would, although if custom software can be run on the server you might
as well run the git daemon.

There are options for a DAV-only environment though.  While the hooks
themselves can't be run, git-http-push can be modified to update the
remote pack and ref info (although it's not clear to me under what
conditions it should do so...)  DAV-specific versions of pack
management utilities are feasible as well.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
