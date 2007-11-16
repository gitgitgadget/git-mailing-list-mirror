From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: preserving mtime
Date: Fri, 16 Nov 2007 11:19:32 +0100
Organization: At home
Message-ID: <fhjqrp$v14$1@ger.gmane.org>
References: <473D63F9.4010201@inrim.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 16 11:20:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsyJ4-0008SO-M3
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 11:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755685AbXKPKT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 05:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753267AbXKPKT5
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 05:19:57 -0500
Received: from main.gmane.org ([80.91.229.2]:50711 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756130AbXKPKT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 05:19:57 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IsyIb-0003XA-Vz
	for git@vger.kernel.org; Fri, 16 Nov 2007 10:19:45 +0000
Received: from aabk102.neoplus.adsl.tpnet.pl ([83.4.36.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Nov 2007 10:19:45 +0000
Received: from jnareb by aabk102.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Nov 2007 10:19:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: aabk102.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65212>

Fabrizio Pollastri wrote:

> is it possible to tell git to preserve the file modification time in a 
> checked out copy? It is useful when managing web files, where mtime is 
> tested by spiders for download decisions.

I don't quite understand. When git checks out copy, or switch branches,
or resets it does update only files which changed.

Git does not store mtime of files in tree object.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
