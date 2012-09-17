From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH v7 0/4] Support non-WIN32 systems lacking poll()
Date: Mon, 17 Sep 2012 23:34:41 +0200
Message-ID: <k3851v$3po$1@ger.gmane.org>
References: <k36h3i$ihb$1@ger.gmane.org> <7v392gtl8g.fsf@alter.siamese.dyndns.org> <k383ka$nme$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 23:35:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDiyp-00044y-Uq
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 23:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882Ab2IQVfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 17:35:16 -0400
Received: from plane.gmane.org ([80.91.229.3]:34512 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754175Ab2IQVfP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 17:35:15 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TDiyJ-0003iZ-Aj
	for git@vger.kernel.org; Mon, 17 Sep 2012 23:35:15 +0200
Received: from dsdf-4db53772.pool.mediaways.net ([77.181.55.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 23:35:15 +0200
Received: from jojo by dsdf-4db53772.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 23:35:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db53772.pool.mediaways.net
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205756>

Joachim Schmitz wrote:
> Here's now my updated series of patches to make the win32 implementation
> of poll() available to other platforms:
> 
> 1 - make poll available for other platforms lacking it by moving it into
> a separate directory and adjusting Makefile
> 2 - fix some win32 specific dependencies in poll.c by #ifdef the
> inclusion of two header files
> 3 - poll() exits too early with EFAULT if 1st arg is NULL, as fixed in
> gnulib recently
> 4 - make poll() work on platforms that can't recv() on a non-socket,
> namely HP NonStop, as fixed in gnulib recently
> 
> Hopefully without whitespace issues...
> 
> Bye, Jojo

Posted but not properly chained... hope that doesn't matter?
