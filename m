From: "Andreas Herrmann" <andreas.herrmann3@amd.com>
Subject: Re: basics... when reading docs doesn't help
Date: Fri, 30 Mar 2007 20:02:11 +0200
Message-ID: <20070330180211.GI16087@alberich.amd.com>
References: <Pine.LNX.4.60.0703292225100.10351@poirot.grange>
 <20070329211616.GH6143@fieldses.org>
 <7vabxv3fnx.fsf@assigned-by-dhcp.cox.net>
 <20070329214654.GI6143@fieldses.org>
 <Pine.LNX.4.60.0703292354100.10351@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Guennadi Liakhovetski" <g.liakhovetski@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 30 20:02:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXLQs-0004cp-9d
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 20:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbXC3SCe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 14:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752226AbXC3SCe
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 14:02:34 -0400
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:8528 "EHLO
	outbound1-blu-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752068AbXC3SCd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Mar 2007 14:02:33 -0400
Received: from outbound1-blu.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound1-blu-R.bigfish.com (Postfix) with ESMTP id 8BB2F1288FF3;
	Fri, 30 Mar 2007 18:02:32 +0000 (UTC)
Received: from mail38-blu-R.bigfish.com (unknown [10.1.252.3])
	by outbound1-blu.bigfish.com (Postfix) with ESMTP id 4465412E004F;
	Fri, 30 Mar 2007 18:02:32 +0000 (UTC)
Received: from mail38-blu (localhost.localdomain [127.0.0.1])
	by mail38-blu-R.bigfish.com (Postfix) with ESMTP id 82BB645023F;
	Fri, 30 Mar 2007 18:02:30 +0000 (UTC)
X-BigFish: VP
Received: by mail38-blu (MessageSwitch) id 1175277748803661_4002; Fri, 30 Mar 2007 18:02:28 +0000 (UCT)
Received: from ausb3extmailp01.amd.com (unknown [163.181.251.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail38-blu.bigfish.com (Postfix) with ESMTP id 3BC411130092;
	Fri, 30 Mar 2007 18:02:26 +0000 (UTC)
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by ausb3extmailp01.amd.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l2UI1oLT011291;
	Fri, 30 Mar 2007 13:02:21 -0500
Received: from 163.181.22.102 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 30 Mar 2007 13:02:18 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Received: from SAUSEXMB3.amd.com ([163.181.22.202]) by sausexbh2.amd.com
 with Microsoft SMTPSVC(6.0.3790.2499); Fri, 30 Mar 2007 13:02:18 -0500
Received: from SDRSEXMB1.amd.com ([172.20.3.116]) by SAUSEXMB3.amd.com
 with Microsoft SMTPSVC(6.0.3790.2499); Fri, 30 Mar 2007 13:02:18 -0500
Received: from amd.com ([165.204.85.18]) by SDRSEXMB1.amd.com with
 Microsoft SMTPSVC(6.0.3790.2499); Fri, 30 Mar 2007 20:02:15 +0200
Received: by amd.com (nbSMTP-1.00) for uid 41369 aherrma3@amd.com; Fri,
 30 Mar 2007 20:02:11 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.60.0703292354100.10351@poirot.grange>
User-Agent: mutt-ng/devel-r804 (Linux)
X-OriginalArrivalTime: 30 Mar 2007 18:02:15.0847 (UTC)
 FILETIME=[8CD1EB70:01C772F5]
X-WSS-ID: 6A138F202EW2717782-01-01
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2007 at 12:13:02AM +0200, Guennadi Liakhovetski wrote:
> On Thu, 29 Mar 2007, J. Bruce Fields wrote:
> 
> > On Thu, Mar 29, 2007 at 02:26:10PM -0700, Junio C Hamano wrote:
> > > 
> > > How about suggesting "clone -l -s"?
> 
> Yes, but how do "advanced git users" kernel developers work? Do they just 
> do 1 clone and build / clean every time they want to test another 
> configuration / arch, or do they clone -l or what? Do they create branches 
> for each development thread, then pull / push between trees?...
> 
> > If you really want to share as much as possible, then I guess you want
> > to share the working trees too, since (as evidenced above), they're at
> > least as large as the compressed history.
> 
> But I don't want to re-build. Apart from i386 I build for a couple of ARM 
> and PPC targets too...

Seems to be trivial but:
Why don't you use "make O=/foo/bar/arch<x>-config<y>" to put output
files into separate directories? So you can have one source tree and
put each different kernel config and arch into a separate output
directory.

And if you have different sources for you trees put them into branches.

When switching between branches, atime of files are updated accordingly.
So even make should be happy with that.

Just one drawback:
Switching back and forth between two branches will cause
recompilation of sources that differ between that branches -
although nothing might have changed within a branch in the meantime.

(Not that I have used such an setup, yet.
But I think that should work.)


Regards,

Andreas
