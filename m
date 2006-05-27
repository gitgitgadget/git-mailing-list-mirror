From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
Date: Sat, 27 May 2006 12:15:59 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0605271212210.6670@yvahk01.tjqt.qr>
References: <4477B905.9090806@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 27 12:18:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fjvsk-0005bh-TH
	for gcvg-git@gmane.org; Sat, 27 May 2006 12:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWE0KSn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 06:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWE0KSn
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 06:18:43 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:28811 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750740AbWE0KSm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 06:18:42 -0400
Received: from linux01.gwdg.de (localhost [127.0.0.1])
	by linux01.gwdg.de (8.13.3/8.13.3/SuSE Linux 0.7) with ESMTP id k4RAGUaO006996;
	Sat, 27 May 2006 12:16:33 +0200
Received: from localhost (jengelh@localhost)
	by linux01.gwdg.de (8.13.3/8.13.3/Submit) with ESMTP id k4RAGFbS006985;
	Sat, 27 May 2006 12:16:18 +0200
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <4477B905.9090806@garzik.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20841>

> Attached to this email is chomp.pl, a Perl script which removes trailing
> whitespace from several files.  I've had this for years, as trailing whitespace
> is one of my pet peeves.
>
> Now that git-applymbox complains loudly whenever a patch adds trailing
> whitespace, I figured this script may be useful to others.
>

Pretty long script. How about this two-liner? It does not show 'bytes 
chomped' but it also trims trailing whitespace.

#!/usr/bin/perl -i -p
s/[ \t\r\n]+$//



Jan Engelhardt
-- 
