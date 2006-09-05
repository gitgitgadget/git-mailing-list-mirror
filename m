From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/5] autoconf: Preliminary check for working mmap
Date: Mon, 04 Sep 2006 22:10:45 -0700
Message-ID: <7vu03mkiei.fsf@assigned-by-dhcp.cox.net>
References: <200609050054.24279.jnareb@gmail.com>
	<200609050056.52590.jnareb@gmail.com>
	<7vy7szjjal.fsf@assigned-by-dhcp.cox.net> <edidlp$d3d$1@sea.gmane.org>
	<20060905030929.GA29865@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 07:10:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKTCq-0004WW-Lt
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 07:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbWIEFKV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 01:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbWIEFKV
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 01:10:21 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:31110 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965158AbWIEFKT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 01:10:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060905051019.MVMR21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Sep 2006 01:10:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JVAK1V00U1kojtg0000000
	Tue, 05 Sep 2006 01:10:20 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060905030929.GA29865@spearce.org> (Shawn Pearce's message of
	"Mon, 4 Sep 2006 23:09:29 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26459>

Shawn Pearce <spearce@spearce.org> writes:

> I'm maybe only 1/3 of the way through the sliding window mmap
> implementation.  I've got a good chunk of sha1_file.c converted but I
> still have to deal with the copying in pack-objects.c and the verify
> code in verify-pack.c.  I'm hoping I can send a preliminary patch
> series tomorrow as I'm going to work on it more tonight and tomorrow.

Thanks -- I was tempted to do this myself after finishing the
index_64 change in "pu" branch, but have resisted the temptation
myself so far.  Being lazy, the less I have to code the better,
naturally ;-).
 
