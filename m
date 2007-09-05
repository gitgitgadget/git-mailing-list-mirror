From: Nix <nix@esperi.org.uk>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 18:51:09 +0100
Message-ID: <87odgh0zn6.fsf@hades.wkstn.nix>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 19:51:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISz2D-0004IK-Pu
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 19:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837AbXIERvU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 13:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756807AbXIERvU
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 13:51:20 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:48730 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756710AbXIERvS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 13:51:18 -0400
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id l85Hp9aY008879;
	Wed, 5 Sep 2007 18:51:10 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id l85Hp9n0018563;
	Wed, 5 Sep 2007 18:51:09 +0100
Emacs: Lovecraft was an optimist.
In-Reply-To: <20070905074206.GA31750@artemis.corp> (Pierre Habouzit's message of "Wed, 05 Sep 2007 09:42:06 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.5-b28 (linux)
X-DCC-INFN-TO-Metrics: hades 1233; Body=2 Fuz1=2 Fuz2=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57729>

On 5 Sep 2007, Pierre Habouzit said:
>   I know I don't really answer the question, but the point I try to make
> is that yeah, some kind of automated way to run the gc is great, but I'm
> not sure that _git_ is the tool to automate that, because when *I* use
> git, I expect it to be just plain fast, and I don't want it to
> occasionally hang.

Indeed. I repack all our git trees in the middle of the night, and our
incremental backup script drops .keep files corresponding to every
existing pack before running the backup.

This is probably a good job for cron :)
