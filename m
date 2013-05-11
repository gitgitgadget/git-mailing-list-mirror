From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [ANN] git-tbdiff: topic branch diff
Date: Sat, 11 May 2013 17:44:37 +0200
Message-ID: <87ehddfrmi.fsf@linux-k42r.v.cablecom.net>
References: <87ip2pfs19.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 11 17:44:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbByj-0004x7-P4
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 17:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab3EKPom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 11:44:42 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:44798 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753063Ab3EKPom (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 11:44:42 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 11 May
 2013 17:44:30 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (213.221.117.227) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Sat, 11 May 2013 17:44:39 +0200
In-Reply-To: <87ip2pfs19.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Sat, 11 May 2013 17:35:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [213.221.117.227]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223975>

Thomas Rast <trast@inf.ethz.ch> writes:

> Hi,
>
> Spawned by discussion here at git-merge, I created a script that diffs
> the state of branches.
>
> You can grab it from
>
>   https://github.com/trast/tbdiff.git
>
> The usage is
>
>   git tbdiff A..B C..D

BTW, I should've mentioned this here too (it's in the README shown on
github): it currently depends on the 'hungarian' module for the matching
algorithm, found here:

  https://pypi.python.org/pypi/hungarian

It's easy to install, but in the interests of wider usability I'll
probably write the same in pure python eventually.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
