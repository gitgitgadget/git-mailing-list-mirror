From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: .git/info/refs
Date: Wed, 24 Jan 2007 18:25:38 +0100
Organization: At home
Message-ID: <ep83ur$p3i$2@sea.gmane.org>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org> <45B7818F.6020805@zytor.com> <Pine.LNX.4.63.0701241658490.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45B78836.5080508@zytor.com> <Pine.LNX.4.63.0701241731400.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45B78C55.2030204@zytor.com> <Pine.LNX.4.63.0701241746390.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45B79208.2080502@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 18:53:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9mJh-0005zl-9e
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 18:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbXAXRxq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 12:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbXAXRxq
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 12:53:46 -0500
Received: from main.gmane.org ([80.91.229.2]:37543 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062AbXAXRxp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 12:53:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H9mJW-000767-Od
	for git@vger.kernel.org; Wed, 24 Jan 2007 18:53:38 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 18:53:38 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 18:53:38 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37662>

H. Peter Anvin wrote:

>> I also expect that they interpret everything after the sha1 as refname, 
>> what with our having become quite liberal with refnames (they can contain 
>> spaces, tabs, and even a small amount of special K). So I don't see a way 
>> to upgrade the file format.
> 
> They can also contain newlines, probably, so escaping is obligatory
> anyway. 

No, refnames can not contain newlines.

And .git/info/refs mimics git-ls-remote / git-peek-remote output,
and is meant for dumb transports.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
