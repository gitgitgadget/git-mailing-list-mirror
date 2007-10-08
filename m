From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 1/4] git-gui i18n: Add more words to glossary.
Date: Mon, 8 Oct 2007 21:43:13 +0200
Message-ID: <200710082143.13750.stimming@tuhh.de>
References: <200710052239.02492.stimming@tuhh.de> <Pine.LNX.4.64.0710080029430.4174@racer.site> <20071007233937.GG2137@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 20:51:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iexhp-00056I-3q
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 20:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260AbXJHSvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 14:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755236AbXJHSvn
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 14:51:43 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:60105 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140AbXJHSvn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 14:51:43 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l98IpZBO028721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 8 Oct 2007 20:51:35 +0200
Received: from [192.168.2.102] (p54900848.dip0.t-ipconnect.de [84.144.8.72])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l98IpYlv018285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Oct 2007 20:51:35 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <20071007233937.GG2137@spearce.org>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60333>

Am Montag, 8. Oktober 2007 01:39 schrieb Shawn O. Pearce:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Sun, 7 Oct 2007, Shawn O. Pearce wrote:
> > > If you are sending a series like that and its all po translation stuff
> > > that is unlikely to need commenting on feel free to just dump it all
> > > out as a single mbox (`git format-patch --stdout`) and attach it to the
> > > email.  Less chance of the MUA mangling the message.
> >
> > In this case, I suggest just pushing it to git-gui-i18n.git, maybe as a
> > temporary branch "for-shawn", and send a pull request.  That's the best
> > way to ensure that nothing gets mangled.
>
> Yea, that's an even better option.  :-)

All pushed to git-gui-i18n.git mob branch now.  I hope you can easily merge 
them over.

Maybe po/git-gui.pot should be updated by you on git-gui.git and (by Dscho?) 
on git-gui-i18n.git as well. 

In other news, according to http://marc.info/?l=git&m=119170887523610&w=2 
(almost last paragraph) people are already recognizing the localized 
versions, but this also means the translations have to be watched out for so 
that they will get updated as completely as possible especially before the 
next release. 
http://wiki.gnucash.org/wiki/index.php?title=String_Freeze&oldid=2022 is an 
example on how the gnucash project tried to communicate to its translators 
how the special "string freeze" period (i.e. a few weeks before the release) 
will be handled in order to get a finalized translation for the actual 
release. I don't know how formal you want to put this, but at least *some* 
period of string freeze would be very good. As for the German translation, 
I'd prefer any period length greater than 10 days in order to verify a 
complete translation...

Regards,

Christian
