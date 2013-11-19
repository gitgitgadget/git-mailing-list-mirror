From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: Suggestion for git reference page
Date: Tue, 19 Nov 2013 22:43:48 +0100
Message-ID: <87a9h0kqy3.fsf@linux-k42r.v.cablecom.net>
References: <0C723FEB5B4E5642B25B451BA57E273041FDF07F@S1P5DAG3C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Jim Garrison <jim.garrison@nwea.org>
X-From: git-owner@vger.kernel.org Tue Nov 19 22:44:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vit5d-0004Ef-BO
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 22:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab3KSVoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 16:44:06 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:43699 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723Ab3KSVoE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 16:44:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 93FC74D6575;
	Tue, 19 Nov 2013 22:44:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lsOwLNi3rQLb; Tue, 19 Nov 2013 22:43:49 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 9BFED4D6414;
	Tue, 19 Nov 2013 22:43:49 +0100 (CET)
In-Reply-To: <0C723FEB5B4E5642B25B451BA57E273041FDF07F@S1P5DAG3C.EXCHPROD.USA.NET>
	(Jim Garrison's message of "Tue, 19 Nov 2013 21:26:47 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238052>

Jim Garrison <jim.garrison@nwea.org> writes:

> The master reference TOC page at http://git-scm.com/docs links to all
> the associated command reference pages, except it seems to be missing
> a link for gitrevisions(7)
> (http://git-scm.com/docs/gitrevisions.html).
>
> I've never submitted a patch and thought I would learn how... except
> the website source doesn't seem to be in the git source tree.

It's in this repo:

  https://github.com/github/gitscm-next.git

Judging from a quick look, the page you linked to is generated from

  app/views/doc/index.html.haml

Note that they work by pull requests, not patches, i.e. you should push
your changes to a github fork of gitscm-next and send a pull request.

-- 
Thomas Rast
tr@thomasrast.ch
