From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Compression and dictionaries
Date: Mon, 14 Aug 2006 18:55:53 +0200
Organization: At home
Message-ID: <ebq9tc$3gl$1@sea.gmane.org>
References: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com> <Pine.LNX.4.63.0608141415560.10541@wbgn013.biozentrum.uni-wuerzburg.de> <9e4733910608140708i45e3d6day6b87676783fd6511@mail.gmail.com> <Pine.LNX.4.63.0608141641330.28360@wbgn013.biozentrum.uni-wuerzburg.de> <9e4733910608140915i728004c1p216bf3d74fcc6ab7@mail.gmail.com> <Pine.LNX.4.63.0608140930380.14796@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Aug 14 18:56:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCfjd-0005ai-QQ
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 18:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWHNQ4Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 12:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWHNQ4Q
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 12:56:16 -0400
Received: from main.gmane.org ([80.91.229.2]:26525 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932204AbWHNQ4P (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 12:56:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GCfis-0005HW-Jn
	for git@vger.kernel.org; Mon, 14 Aug 2006 18:55:30 +0200
Received: from host-81-190-23-158.torun.mm.pl ([81.190.23.158])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 18:55:30 +0200
Received: from jnareb by host-81-190-23-158.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 18:55:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-158.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25366>

David Lang wrote:

> the other factor that was mentioned was that a single-bit corruption in the 
> dictionary would make the entire pack file useless. if this is really a concern 
> then just store multiple copies of the dictionary. on a pack with lots of files 
> in it it can still be a significant win.

Or use some error-correcting code for storing dictionary.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
