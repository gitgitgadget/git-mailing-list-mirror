From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Mon, 16 Jun 2008 18:52:48 +0200
Organization: At home
Message-ID: <g365ov$u74$2@ger.gmane.org>
References: <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com> <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <7vzlpqza0t.fsf@gitster.siamese.dyndns.org> <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com> <7vlk1az8aa.fsf@gitster.siamese.dyndns.org> <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com> <alpine.DEB.1.00.0806130551200.6439@racer> <0F87000C-B51E-45B8-A21D-1DA184BD603F@wincent.com> <alpine.DEB.1.00.0806132239490.6439@racer> <200806142359.m5
 ENxsBI028758@mi0.bluebottle.com> <7vabhne15k.fsf@gitster.siamese.dyndns.org> <lZpNyxfI-KdPeks7z8vB8LO0LOJTHllWcHbQS34JEY4@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 18:54:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Hxx-0006V5-Kg
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 18:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331AbYFPQxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 12:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbYFPQxG
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 12:53:06 -0400
Received: from main.gmane.org ([80.91.229.2]:40012 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753346AbYFPQxE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 12:53:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K8Hwx-0005qp-AW
	for git@vger.kernel.org; Mon, 16 Jun 2008 16:52:59 +0000
Received: from abwm117.neoplus.adsl.tpnet.pl ([83.8.236.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 16:52:59 +0000
Received: from jnareb by abwm117.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 16:52:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwm117.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85211>

Brandon Casey wrote:

> Your suggestion of per reflog expiration, along with a default
> configuration of never for the stash reflog expiration, _does_ solve
> the problem. Time will tell if this feature is useful outside of
> controlling the stash reflog expiration.

I think that different expiration periods for regular branches (long),
remote-tracking branches (short), stash (never), and HEAD (perhaps
longes) are a very good idea.

For example reflog for "pu" branch might pin quite a large amount
of non-interesting objects, protecting these unnecessarily.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
