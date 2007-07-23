From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 1/5] Internationalization of git-gui
Date: Mon, 23 Jul 2007 21:23:01 +0200
Message-ID: <200707232123.01682.stimming@tuhh.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <200707211433.29318.stimming@tuhh.de> <20070722073806.GW32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 21:25:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID3XI-0008GJ-Tx
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 21:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762353AbXGWTZi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 15:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761177AbXGWTZi
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 15:25:38 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:38648 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288AbXGWTZh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 15:25:37 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6NJMkUX025720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 23 Jul 2007 21:22:47 +0200
Received: from [192.168.2.102] (p5490052D.dip0.t-ipconnect.de [84.144.5.45])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6NJMjwq030896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2007 21:22:46 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <20070722073806.GW32566@spearce.org>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53465>

Am Sonntag, 22. Juli 2007 09:38 schrieb Shawn O. Pearce:
> > +## Internationalization (i18n) through msgcat and gettext. See
> > +## http://www.gnu.org/software/gettext/manual/html_node/Tcl.html
> > +package require msgcat
> > +::msgcat::mcload [file join $oguilib msgs]
> > +namespace import ::msgcat::mc
>
> Thanks.  We'll probably also want to modify the lib/class.tcl to
> import ::msgcat::mc into the class namespace when it creates it.
> I use that class thing throught most of git-gui, especially for
> UI code.  About 50% of git-gui has been converted to use class,
> the other 50% is just global and is still in git-gui.sh.  ;-)

As I was adding the markup in all the other files, I didn't have to add 
another import statement anywhere else. Seems like the global mc procedure 
works just fine.

In other words, if you think the mc procedure should be imported in another 
place as well, please do so because I don't know your future plans with class 
structure (and I also don't need to know for adding the i18n support right 
now).

Thanks,

Christian
