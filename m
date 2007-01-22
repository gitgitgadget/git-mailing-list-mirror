From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-push through git protocol
Date: Mon, 22 Jan 2007 01:48:43 +0100
Organization: At home
Message-ID: <ep11jt$uap$1@sea.gmane.org>
References: <17843.29798.866272.414435@lisa.zopyra.com> <46a038f90701211549v1e3dbb9dgf4eb810c8756b5d7@mail.gmail.com> <17843.65339.528621.549961@lisa.zopyra.com> <46a038f90701211624y19e83999k291408764bccc645@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jan 22 01:48:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8nMC-0000Ja-Q8
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 01:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbXAVAsO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 19:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbXAVAsO
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 19:48:14 -0500
Received: from main.gmane.org ([80.91.229.2]:53563 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbXAVAsN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 19:48:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H8nLx-0004NR-Un
	for git@vger.kernel.org; Mon, 22 Jan 2007 01:48:05 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 01:48:05 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 01:48:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37370>

Martin Langhoff wrote:

> WRT denyNonFastforwards -- even without that, git refuses to push if
> it's not a fast-forward. Maybe if I had the branch set to +headname.
> In any case, you have to try real hard to muck that up.

With denyNonFastforwards even push --force, or push +head wouldn't work.
Without you need the above to push not fast-forward changes (rewind
history).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
