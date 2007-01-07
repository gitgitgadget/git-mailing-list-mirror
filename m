From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
Date: Sun, 7 Jan 2007 21:40:45 +0100 (MET)
Message-ID: <Pine.LNX.4.61.0701072139520.4365@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
 <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr>
 <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc>
 <1168182838.14763.24.camel@shinybook.infradead.org>
 <20070107153833.GA21133@flint.arm.linux.org.uk> <20070107182151.7cc544f3@localhost.localdomain>
 <20070107191730.GD21133@flint.arm.linux.org.uk> <20070107200553.GA15101@redhat.com>
 <20070107151514.be9430b1.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dave Jones <davej@redhat.com>, Alan <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Tilman Schmidt <tilman@imap.cc>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 21:46:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3euP-0005SL-1H
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 21:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbXAGUqO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 15:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbXAGUqO
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 15:46:14 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:37116 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965152AbXAGUqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 15:46:13 -0500
Received: from linux01.gwdg.de ([134.76.13.21])
	by mailer.gwdg.de with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <jengelh@linux01.gwdg.de>)
	id 1H3eu1-0007eV-Tx; Sun, 07 Jan 2007 21:46:02 +0100
Received: from linux01.gwdg.de (localhost [127.0.0.1])
	by linux01.gwdg.de (8.13.3/8.13.3/SuSE Linux 0.7) with ESMTP id l07KekYF031630;
	Sun, 7 Jan 2007 21:40:48 +0100
Received: from localhost (jengelh@localhost)
	by linux01.gwdg.de (8.13.3/8.13.3/Submit) with ESMTP id l07KejKU031624;
	Sun, 7 Jan 2007 21:40:45 +0100
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <20070107151514.be9430b1.seanlkml@sympatico.ca>
X-Spam-Level: /
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
X-Virus-Scanned: (clean) by exiscan+sophie
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36196>


>On Sun, 7 Jan 2007 15:05:53 -0500
>Dave Jones <davej@redhat.com> wrote:
>
>> If there's something I should be doing when I commit that I'm not,
>> I'll be happy to change my scripts.  My $LANG is set to en_US.UTF-8
>> which should DTRT to the best of my knowledge, but clearly, that isn't
>> the case.

No, LC_CTYPE defines what charset you use. (I may be wrong, though.)


	-`J'
-- 
