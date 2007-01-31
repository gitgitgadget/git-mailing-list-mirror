From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Don't coredump on bad refs in update-server-info.
Date: Wed, 31 Jan 2007 09:20:47 +0100
Organization: At home
Message-ID: <eppjeg$tgk$1@sea.gmane.org>
References: <20070131072444.GA28804@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 09:20:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCAhJ-0005Cn-BX
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 09:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbXAaIT7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 03:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbXAaIT7
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 03:19:59 -0500
Received: from main.gmane.org ([80.91.229.2]:47455 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbXAaIT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 03:19:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCAgv-00018v-LN
	for git@vger.kernel.org; Wed, 31 Jan 2007 09:19:41 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 09:19:41 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 09:19:41 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38233>

Shawn O. Pearce wrote:

> Apparently if we are unable to parse an object update-server-info
> coredumps, as it doesn't bother to check the return value of its

"Apparently if we are unable to parse an object _then_ update-server-info
 coredumps" is a bit more easier to understand.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
