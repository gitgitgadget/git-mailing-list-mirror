From: Neil Schemenauer <nas@arctrix.com>
Subject: Re: git push to a non-bare repository
Date: Wed, 21 Mar 2007 17:20:38 +0000 (UTC)
Message-ID: <etrph6$dt3$1@sea.gmane.org>
References: <vpq648ye9w6.fsf@olympe.imag.fr> <20070319020053.GA11371@thunk.org> <vpq8xdtpp3g.fsf@olympe.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 18:40:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU4nC-00009c-UG
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 18:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933226AbXCURkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 13:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933224AbXCURkG
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 13:40:06 -0400
Received: from main.gmane.org ([80.91.229.2]:52005 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933196AbXCURkE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 13:40:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HU4n4-0000iS-SM
	for git@vger.kernel.org; Wed, 21 Mar 2007 18:40:03 +0100
Received: from s0106000625c557dc.ss.shawcable.net ([70.64.11.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 18:40:02 +0100
Received: from nas by s0106000625c557dc.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 18:40:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s0106000625c557dc.ss.shawcable.net
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42809>

Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> It's not really an option in my case. A is a fixe-IP/fixe-DNS machine,
> while B is my home machine, behind a NAT modem-router. So, I'd have to
> figure out my home IP, port-forward the ssh port from the modem to my
> machine, ...

I think this is a pretty common scenario.  I have a central server
that I would like to push to and a bunch of other machines behind
firewalls.  Pulling from the central machine is not practical.

  Neil
