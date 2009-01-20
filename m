From: Greg KH <greg@kroah.com>
Subject: Re: how to track multiple upstreams in one repository
Date: Mon, 19 Jan 2009 19:34:02 -0800
Message-ID: <20090120033402.GC8754@kroah.com>
References: <alpine.DEB.1.10.0901181855400.20741@asgard.lang.hm> <20090119021426.GA21999@shion.is.fushizen.net> <alpine.DEB.1.10.0901181957070.20741@asgard.lang.hm> <8e04b5820901182352n29b3885cj850e6ddae6ca237f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, Bryan Donlan <bdonlan@fushizen.net>,
	git@vger.kernel.org
To: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 04:39:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP7SL-0000h2-B1
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 04:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722AbZATDht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 22:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753364AbZATDht
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 22:37:49 -0500
Received: from kroah.org ([198.145.64.141]:43136 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752950AbZATDht (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 22:37:49 -0500
Received: from localhost (c-76-105-230-205.hsd1.or.comcast.net [76.105.230.205])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by coco.kroah.org (Postfix) with ESMTPSA id 86DFE47C58;
	Mon, 19 Jan 2009 19:37:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8e04b5820901182352n29b3885cj850e6ddae6ca237f@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106430>

On Mon, Jan 19, 2009 at 09:52:16AM +0200, Ciprian Dorin, Craciun wrote:
>     I use something even simpler, please see the attached .git/config
> file that I use. It also uses remote branches, and rewrites the refs
> to something like: stable/v2.6.25/master or torvalds/v2.6/master. Also
> in order to fetch them I use git fetch stable/v2.6.25

You all do know that all of the -stable trees are automatically kept in
one repo on kernel.org, so you don't have to jump through all of these
hoops, right?

confused,

greg k-h
