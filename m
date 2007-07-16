From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 21:56:00 +0200
Message-ID: <20070716195600.GC16878@cip.informatik.uni-erlangen.de>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de> <vpqd4yss1vo.fsf@bauges.imag.fr> <469BC17D.60806@slamb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Scott Lamb <slamb@slamb.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 21:56:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAWg7-00082m-Qi
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 21:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757433AbXGPT4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 15:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757869AbXGPT4E
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 15:56:04 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:55834 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756938AbXGPT4B (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 15:56:01 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 46D193F435; Mon, 16 Jul 2007 21:56:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <469BC17D.60806@slamb.org>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52709>

Hello,

> If arbitrary other tasks are running, the only way to be absolutely
> certain you're not calling unlink() in a directory is to never call
> unlink().

there is one way to do it safe but it is so ugly that it is
unacceptable: don't call unlink as a privileged user (eg. root). So I
hope that one of the patches make it into git soon. I like the second
patch better because it does less system calls. Not that it matters.
For my co-workers I already build a git version with the patch in so
that they can continue to work as root. Don't even think about asking.

        Thomas
