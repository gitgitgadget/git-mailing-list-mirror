From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: warning: no common commits - slow pull
Date: Mon, 25 Feb 2008 22:59:38 +0100
Message-ID: <87ablod7ed.fsf@mid.deneb.enyo.de>
References: <200802102007.38838.lenb@kernel.org>
	<7v4pcgcimw.fsf@gitster.siamese.dyndns.org>
	<20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 23:00:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTlMw-0007th-94
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 23:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbYBYV7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 16:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753101AbYBYV7l
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 16:59:41 -0500
Received: from mail.enyo.de ([212.9.189.167]:55656 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbYBYV7k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 16:59:40 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1JTlMJ-0005eR-2a
	for git@vger.kernel.org; Mon, 25 Feb 2008 22:59:39 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1JTlMI-0001Iv-KK
	for git@vger.kernel.org; Mon, 25 Feb 2008 22:59:38 +0100
In-Reply-To: <200802151643.30232.lenb@kernel.org> (Len Brown's message of
	"Fri, 15 Feb 2008 16:43:30 -0500")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75082>

* Len Brown:

> [lenb@d975xbx2 linus (master)]$ git pull
> remote: Counting objects: 649, done.
> remote: Compressing objects: 100% (106/106), done.
> remote: Total 513 (delta 417), reused 503 (delta 407)
> Receiving objects: 100% (513/513), 116.67 KiB, done.
> Resolving deltas: 100% (417/417), completed with 103 local objects.
> warning: no common commits
> remote: Counting objects: 710725, done.
> remote: Compressing objects: 100% (125738/125738), done.
> remote: Total 710725 (delta 589584), reused 704450 (delta 584029)
> Receiving objects: 100% (710725/710725), 172.71 MiB | 1073 KiB/s, done.
> Resolving deltas: 100% (589584/589584), done.
>>From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6

Same here, but on a slow DSL line, so I had to hit ^C:

fw@deneb:~/src/linux/linux-2.6$ git pull
remote: Counting objects: 94176, done.
remote: Compressing objects: 100% (17486/17486), done.
remote: Total 83287 (delta 70429), reused 78218 (delta 65712)
Receiving objects: 100% (83287/83287), 18.66 MiB | 478 KiB/s, done.
Resolving deltas: 100% (70429/70429), completed with 7457 local objects.
warning: no common commits
remote: Counting objects: 53267
^C

This is Debian's 1:1.5.4.2-2 GIT version.
