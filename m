From: Luben Tuikov <ltuikov@yahoo.com>
Subject: "p4 revert -a" equivalent in git?
Date: Fri, 23 Dec 2005 16:13:08 -0800 (PST)
Message-ID: <20051224001308.7078.qmail@web31805.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Dec 24 01:13:20 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Epx2F-0007Yr-Mk
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 01:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161142AbVLXANM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Dec 2005 19:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbVLXANM
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Dec 2005 19:13:12 -0500
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:9912 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161142AbVLXANL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2005 19:13:11 -0500
Received: (qmail 7080 invoked by uid 60001); 24 Dec 2005 00:13:08 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=BHX7qZ44/DmGHsNJbgcJS8CDWFrUDyArYv4RzgrH/V9ySt9fwk5qv78ZcGsnI3LOkueLY5i9Hvdohy7cVvfR1tbNle/ym/kwlGnCI9Lo8dnsfdb2ReKPrPpx2/MJDuulMv07k49ximwRoX6RE0LD1UYQQDOI4XIGcYoqtcMPx/E=  ;
Received: from [70.144.138.203] by web31805.mail.mud.yahoo.com via HTTP; Fri, 23 Dec 2005 16:13:08 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14001>

Hi,

Is there a "p4 revert -a" equivalent in git or should I
whip up a script using git-diff-index and git-update-index?

That is I want to git-update-index --refresh for all
files whose inode may have changed but the actual file
data has not (i.e. git-diff-index is empty).

Thanks,
   Luben
