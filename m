From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 01:21:18 -0700
Message-ID: <7vfxdyymtd.fsf@alter.siamese.dyndns.org>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	<43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	<7vvdmurfao.fsf@alter.siamese.dyndns.org>
	<20090618063348.6117@nanako3.lavabit.com>
	<alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
	<20090618001111.GB12954@vidovic>
	<7v8wjq2kqc.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302>
	<m3r5xigdvn.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 10:22:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHCsf-0002b7-1T
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 10:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755816AbZFRIVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 04:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbZFRIVS
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 04:21:18 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:58934 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbZFRIVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 04:21:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090618082118.JTSR17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 18 Jun 2009 04:21:18 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 5LMJ1c0044aMwMQ04LMJeN; Thu, 18 Jun 2009 04:21:18 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=BJRVbhqwWo4A:10 a=pGLkceISAAAA:8
 a=oUTJ7AQxngxkY2S8z70A:9 a=4Qy_WFHmYGj6GNe5yAa7WftiUwEA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <m3r5xigdvn.fsf@localhost.localdomain> (Jakub Narebski's message of "Thu\, 18 Jun 2009 01\:11\:53 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121811>

Jakub Narebski <jnareb@gmail.com> writes:

> A bit off-topic: I wonder if there is an easy way to make rebase run
> testsuite for the each commit it rebases, or even simple compile test,
> to not introduce untestable commits when rebasing by mistake...

I used to do that manually, i.e. s/^pick /edit /;
