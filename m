From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Smart fetch via HTTP?
Date: Wed, 16 May 2007 23:54:42 +0200
Organization: At home
Message-ID: <f2fua2$e2s$1@sea.gmane.org>
References: <20070515201006.GD3653@efreet.light.src> <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com> <Pine.LNX.4.64.0705161232120.6410@racer.site> <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 23:50:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoROM-0003KH-Fg
	for gcvg-git@gmane.org; Wed, 16 May 2007 23:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbXEPVuP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 17:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755121AbXEPVuP
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 17:50:15 -0400
Received: from main.gmane.org ([80.91.229.2]:35751 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754561AbXEPVuN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 17:50:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HoRNm-0005h8-8E
	for git@vger.kernel.org; Wed, 16 May 2007 23:50:06 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 May 2007 23:50:06 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 May 2007 23:50:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47460>

Martin Langhoff wrote:

> On 5/16/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Wed, 16 May 2007, Martin Langhoff wrote:
>> > Do the indexes have enough info to use them with http ranges? It'd be
>> > chunkier than a smart protocol, but it'd still work with dumb servers.
>> It would not be really performant, would it? Besides, not all Web servers
>> speak HTTP/1.1...
> 
> Performant compared to downloading a huge packfile to get 10% of it?
> Sure! It'd probably take a few trips, and you'd end up fetching 20% of
> the file, still better than 100%.

That's why you should have something akin to backup policy for pack files,
like daily packs, weekly packs, ..., and the rest, just for the dumb
protocols.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
