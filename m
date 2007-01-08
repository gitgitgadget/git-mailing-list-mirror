From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How git affects kernel.org performance
Date: Mon, 08 Jan 2007 02:51:42 +0100
Organization: At home
Message-ID: <ens836$jr2$1@sea.gmane.org>
References: <20061214223718.GA3816@elf.ucw.cz> <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <20070107145730.GB24706@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 02:52:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3jgE-0008L2-0B
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 02:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbXAHBwB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 20:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbXAHBwB
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 20:52:01 -0500
Received: from main.gmane.org ([80.91.229.2]:60402 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030436AbXAHBwA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 20:52:00 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H3jg2-0002iT-HX
	for git@vger.kernel.org; Mon, 08 Jan 2007 02:51:54 +0100
Received: from host-81-190-18-145.torun.mm.pl ([81.190.18.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Jan 2007 02:51:54 +0100
Received: from jnareb by host-81-190-18-145.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Jan 2007 02:51:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-145.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36219>

Robert Fitzsimons wrote:

>> Some more data on how git affects kernel.org...
> 
> I have a quick question about the gitweb configuration, does the
> $projects_list config entry point to a directory or a file?

It can point to both. Usually it is either unset, and then we
do find over $projectroot, or it is a file (URI escaped path
relative to $projectroot, SPACE, and URI escaped owner of a project;
you can get the file clicking on TXT on projects_list page).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
