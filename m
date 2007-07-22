From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] Internationalization of git-gui
Date: Sun, 22 Jul 2007 15:29:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707221526080.14781@racer.site>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
 <200707212150.49351.stimming@tuhh.de> <7vabtpv43d.fsf@assigned-by-dhcp.cox.net>
 <200707221535.46422.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sun Jul 22 16:29:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICcRW-0000Tx-TY
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 16:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbXGVO3v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 10:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbXGVO3v
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 10:29:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:54393 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751363AbXGVO3u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 10:29:50 -0400
Received: (qmail invoked by alias); 22 Jul 2007 14:29:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 22 Jul 2007 16:29:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181rzk8IE01y4EN29DDABD7Ocr3Sa6LyNHxTYZVBs
	q2hyoE+3zUFsNT
X-X-Sender: gene099@racer.site
In-Reply-To: <200707221535.46422.stimming@tuhh.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53271>

Hi,

On Sun, 22 Jul 2007, Christian Stimming wrote:

> Am Samstag, 21. Juli 2007 23:28 schrieb Junio C Hamano:
>
> >  - The i18n coordinator (could be Shawn but anybody else can
> >    volunteer; as things stand, I think Christian and Johannes
> >    are doing this): responsible for running "make
> >    po/git-gui.pot; make update-po" from time to time in order to
> >    keep po/*.po in sync with the vocabulary.
> 
> Actually, please DO NOT RUN update-po except right before a new tarball 
> is being packaged and distributed! It sucks royally if I have updated my 
> de.po translation, only to discover someone has run update-po on the 
> server and I have to figure out how to get out of the de.po conflicts.

I plan to work on that.  It seems to be pretty easy to define a sane merge 
behaviour, and we have gitattributes: by setting "*.po diff=po merge=po" 
we can provide a custom merge program, just for .po files.

> >  - Translators (one for each language): responsible for updating
> >    po/xx.po file;
> >
> >    initially, start by copying po/git-gui.pot to create
> >    po/xx.po;
> >
> >    maintainance of "glossary" part of po/xx.po could also be
> >    made this person's responsibility instead of i18n
> >    coordinator's.
> >
> > This way, the translators do not have to be so familiar with the
> > gettext toolchain nor even have to have gettext installed.
> 
> Translators who are unfamiliar with gettext are a mixed blessing. [...] 
> I wouldn't spent too much effort to enable translation work without 
> gettext tools; instead, I'd rather encourage to optimize the setup for 
> those translators that have the full toolchain available.

You need not work on the "without gettext toolchain" part; I will.  Let's 
see how far I get ;-)

Ciao,
Dscho
