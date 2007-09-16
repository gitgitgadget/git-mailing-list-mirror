From: Christian Stimming <stimming@tuhh.de>
Subject: Re: git-gui i18n status?
Date: Sun, 16 Sep 2007 14:03:50 +0200
Message-ID: <200709161403.50780.stimming@tuhh.de>
References: <20070901042924.GE18160@spearce.org> <20070902022444.GK18160@spearce.org> <Pine.LNX.4.64.0709021320230.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 16 14:05:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWssO-0006DH-KI
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 14:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbXIPMFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 08:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbXIPMFU
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 08:05:20 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:48332 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbXIPMFU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 08:05:20 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l8GC4pNh012897
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sun, 16 Sep 2007 14:04:51 +0200
Received: from [192.168.2.102] (p54903878.dip0.t-ipconnect.de [84.144.56.120])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l8GC4m5K026239
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 Sep 2007 14:04:51 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0709021320230.28586@racer.site>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58314>

Hi Shawn et al.,

Am Sonntag, 2. September 2007 14:20 schrieb Johannes Schindelin:
> > > > Hmm.  I am not enough involved in i18n stuff to form a proper opinion
> > > > here...  Do you suggest to move the initialisation earlier?
> > >
> > > Yea, I think that's what we are going to have to do here.  If we don't
> > > setup the directory for the .msg files early enough than we cannot do
> > > translations through [mc].  Unfortunately that means we have to also
> > > break up the library initialization.
> > >
> > > I'll try to work up a patch that does this.
> >
> > This two patch series is based on my current master (gitgui-0.8.2).
> > Its also now in my pu branch.
>
> Sound both good to me.  Christian?

Thanks for including the i18n framework and existing translations into the 
master of git-gui. I loosely watched the progress here, but due to other 
commitments I cannot spend as much time on git-gui i18n as I initially 
thought. I'd happily update and polish the German translation, though (will 
send other email for that), but I probably can't follow any of the ongoing 
i18n cleanup work.

One question came up when seeing the i18n code really in git-gui.git: How are 
translators supposed to submit new or updated translations? Is 
git-gui-i18n.git of any use anymore? This doesn't seem so. Should updated 
translations just be submitted by email to git@vger? In any case, the 
instructions in po/README should probably be updated to explain the 
recommended way of submitting translation updates. 

Oh, and po/git-gui.pot should probably be updated to reflect the latest string 
additions and changes. 

Thanks a lot.

Christian
