From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: problem with git clone on cygwin
Date: Sat, 6 Jan 2007 22:40:52 +0100
Message-ID: <17824.5988.344000.501073@lapjr.intranet.kiel.bmiag.de>
References: <20070106170330.GA8041@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 22:41:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3JI1-0000RJ-PC
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 22:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbXAFVlP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 16:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbXAFVlP
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 16:41:15 -0500
Received: from bilbo.bmiag.de ([62.154.210.131]:2057 "HELO bilbo.bmiag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932210AbXAFVlO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 16:41:14 -0500
Received: (qmail 4895 invoked by uid 106); 6 Jan 2007 21:41:11 -0000
Received: from eorl.intranet.kiel.bmiag.de(10.131.2.1)
 via SMTP by bilbo.bmiag.de, id smtpdRRJbpD; Sat Jan  6 22:41:09 2007
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id EF0DE3ADC8;
	Sat,  6 Jan 2007 22:41:08 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 20923-04; Sat, 6 Jan 2007 22:41:01 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id E6CC03ADC6;
	Sat,  6 Jan 2007 22:40:57 +0100 (CET)
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
In-Reply-To: <20070106170330.GA8041@scotty.home>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36101>

Stefan-W. Hahn writes:
 > It seems to be a problem with cygwin.dll prior v1.5.22 and pread(), if
 > using an offset!=0. (I'm running cygwin.dll v1.5.21 build date
 > 2006-07-27 and I can't update because of other compatibility problems).

You should compile a cygwin.dll from 1.5.21 sources with the pread
patch applied.

Could you enumerate the other compatability problems?
