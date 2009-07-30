From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv3 1/8] Introduce commit notes
Date: Thu, 30 Jul 2009 02:50:03 +0200
Message-ID: <200907300250.03485.johan@herland.net>
References: <1248834326-31488-1-git-send-email-johan@herland.net>
 <81b0412b0907290152w27c1b5b5l9efbd6980d4f904e@mail.gmail.com>
 <alpine.DEB.1.00.0907291839350.7626@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>, gitster@pobox.com,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 02:50:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWJqa-0006Xy-Nf
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 02:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205AbZG3AuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 20:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754901AbZG3AuF
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 20:50:05 -0400
Received: from mx.getmail.no ([84.208.15.66]:40628 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754875AbZG3AuE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 20:50:04 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNK00KTZKZG5D90@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 30 Jul 2009 02:50:04 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNK00IW3KZFT220@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 30 Jul 2009 02:50:04 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.7.30.3622
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <alpine.DEB.1.00.0907291839350.7626@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124427>

On Wednesday 29 July 2009, Johannes Schindelin wrote:
> On Wed, 29 Jul 2009, Alex Riesen wrote:
> > On Wed, Jul 29, 2009 at 04:25, Johan Herland<johan@herland.net> wrote:
> > > @@ -963,5 +964,9 @@ void pretty_print_commit(enum cmit_fmt fmt, const
> > > struct commit *commit, +
> > > +       if (fmt != CMIT_FMT_ONELINE)
> > > +               get_commit_notes(commit, sb, encoding);
> > > +
> >
> > Someday we will need a way to switch off the display of notes
> > without resolving to oneline format.
> > Is there a notes specifier for the printf-like log message formatting
> > (--pretty=format: or --format) planned, BTW?
>
> That would probably be something like "GIT_NOTES_REF=nyanyanya git log"?

Yes, that works, although I suspect some users will prefer a command-line
argument instead.

Nonetheless, I think it makes sense to add a notes specifier to be used in 
--pretty/--format.

I'll try to remember to look into this later, but I'll be grateful if 
someone gets to it before me.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
