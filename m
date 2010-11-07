From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/4] make open/unlink failures user friendly on windows using retry/abort
Date: Sun, 7 Nov 2010 20:11:04 +0100
Message-ID: <201011072011.05473.j6t@kdbg.org>
References: <87ocbitd33.fsf@fox.patthoyts.tk> <201011071649.20617.j6t@kdbg.org> <20101107170637.GA15123@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Nov 07 20:11:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFAe6-0004lA-Ox
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 20:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964Ab0KGTLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 14:11:10 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:53348 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609Ab0KGTLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 14:11:09 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 68CEA10018;
	Sun,  7 Nov 2010 20:11:05 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8E19F19F5C0;
	Sun,  7 Nov 2010 20:11:05 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <20101107170637.GA15123@book.hvoigt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160896>

On Sonntag, 7. November 2010, Heiko Voigt wrote:
> I tested this for my use case which is described by the manual testing
> script[1]. I ran it once to create the test structure and then from
> inside the test repository
>
> 	./../block_read 5000 file
>
> and manually checked out the other branch in parallel. In this situation
> git will stop with the retry question. But I am not sure which use case you
> where addressing. Do you have a script or some information to reproduce?

Sorry, I don't have a reliable test case. I usually encountered this problem 
in the test suite at random places when it was run with 'make -j2' and in a 
production repository sometimes during rebase --interactive.

-- Hannes
