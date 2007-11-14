From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Wed, 14 Nov 2007 14:41:13 +0100
Organization: At home
Message-ID: <fhettp$rtk$1@ger.gmane.org>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <20071112131927.GA1701@c3sl.ufpr.br> <Pine.LNX.4.64.0711121355380.4362@racer.site> <200711121719.54146.wielemak@science.uva.nl> <Pine.LNX.4.64.0711121624330.4362@racer.site> <vpq3avbv2ju.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121715090.4362@racer.site> <18232.35893.243300.179076@lisa.zopyra.com> <Pine.LNX.4.64.0711121727130.4362@racer.site> <vpq7iknqrtp.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121755460.4362@racer.site> <vpqy7d3pck0.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121804400.4362@racer.site> <vpqoddzpc88.fsf@bauges.imag.fr> <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org> <87myth58r5.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 14 14:42:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsIVh-0005EA-U0
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 14:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446AbXKNNlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 08:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752839AbXKNNlq
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 08:41:46 -0500
Received: from main.gmane.org ([80.91.229.2]:42208 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753889AbXKNNlp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 08:41:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IsIUn-0005qY-N9
	for git@vger.kernel.org; Wed, 14 Nov 2007 13:41:33 +0000
Received: from abwy6.neoplus.adsl.tpnet.pl ([83.8.248.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Nov 2007 13:41:33 +0000
Received: from jnareb by abwy6.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Nov 2007 13:41:33 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwy6.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64984>

Sergei Organov wrote:

> Just a wild idea. Doesn't it make sense to introduce perfect ultimate
> common ancestor of the universe, probably calling it "the NULL commit"?
> At first glance it seems that it can help to avoid corner cases
> automagically.

No. Sometimes you want unrelated branches in repository ('html', 'man',
'todo' branches in git.git), sometimes multiple roots are natural (merging
in a project, like git-mailtools, gitweb, gitk, git-gui in git.git).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
