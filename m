From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fread does not return negative on error
Date: Thu, 25 Jun 2009 11:31:09 -0700
Message-ID: <7vtz24cgia.fsf@alter.siamese.dyndns.org>
References: <4A3FB09D.9050903@gmail.com> <20090622153431.GA18466@elte.hu>
	<25e057c00906220847t15425f38maf486c291d1d2468@mail.gmail.com>
	<4A3FB479.2090902@lsrfire.ath.cx>
	<7vhby64i8f.fsf@alter.siamese.dyndns.org>
	<20090624081819.GA10436@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	roel kluin <roel.kluin@gmail.com>, git@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Jun 25 20:31:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJtjE-0004rf-G0
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 20:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbZFYSbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 14:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbZFYSbJ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 14:31:09 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:43093 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbZFYSbI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 14:31:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090625183110.VJPJ20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 25 Jun 2009 14:31:10 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8JXA1c0024aMwMQ03JXAfE; Thu, 25 Jun 2009 14:31:10 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=F_o4wktclTQA:10 a=8zWp4CDmNhVN3as29EUA:9
 a=MVTGGcZhlGhNtarNthw4e9ThxssA:4
X-CM-Score: 0.00
In-Reply-To: <20090624081819.GA10436@elte.hu> (Ingo Molnar's message of "Wed\, 24 Jun 2009 10\:18\:19 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122228>

Ingo Molnar <mingo@elte.hu> writes:

> And our general experience with the Git libraries in 
> tools/perf/util/* is: we love them!

> For example parse-options.c is a striking improvement compared to 
> getopt.h we used before, and all the other facilities are sane and 
> straight to the point as well. So in this sense 'perf' is an ... 
> interesting cross-discipline 'fork' of Git's generic libraries.

Kudos to Pierre, then.
