From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
Date: Sat, 27 May 2006 14:42:02 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0605271441080.4857@yvahk01.tjqt.qr>
References: <4477B905.9090806@garzik.org> <Pine.LNX.4.61.0605271212210.6670@yvahk01.tjqt.qr>
 <447838EB.9060900@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 27 14:42:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fjy7b-00058Z-KO
	for gcvg-git@gmane.org; Sat, 27 May 2006 14:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWE0MmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 08:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWE0MmN
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 08:42:13 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:29839 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751026AbWE0MmM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 08:42:12 -0400
Received: from linux01.gwdg.de (localhost [127.0.0.1])
	by linux01.gwdg.de (8.13.3/8.13.3/SuSE Linux 0.7) with ESMTP id k4RCg5f7004928;
	Sat, 27 May 2006 14:42:08 +0200
Received: from localhost (jengelh@localhost)
	by linux01.gwdg.de (8.13.3/8.13.3/Submit) with ESMTP id k4RCg4jW004904;
	Sat, 27 May 2006 14:42:04 +0200
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <447838EB.9060900@garzik.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20852>

>> Pretty long script. How about this two-liner? It does not show 'bytes
>> chomped' but it also trims trailing whitespace.
>> 
>> #!/usr/bin/perl -i -p
>> s/[ \t\r\n]+$//
>
> Yes, it does, but a bit too aggressive for what we need :)
>
Whoops, should have been s/[ \t\r]+$//
And the CL form is
  perl -i -pe '...'

Somehow, you can't group it to -ipe, but who cares.


Jan Engelhardt
-- 
