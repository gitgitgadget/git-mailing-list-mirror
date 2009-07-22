From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] bash: gitk accepts common log-shortlog options
Date: Wed, 22 Jul 2009 09:05:05 -0500
Message-ID: <20090722140505.GQ3581@saturnine>
References: <1248214802-2996-1-git-send-email-szeder@ira.uka.de>
	<200907220036.42917.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jul 22 16:05:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTcS9-0004bA-Qq
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 16:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769AbZGVOFi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 10:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755726AbZGVOFi
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 10:05:38 -0400
Received: from francis.fzi.de ([141.21.7.5]:55644 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753559AbZGVOFh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 10:05:37 -0400
Received: from localhost.localdomain ([141.21.16.12]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 22 Jul 2009 16:05:31 +0200
Content-Disposition: inline
In-Reply-To: <200907220036.42917.trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 22 Jul 2009 14:05:34.0807 (UTC) FILETIME=[7B65EE70:01CA0AD5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123751>

On Wed, Jul 22, 2009 at 12:36:36AM +0200, Thomas Rast wrote:
> SZEDER G=E1bor wrote:
> > Commit a393777e (bash completion: refactor common log, shortlog and=
 gitk
> > options, 2009-02-16) introduced a list of command line options that=
 go
> > well with 'git log' and 'git shortlog' but not with gitk.  However,
> > these options are all 'git rev-list' options, and, therefore, are
> > accepted by gitk, too.
> [...]
> > +	--author=3D --committer=3D --grep=3D
> > +	--all-match
>=20
> At the time, I tried to skip options to gitk that disconnect history
> in places where it really is connected.  This applies to --author,
> --committer and --grep, which also have a GUI equivalent.  However,
> --all-match doesn't, and then the other three are also needed, so I
> guess this makes sense.

I see.  I was not sure what you meant by "go well", but suspected
this.  However, the '--no-merges' option was already there earlier,
and it also produces disconnected history.  I'm not sure how often
these options are used with gitk, but it just happened yesterday that
I wanted to use 'gitk --author=3D<me> ...' to find one of my commits.


Best,
G=E1bor
