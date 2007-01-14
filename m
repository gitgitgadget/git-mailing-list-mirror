From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: [PATCH] simplify the "no changes added to commit" message
Date: Sun, 14 Jan 2007 16:38:46 +0100
Message-ID: <17834.20102.334000.595383@lapjr.intranet.kiel.bmiag.de>
References: <Pine.LNX.4.64.0701132111080.2577@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:03:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VhU-0006FC-Q1
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:32:52 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V7Z-0003eK-LH
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbXANPjQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 10:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbXANPjQ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 10:39:16 -0500
Received: from bilbo.bmiag.de ([62.154.210.131]:1803 "HELO bilbo.bmiag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751314AbXANPjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 10:39:16 -0500
Received: (qmail 680 invoked by uid 106); 14 Jan 2007 15:39:14 -0000
Received: from eorl.intranet.kiel.bmiag.de(10.131.2.1)
 via SMTP by bilbo.bmiag.de, id smtpdd37bYj; Sun Jan 14 16:39:08 2007
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id AAE643ADC6;
	Sun, 14 Jan 2007 16:39:07 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 21687-01; Sun, 14 Jan 2007 16:39:03 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 4EE843ADCA;
	Sun, 14 Jan 2007 16:38:52 +0100 (CET)
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0701132111080.2577@xanadu.home>
X-Mailer: VM 7.19 under Emacs 22.0.92.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36817>

Nicolas Pitre writes:
 > Suggesting the use of [-a|-i|-o] with git-commit is unnecessarily 
 > complex and confusing.  In this context -o is totally useless and -i 
 > requires extra arguments which are not mentioned.  The only sensible 
 > hint (besides reading the man page but let's not go there) is
 > "commit -a".

Well, I would say neither -i or -o were totally useless, though
identical in this case (clean index). But I agree it's better to only
mention -a.
