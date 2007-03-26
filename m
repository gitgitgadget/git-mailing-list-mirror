From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Understanding version 4 packs
Date: Mon, 26 Mar 2007 10:49:07 +0200
Organization: At home
Message-ID: <eu818b$im6$2@sea.gmane.org>
References: <20070324202356.GA20734@bohr.gbar.dtu.dk> <alpine.LFD.0.83.0703241913110.18328@xanadu.home> <20070325083530.GA25523@bohr.gbar.dtu.dk> <20070325091806.GH25863@spearce.org> <Pine.LNX.4.64.0703251004580.6730@woody.linux-foundation.org> <20070325203141.GA12376@spearce.org> <alpine.LFD.0.83.0703252102520.3041@xanadu.home> <20070326020257.GB13247@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 11:13:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVlGJ-0002W8-Vm
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 11:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbXCZJNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 05:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbXCZJNI
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 05:13:08 -0400
Received: from main.gmane.org ([80.91.229.2]:55611 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753545AbXCZJNG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 05:13:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HVl98-0004ea-MA
	for git@vger.kernel.org; Mon, 26 Mar 2007 11:05:46 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 11:05:46 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 11:05:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43136>

Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:

>> BTW Shawn there is no need to store the number of tree records at the 
>> beginning of the tree object since that can be deduced directly from the 
>> object size stored in the object header.
> 
> Doh.  Yes, of course.

But if it makes for easier _implementation_, perhaps it should stay...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
