From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 17:14:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808271710480.22151@vixen.sonytel.be>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
 <1219664940.9583.42.camel@pmac.infradead.org>
 <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net>
 <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org>
 <20080826182349.0a1a75e2@hyperion.delvare> <s5hvdxnlnzi.wl%tiwai@suse.de>
 <20080826192039.5ffa6eec@hyperion.delvare> <48B50574.6020502@op5.se>
 <20080827102131.49e018ee@hyperion.delvare>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584349381-863095853-1219850076=:22151"
Cc: Andreas Ericsson <ae@op5.se>, Jeff King <peff@peff.net>,
	Takashi Iwai <tiwai@suse.de>,
	Schindelin <Johannes.Schindelin@gmx.de>, users@kernel.org,
	Johannes@hera.kernel.org,
	Kristian =?ISO-8859-1?B?SPhnc2Jlcmc=?= <krh@redhat.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 17:17:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYMkL-0006MB-FT
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 17:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbYH0POj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 11:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752967AbYH0POj
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 11:14:39 -0400
Received: from vervifontaine.sonytel.be ([80.88.33.193]:60137 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752724AbYH0POi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2008 11:14:38 -0400
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 8374358AD0;
	Wed, 27 Aug 2008 17:14:36 +0200 (MEST)
In-Reply-To: <20080827102131.49e018ee@hyperion.delvare>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93893>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-863095853-1219850076=:22151
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 27 Aug 2008, Jean Delvare wrote:
> On Wed, 27 Aug 2008 09:42:44 +0200, Andreas Ericsson wrote:
> > Jean Delvare wrote:
> > > On Tue, 26 Aug 2008 18:50:25 +0200, Takashi Iwai wrote:
> > >> netpbm has almost 300 in /usr/bin.
> > > 
> > > Ouch. (I guess I shouldn't have asked.)
> > > 
> > > Does netpbm do anything convert (ImageMagick) doesn't? I'd be happy to
> > > get rid of netpbm.
> > 
> > netpbm-progs (the rpm containing all the 320 programs in /usr/bin) is
> > required for xmlto to function properly, which in turn is necessary
> > to build the git documentation.
> > 
> > This is on Fedora 9, btw.
> 
> On openSuse systems it is required by sax2-gui only. But just because
> it is used by these 2 packages doesn't mean that ImageMagick's convert
> can't be used instead. Someone would need to check what exactly xmlto
> and sax2-gui use in netpbm and whether convert could be used instead.
> I'd do if I only I had the time... :/

Great, let's start a witch (nazi? ;-) hunt on any package installing more than
$n binaries in /usr/bin, and any packages depending on it...

Get used to the `choice' you and I have between netpbm and ImageMagick (and
whatever other image manipulation tool), just like the choice between
`git<space><subcmd>' and `git-<subcmd>'.

Now, let's get back to topic...

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
---584349381-863095853-1219850076=:22151--
