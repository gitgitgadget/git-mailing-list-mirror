From: git@eisendle.net
Subject: Linux Kernel based project in git
Date: Tue, 2 Feb 2010 10:05:24 +0100
Message-ID: <9da7f2802f639777acfeb38eb1e3db90.squirrel@webmail.eisendle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 10:12:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcEny-0000fb-T4
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 10:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439Ab0BBJMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 04:12:12 -0500
Received: from vs.eisendle.net ([62.75.248.112]:52608 "EHLO eisendle.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753404Ab0BBJMH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 04:12:07 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2010 04:12:06 EST
Received: (qmail 15409 invoked from network); 2 Feb 2010 09:05:24 -0000
Received: from unknown (HELO webmail.eisendle.net) ([127.0.0.1])
          (envelope-sender <git@eisendle.net>)
          by localhost (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 2 Feb 2010 09:05:24 -0000
Received: from 212.166.112.250 (proxying for unknown)
        (SquirrelMail authenticated user git@eisendle.net)
        by webmail.eisendle.net with HTTP;
        Tue, 2 Feb 2010 10:05:24 +0100
User-Agent: SquirrelMail/1.4.19
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138704>

Hi,

I'm rather new to this mailing list so I hope this is the right place for
my question :-)

We recently moved one of our projects over from SVN to git.
This project is basically a Linux BSP for an ARM9 based processor using
Kernel 2.6.22.

For release we always generate 3 patches:
- BSP patch
- USB patch (since USB part is an external patch comming from a 3rd party)
- WiFi patch (same as for USB)

So my question is:
What's the best way for handling this inside the git repository?

IMHO it would make sense to have 3 branches (BSP, USB, WiFi) each based on
unmodified 2.6.22 Kernel. USB and WiFi branch is used for generating the
patch and for applying possible fixes. BSP branch for actual BSP related
feature development and fixes.
The changes in these branches are merged into the master branch which is
used for compiling/testing the whole BSP.

Is this a useful approach or are there other, better ways for generating
the three patches and compiling testing the whole thing?

Thanks!
Christian.
