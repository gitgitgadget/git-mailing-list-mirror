From: Torgny Nyblom <kde@nyblom.org>
Subject: Re: svn2git question:  Build directory inserted at top level?
Date: Wed, 15 Sep 2010 20:09:50 +0200
Message-ID: <20100915200950.50a22b36@explosive.nyblom.org>
References: <DDB24DEE-934B-4C8D-8DAA-595905035AC4@jetbrains.com>
	<4E10ACF241081344B9702AA8C6440440C5B13F2162@MX01A.corp.emc.com>
	<201009151344.17066.ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 15 20:10:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvwRd-00083Y-11
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 20:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937Ab0IOSKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 14:10:52 -0400
Received: from mailrelay.veberod.com ([193.12.238.77]:37889 "EHLO
	mailrelay.veberod.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113Ab0IOSKv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 14:10:51 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Sep 2010 14:10:51 EDT
Received: from dx.nyblom.org ([212.247.117.70])
	by mailrelay.veberod.com (8.13.8/8.13.8) with ESMTP id o8FFZ01W004835
	for <git@vger.kernel.org>; Wed, 15 Sep 2010 17:35:01 +0200
Received: from localhost (localhost [127.0.0.1])
	by dx.nyblom.org (Postfix) with ESMTP id DC5F06168FA
	for <git@vger.kernel.org>; Wed, 15 Sep 2010 20:10:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dx.nyblom.org
Received: from dx.nyblom.org ([127.0.0.1])
	by localhost (dx.nyblom.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zS5g2ma5bh2J for <git@vger.kernel.org>;
	Wed, 15 Sep 2010 20:10:48 +0200 (CEST)
Received: from explosive.nyblom.org (explosive.nyblom.org [192.168.0.201])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dx.nyblom.org (Postfix) with ESMTPS id D8FD814B2A6
	for <git@vger.kernel.org>; Wed, 15 Sep 2010 20:10:48 +0200 (CEST)
In-Reply-To: <201009151344.17066.ComputerDruid@gmail.com>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156242>

I'm replying here as I just joined the list and missed the original
message.

> On Wednesday 15 September 2010 09:47:42 nolan.ring@emc.com wrote:
> > When I include the branches in the conversion I get a Build
> > directory at the top level and then the usual directory structure
> > of the repo.  Where is the Build dir coming from?  Is svn2git doing
> > that?  Or is it finding that somewhere somehow in the repo?
> > 
> > buildadm@suse-s11:/work/POCcs> ls
> > Build
> > buildadm@suse-s11:/work/POCcs/Build> ls
> > Automation  build_cs_rpm.pl  ControlStation  depends.properties

This is an error in your rule files.

/Regards
Torgny
