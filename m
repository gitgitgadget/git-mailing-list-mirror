From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Wed, 11 Jul 2007 14:20:24 +0200
Organization: At home
Message-ID: <f72hu8$65g$1@sea.gmane.org>
References: <46893F61.5060401@jaeger.mine.nu> <20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net> <46895EA4.5040803@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 14:20:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8bBc-0007QN-VU
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 14:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760739AbXGKMUt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 08:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760764AbXGKMUt
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 08:20:49 -0400
Received: from main.gmane.org ([80.91.229.2]:56571 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759729AbXGKMUs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 08:20:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I8bBP-000301-Vt
	for git@vger.kernel.org; Wed, 11 Jul 2007 14:20:39 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 14:20:39 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 14:20:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52155>

Christian Jaeger wrote:

> I don't per se require undo actions. I just don't understand why git-rm
> refuses to remove the file from the index, even if I didn't commit it.
> The index is just an intermediate record of the changes in my
> understandings, and the rm action would also be intermediate until it's
> being committed. And a non-committed action being deleted shouldn't need
> a special confirmation from me, especially not one which is consisting
> of a combination of two flags (of which one is a destructive one).

Should git-rm refuse to remove index entry if it is different from working
directory version or not?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
