From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 10:21:31 +0200
Message-ID: <20080827102131.49e018ee@hyperion.delvare>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
	<1219664940.9583.42.camel@pmac.infradead.org>
	<alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	<7vy72kek6y.fsf@gitster.siamese.dyndns.org>
	<20080826145719.GB5046@coredump.intra.peff.net>
	<1219764860.4471.13.camel@gaara.bos.redhat.com>
	<1219766398.7107.87.camel@pmac.infradead.org>
	<20080826182349.0a1a75e2@hyperion.delvare>
	<s5hvdxnlnzi.wl%tiwai@suse.de>
	<20080826192039.5ffa6eec@hyperion.delvare>
	<48B50574.6020502@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Kristian =?ISO-8859-1?B?SPhnc2Jlcmc=?= <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Aug 27 10:23:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYGJH-0005rk-Pe
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 10:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbYH0IWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 04:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754059AbYH0IWL
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 04:22:11 -0400
Received: from zone0.gcu-squad.org ([212.85.147.21]:9995 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670AbYH0IWK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 04:22:10 -0400
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1KYHGg-00078Y-Ef
	(TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	; Wed, 27 Aug 2008 11:24:46 +0200
In-Reply-To: <48B50574.6020502@op5.se>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93872>

On Wed, 27 Aug 2008 09:42:44 +0200, Andreas Ericsson wrote:
> Jean Delvare wrote:
> > On Tue, 26 Aug 2008 18:50:25 +0200, Takashi Iwai wrote:
> >> netpbm has almost 300 in /usr/bin.
> > 
> > Ouch. (I guess I shouldn't have asked.)
> > 
> > Does netpbm do anything convert (ImageMagick) doesn't? I'd be happy to
> > get rid of netpbm.
> > 
> 
> netpbm-progs (the rpm containing all the 320 programs in /usr/bin) is
> required for xmlto to function properly, which in turn is necessary
> to build the git documentation.
> 
> This is on Fedora 9, btw.

On openSuse systems it is required by sax2-gui only. But just because
it is used by these 2 packages doesn't mean that ImageMagick's convert
can't be used instead. Someone would need to check what exactly xmlto
and sax2-gui use in netpbm and whether convert could be used instead.
I'd do if I only I had the time... :/

-- 
Jean Delvare
