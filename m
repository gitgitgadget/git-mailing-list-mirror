From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: [announce] text-based tree visualizer
Date: Thu, 6 Mar 2008 19:49:13 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803061938550.7660@fbirervta.pbzchgretzou.qr>
References: <Pine.LNX.4.64.0803061557320.7660@fbirervta.pbzchgretzou.qr>
 <alpine.LSU.1.00.0803061924350.3941@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 19:49:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXLAD-0004AO-6E
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 19:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452AbYCFStP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 13:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754481AbYCFStO
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 13:49:14 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:38707 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbYCFStO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 13:49:14 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 258EA180311ED; Thu,  6 Mar 2008 19:49:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 1D18D1C00FE77;
	Thu,  6 Mar 2008 19:49:13 +0100 (CET)
In-Reply-To: <alpine.LSU.1.00.0803061924350.3941@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76409>


On Mar 6 2008 19:24, Johannes Schindelin wrote:
>On Thu, 6 Mar 2008, Jan Engelhardt wrote:
>
>> I spent the last two days writing a text-based tree visualizer; gitk is 
>> really convenient, but unfortunately it needs an X display, tigs tree 
>> view left me unimpressed, and I actually wanted a tool that does not 
>> read all commits in like gitk/tig do, but just gives me the treeview.
>> 
>> Screenshot:
>> http://jengelh.hopto.org/other/git-forest.png
>> Program (perl):
>> http://dev.computergmbh.de/gitweb.cgi?p=hxtools;a=blob_plain;f=bin/git-forest
>> Top of file contains option overview.
>
>Nice.  Have you tested how it compares against tig (hit 'g'...)?

Yes, see above? :-) "tig's treeview" - that meant the 'g' key.

It just uses boring ascii, fails to display octopus merges and
'octoups branching', is limited to 'one branch' (e.g. no apparent way
to pass --all to git-log/git-rev-list).
