From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: git 1.2.4 and linux-2.6 tree problem
Date: Fri, 14 Jul 2006 17:58:43 +0200
Organization: tuxland
Message-ID: <200607141758.43197.m.kozlowski@tuxland.pl>
References: <200607141620.05350.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 14 17:58:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1Q3z-00059z-DA
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 17:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbWGNP6o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 11:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbWGNP6o
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 11:58:44 -0400
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:15116 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1161139AbWGNP6o
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 11:58:44 -0400
Received: from [192.168.1.3] (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by tuxland.pl (Postfix) with ESMTP id 7DCF06EF3F
	for <git@vger.kernel.org>; Fri, 14 Jul 2006 17:58:42 +0200 (CEST)
Received: from [192.168.1.3] ([192.168.1.3])
	by tuxland.pl (AISK)
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <200607141620.05350.m.kozlowski@tuxland.pl>
Content-Disposition: inline
X-Virus-Scanned: AISK at tuxland.pl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23894>

Hello again, 

> The thing is when I try to pull
'clone'

> After downloading approx. 60MB I get these errors:
The same happens with git version 1.4.1:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
Generating pack...
Done counting 293611 objects.
Deltifying 293611 objects.
 100% (293611/293611) done
fatal: unexpected EOF)      
fatal: packfile '/home/me/linux/linux-2.6/.git/objects/pack/tmp-FtdxDS' SHA1 mismatch
error: git-fetch-pack: unable to read from git-index-pack
error: git-index-pack died with error code 128
fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git' failed.

Hope that helps.

Regards,

        Mariusz
