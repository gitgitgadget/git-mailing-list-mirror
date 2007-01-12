From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: [PATCH] git-status: wording update to deal with deleted files.
Date: Fri, 12 Jan 2007 23:13:26 +0100
Message-ID: <17832.2054.95000.756004@lapjr.intranet.kiel.bmiag.de>
References: <87bql5cok3.fsf@morpheus.local>
	<7vejq12nlu.fsf@assigned-by-dhcp.cox.net>
	<7vsleh16ey.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 23:13:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Ueh-00075t-Bw
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 23:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbXALWNo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 17:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161135AbXALWNo
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 17:13:44 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:52569 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161134AbXALWNn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 17:13:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 0D20C3AED7;
	Fri, 12 Jan 2007 23:13:40 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18594-07; Fri, 12 Jan 2007 23:13:40 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de (eotheod.intranet.kiel.bmiag.de [10.130.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id BC0F83AED2;
	Fri, 12 Jan 2007 23:13:39 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 90DAB3ADC8;
	Fri, 12 Jan 2007 23:13:38 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00846-10; Fri, 12 Jan 2007 23:13:35 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 0F8233ADC6;
	Fri, 12 Jan 2007 23:13:29 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsleh16ey.fsf_-_@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 22.0.92.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36719>

Junio C Hamano writes:
 > If you do:
 > 
 > 	$ /bin/rm foo
 > 	$ git status
 > 
 > we used to say "git add ... to add content to commit".  But
 > suggsting "git add" to record the deletion of a file is simply
 > insane.
 > 
 > So this rewords various things:
 > 
 >  - The section header is the old "Changed but not updated",
 >    instead of "Changed but not added";
 > 
 >  - Suggestion is "git add ... to update what will be committed",
 >    instead of "... to add content to commit";
 > 
 >  - If there are removed paths, the above suggestion becomes "git
 >    add/rm ... to update what will be committed";
 > 
 >  - For untracked files, the suggestion is "git add ... to
 >    include in what will be committed".
 > 
 > Signed-off-by: Junio C Hamano <junkio@cox.net>

I should have beaten you to it, since Michael had already noticed that
on wednesday, but I was too busy. Thanks.
