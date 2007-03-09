From: Anton Tropashko <atropashko@yahoo.com>
Subject: Errors cloning large repo
Date: Fri, 9 Mar 2007 11:20:35 -0800 (PST)
Message-ID: <284107.69764.qm@web52601.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 09 20:28:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPkl8-0000Vg-N5
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 20:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933151AbXCIT1R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 14:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933382AbXCIT1R
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 14:27:17 -0500
Received: from web52601.mail.yahoo.com ([206.190.48.204]:33595 "HELO
	web52601.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933151AbXCIT1Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2007 14:27:16 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Mar 2007 14:27:15 EST
Received: (qmail 72183 invoked by uid 60001); 9 Mar 2007 19:20:35 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=aFOdxbsak0i7JcY90r5YC3B8hhBLZ34A4hvGO45jvgfFC+eLljOfyqxEfSyXdNLDEC0XGtUnFouUQOhq3MRafrdFpOujAxYISRpGBn1Jv/DWNXOxQ/7c3pXI1tWPIbWB6hUXpXV2q6aPluun3FVltEp42iaVjo7dLsLa3+Cu8ls=;
Received: from [129.188.69.169] by web52601.mail.yahoo.com via HTTP; Fri, 09 Mar 2007 11:20:35 PST
X-Mailer: YahooMailRC/471 YahooMailWebService/0.6.132.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41807>

I managed to stuff 8.5 GB worth of files into a git repo (two two git commits since
it was running out of memory when I gave it -a option)

but when I'm cloning to another linux box I get:

Generating pack...
Done counting 152200 objects.
Deltifying 152200 objects.
0* 80% (122137/152200) donee
 100% (152200/152200) done
/usr/bin/git-clone: line 321:  2072 File size limit exceededgit-fetch-pack --all -k $quiet "$repo"


Would be nice to be able to work around this somehow if the bug can not be fixed.
1.5.0 on the server
1.4.1 on the client





 
____________________________________________________________________________________
Food fight? Enjoy some healthy debate 
in the Yahoo! Answers Food & Drink Q&A.
http://answers.yahoo.com/dir/?link=list&sid=396545367
