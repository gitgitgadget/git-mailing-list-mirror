From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] Internationalization of git-gui
Date: Sat, 21 Jul 2007 22:35:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707212234500.14781@racer.site>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
 <Pine.LNX.4.64.0707211427190.14781@racer.site> <7vejj1v92b.fsf@assigned-by-dhcp.cox.net>
 <200707212150.49351.stimming@tuhh.de> <7vabtpv43d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Stimming <stimming@tuhh.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 23:35:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICMcD-0002yO-Da
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 23:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764290AbXGUVfk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 17:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762965AbXGUVfk
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 17:35:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:46817 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764290AbXGUVfj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 17:35:39 -0400
Received: (qmail invoked by alias); 21 Jul 2007 21:35:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp021) with SMTP; 21 Jul 2007 23:35:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Zj5xb3AwZC6KMedSDfuu5UbxzgeZvMLCDpts6co
	plmK2SXJIzFjed
X-X-Sender: gene099@racer.site
In-Reply-To: <7vabtpv43d.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53190>

Hi,

On Sat, 21 Jul 2007, Junio C Hamano wrote:

> The division of labor I think would make sense for message l10n
> process goes like this:
> 
>  - The software developer (primarily Shawn): responsible for
>    marking messages subject to i18n;
> 
>  - The i18n coordinator (could be Shawn but anybody else can
>    volunteer; as things stand, I think Christian and Johannes
>    are doing this): responsible for running "make
>    po/git-gui.pot; make update-po" from time to time in order to
>    keep po/*.po in sync with the vocabulary.
> 
>    initially, populate "glossary" part in po/git-gui.pot;
> 
>    as needed, add entries "glossary" part in po/git-gui.pot, and
>    (if possible) add corresponding placeholders to po/*.po;
> 
>  - Translators (one for each language): responsible for updating
>    po/xx.po file;
> 
>    initially, start by copying po/git-gui.pot to create
>    po/xx.po;
> 
>    maintainance of "glossary" part of po/xx.po could also be
>    made this person's responsibility instead of i18n
>    coordinator's.
> 
> This way, the translators do not have to be so familiar with the
> gettext toolchain nor even have to have gettext installed.

Makes tons of sense to me.

Ciao,
Dscho
