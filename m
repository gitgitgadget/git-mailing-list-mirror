From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: [PATCH] Keep committer and committer dates
Date: Thu, 05 Jun 2008 19:34:25 +0300
Message-ID: <48481591.8090703@panasas.com>
References: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz> <alpine.DEB.1.00.0806032115340.13507@racer.site.net> <Pine.LNX.4.61.0806041113520.1798@tm8103-a.perex-int.cz> <20080604102906.GA2126@diana.vm.bytemark.co.uk> <m3ej7dzc7y.fsf@localhost.localdomain> <Pine.LNX.4.61.0806041424140.1798@tm8103-a.perex-int.cz> <alpine.DEB.1.00.0806041641150.13507@racer.site.net> <20080605010330.GB24466@leksak.fem-net> <alpine.DEB.1.00.0806050523120.21190@racer> <4847917A.2050700@viscovery.net> <Pine.LNX.4.61.0806051428390.1798@tm8103-a.perex-int.cz> <alpine.DEB.1.00.0806051408520.21190@racer> <Pine.LNX.4.61.0806051528220.1798@tm8103-a.perex-int.cz> <alpine.DEB.1.00.0806051452380.21190@racer> <Pine.LNX.4.61.0806051600310.1798@tm8103-a.perex-int.cz> <alpine.DEB.1.00.0806051545470.21190@racer> <Pin
 e.LNX.4.61.0806051704311.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
X-From: git-owner@vger.kernel.org Thu Jun 05 18:36:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4IRJ-0001cJ-E0
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 18:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761AbYFEQe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 12:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbYFEQe4
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 12:34:56 -0400
Received: from gw-colo-pa.panasas.com ([66.238.117.130]:31475 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752558AbYFEQez (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 12:34:55 -0400
Received: from daytona.int.panasas.com (localhost.localdomain [127.0.0.1])
	by cassoulet.panasas.com (8.13.1/8.13.1) with ESMTP id m55GYnwf002507;
	Thu, 5 Jun 2008 12:34:49 -0400
Received: from 172.17.28.41 ([172.17.28.41] helo=daytona.int.panasas.com)
	by ASSP-nospam; 5 Jun 2008 12:34:49 -0400
Received: from bh-buildlin2.bhalevy.com ([172.17.28.139]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Jun 2008 12:34:33 -0400
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <Pine.LNX.4.61.0806051704311.1798@tm8103-a.perex-int.cz>
X-OriginalArrivalTime: 05 Jun 2008 16:34:34.0132 (UTC) FILETIME=[0975AD40:01C8C72A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83944>

Jaroslav Kysela wrote:
> On Thu, 5 Jun 2008, Johannes Schindelin wrote:
> 
>> Clearly, you do not want to be convinced, no matter what arguments are 
>> thrown your way.
> 
> No, I just do not want to be restricted with one way to do things. All 
> what I read is about fear to misuse the proposed feature. It stops 
> evolution, especially in open source - propose to remove 'rm -rf /' from 
> all linux distros.  Anyway, GIT maintainer has a right to not accept my 
> change, altough I think that it's a drawback for other users - not for me. 
> Bye for now.
> 
> 					Jaroslav
> 
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
> 

Please consider looking at this in another way.

You know how in git the crypto signature of the patch, which is it's
"object name" (OID) that you see in git log, also contains it's parent, though 
recursively proving that same OID is exactly, universe wide, the same tree.
and all this stuff about git...

Well consider the "committer" field to be the person how created and signed
that OID. That is, the person that first defined that universe unique tree.
An OID of a patch is not about the patch it's about the tree. And so is the
"committer" field. It's not who wrote the patch, it's about who signed the
tree up to this point.

If you absolutely need to emulate someone else name just do 
$ su that_other_one
But don't ask git to record an information that was not true at that
point in time.

My $0.017
Boaz
