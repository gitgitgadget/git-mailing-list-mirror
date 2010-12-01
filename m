From: jari <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/config.txt: Order variables
 alphabetically
Date: Wed, 1 Dec 2010 17:09:17 +0200
Message-ID: <20101201150917.GD6537@picasso.cante.net>
References: <1291209174-9239-1-git-send-email-jari.aalto@cante.net>
 <m3eia14mu7.fsf@localhost.localdomain>
 <20101201142920.GB6537@picasso.cante.net>
 <201012011557.30849.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 16:09:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNoJD-0002CA-NU
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 16:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039Ab0LAPJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 10:09:22 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:55709 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab0LAPJW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 10:09:22 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 1B70A18CFE7;
	Wed,  1 Dec 2010 17:09:21 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A0746518046; Wed, 01 Dec 2010 17:09:21 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 25BD11C638F;
	Wed,  1 Dec 2010 17:09:17 +0200 (EET)
Received: from jaalto by picasso.cante.net with local (Exim 4.72)
	(envelope-from <jaalto@picasso.cante.net>)
	id 1PNoJ3-00030w-R5; Wed, 01 Dec 2010 17:09:17 +0200
Content-Disposition: inline
In-Reply-To: <201012011557.30849.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: jaalto@picasso.cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162529>

On 2010-12-01 15:57, Jakub Narebski wrote:
| On Wed, 1 Dec 2010, Jari Aalto wrote:
| > On 2010-12-01 05:58, Jakub Narebski wrote:
| > | jari.aalto@cante.net writes:
| > | 
| > | > From: Jari Aalto <jari.aalto@cante.net>
| > | > 
| > | > 
| > | > Signed-off-by: Jari Aalto <jari.aalto@cante.net>
| > | > ---
| > | >  Documentation/config.txt | 1698 +++++++++++++++++++++++-----------------------
| > | >  1 files changed, 852 insertions(+), 846 deletions(-)
| > | 
| > | Why?  What such large change is for?
| > | 
| > | Note that currently config variables are grouped by functionality: for
| > | example core.eol and core.safecrlf, or core.compression and
| > | core.loosecompression are close to each other.
| 
| What about the above?

We use standard biblical refences:

	 Se ....

Suggest what is needed, and it will be so.

| > The phone books have an index where to up information.
| > 
| >     - When you see script and it use VARIABLE, you look it from
| >       manual page
| 
| Manpages (and 'git <cmd> --help') are displayed in pager, so you can
| always search for option in a pager (e.g. '/' in 'less', the default
| pager).

Yuck, it's real fun start backward/forward ping-pong when you dont'
know the directions and can't rely on standard A-Z index.

| > It is same as putting option in alphabetical order. See GNU cp(1),
| > ssh(1) etc.
| 
| In git documentation command line options are not in alphabetical order,
| but grouped by functionality, therefore your argument is invalid.

I see that only in pages that have tens and tens and tens of options..

The problem is more the asciidoc's. Various bits and pices are
"included" in place and make orderign the options impossile in some
pages.

Let's get all pages in shape with A-Z in this regard. That's a god
quality goal.

| > There are zillion values and for a reference, alphabetical order makes
| > sense.
| 
| I agree that alphabetical order makes sense for glossary; I disagree that
| it makes sense here.

About 60% in git-config is already in alpha order (core.*, sendmail.*
etc), so there is not really much that is changing.

Well. If standard reading order is not the standard, I don't know what
is.

Jari
