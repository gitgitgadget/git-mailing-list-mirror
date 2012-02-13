From: Pete Wyckoff <pw@padd.com>
Subject: Re: [RFC PATCH 0/3] git-p4: move to toplevel
Date: Mon, 13 Feb 2012 18:37:06 -0500
Message-ID: <20120213233706.GB29582@padd.com>
References: <1329070423-23761-1-git-send-email-pw@padd.com>
 <4F380ADB.4090304@diamand.org>
 <7vwr7rgsuw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org,
	Vitor Antunes <vitor.hda@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 00:37:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx5SM-0008Qw-Sd
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 00:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256Ab2BMXhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 18:37:11 -0500
Received: from honk.padd.com ([74.3.171.149]:34105 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753189Ab2BMXhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 18:37:09 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 8D9CE24A6;
	Mon, 13 Feb 2012 15:37:08 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3664F313C6; Mon, 13 Feb 2012 18:37:06 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vwr7rgsuw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190690>

gitster@pobox.com wrote on Sun, 12 Feb 2012 22:17 -0800:
> Luke Diamand <luke@diamand.org> writes:
> 
> > On 12/02/12 18:13, Pete Wyckoff wrote:
> >> The git-p4 code is in a single python script down in
> >> contrib/fast-import now.  I'd like to move it up to the top-level
> >> source directory of git to make it easier to build and
> >> distribute.  Git-p4 already takes advantage of the git
> >> infrastructure for documentation and testing, as well as the
> >> community support (Junio, many reviewers).
> >
> > About time this was done. There's still a few oddities around but far
> > fewer than there used to be. I don't know if Junio has some rules on
> > what a command needs before it graduates from contrib though.
> 
> I try not to play a dictator around here. The primary thing I hesitated so
> far about git-p4 is that it is useless if you live in the open source only
> world, iow without proprietary software.

Yes, sad.  Git-p4 at least helps people who have no choice but to
use p4, e.g., when working in a corporate environment.

It's been a big help developing git-p4 inside the git source tree
already.  Having git-p4 be an installed component would make it
easier on users.  "make install" puts the script where it goes.
Or better, they get it through their OS distribution.

		-- Pete
