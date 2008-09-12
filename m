From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: CGit and repository list
Date: Fri, 12 Sep 2008 10:45:13 -0700
Message-ID: <20080912174513.GO22960@spearce.org>
References: <19449377.post@talk.nabble.com> <200809121754.30277.jnareb@gmail.com> <20080912160538.GB10360@machine.or.cz> <200809121940.43471.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 19:46:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeCiu-0000zO-V0
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 19:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146AbYILRpQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Sep 2008 13:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755210AbYILRpQ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 13:45:16 -0400
Received: from george.spearce.org ([209.20.77.23]:56986 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561AbYILRpP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 13:45:15 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 027C33835C; Fri, 12 Sep 2008 17:45:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200809121940.43471.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95754>

Jakub Narebski <jnareb@gmail.com> wrote:
> Dnia pi=C4=85tek 12. wrze=C5=9Bnia 2008 18:05, Petr Baudis napisa=C5=82=
:
> > On Fri, Sep 12, 2008 at 05:54:29PM +0200, Jakub Narebski wrote:
> >>
> >> P.S. Could you please gather some statistics to compare the period
> >> before and after installing "smart" HTTP server (and after smart
> >> clients became widespread).
> >=20
> > What kind of statistics?
>=20
> In short: check how "smart" HTTP protocol would improve things.

The real improvement is on the client side; how long does it take
to do a clone or a fetch with dumb HTTP vs. with smart HTTP.  The
latency is horrible for dumb HTTP if the repository is not packed,
or bad if it just repacked and you have to download everything again.

Knowing the transfer time of each request start-to-finish and the
total time for a "session" (e.g. a period of where that IP appears
actively requesting in the logs) would tell you how long a given
client needs to do a fetch or clone.

--=20
Shawn.
