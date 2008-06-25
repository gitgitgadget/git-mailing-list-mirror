From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Wed, 25 Jun 2008 08:09:15 +0200
Message-ID: <4861E10B.5080103@viscovery.net>
References: <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <7vzlpbeksn.fsf@gitster.siamese.dyndns.org> <20080624082447.GB24357@artemis.madism.org> <alpine.LFD.1.10.0806241001140.2926@woody.linux-foundation.org> <20080624193028.GC9189@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 08:10:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBOCu-0004qn-IS
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 08:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbYFYGJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 02:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbYFYGJU
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 02:09:20 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:28007 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbYFYGJU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 02:09:20 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KBOBv-0000C1-Og; Wed, 25 Jun 2008 08:09:15 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 510FFAFCC; Wed, 25 Jun 2008 08:09:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080624193028.GC9189@artemis.madism.org>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86240>

Pierre Habouzit schrieb:
>   Though for the win32 port where fork is replaced with threads, well,
> it may cause some issues, so I was reluctant wrt them. Of course it's
> unlikely that it will cause problems, but one never knows ;)

We use threads only for those fork()s that are not followed by an exec().
So this is not a reason to worry about memory leaks in the option parser.

-- Hannes
