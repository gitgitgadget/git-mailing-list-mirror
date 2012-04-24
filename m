From: <dag@cray.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 24 Apr 2012 12:22:59 -0500
Message-ID: <nngbomh3uz0.fsf@transit.us.cray.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<m3hawjagw9.fsf@localhost.localdomain>
	<nng3983phhc.fsf@transit.us.cray.com>
	<CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
	<201204171837.q3HIbbcW013784@no.baka.org>
	<CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com>
	<nng1unmnksx.fsf@transit.us.cray.com> <4F8EB157.5060707@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, <greened@obbligato.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 24 19:25:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMjUb-0000tV-Fu
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 19:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756823Ab2DXRZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 13:25:25 -0400
Received: from exprod6og111.obsmtp.com ([64.18.1.27]:49173 "EHLO
	exprod6og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755566Ab2DXRZW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 13:25:22 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob111.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT5bh54a43vMJbJ2omA8bXDVU50dISuAL@postini.com; Tue, 24 Apr 2012 10:25:22 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 24 Apr
 2012 12:23:02 -0500
In-Reply-To: <4F8EB157.5060707@web.de> (Jens Lehmann's message of "Wed, 18 Apr
	2012 14:19:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196227>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> It's explicit too when using submodules, you can update each submodule
> to the commit you want, review and test that and then decide if you want
> to commit that (or e.g. it's parent) in the superproject or just rewind
> the submodule because the new changes don't work for you.

Yes, that is very useful.

> For a lot of use cases an automatic pull of changes you haven't even
> seen yet and then automatically promote them to the superproject
> (which is how I understand "git subtree pull", but I might be wrong)
> is undesirable, for others it might very well work.

Since subtrees are really just directories in a single-history
repository, a subtree pull does "prommote" the changes to the
superproject because there is no superproject/subproject.  That's one of
the reasons subtree can be used to create subprojects out of existing
repositories.

Subtrees and submodules really are very different models.  I see
advantages and dsadvantages to both depending on one's work flow.

> I agree and am willing to provide information about submodule use cases,
> advantages and problems, but I'm not a user of subtree so I can't really
> comment on it. Now that subtree is in git core, what about putting such
> a comparison under Documentation/subproject-support.txt?

That would be great.  Do you want to start work on that?  I can
contribute some text about git-subtree.

                               -Dave
