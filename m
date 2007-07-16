From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 22:39:50 +0200
Message-ID: <20070716203950.GI16878@cip.informatik.uni-erlangen.de>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de> <vpqd4yss1vo.fsf@bauges.imag.fr> <469BC17D.60806@slamb.org> <20070716200024.GD16878@cip.informatik.uni-erlangen.de> <alpine.LFD.0.999.0707161315120.20061@woody.linux-foundation.org> <20070716202550.GH16878@cip.informatik.uni-erlangen.de> <alpine.LFD.0.999.0707161332280.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 22:40:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAXMO-0005CO-Tr
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 22:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760817AbXGPUjz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 16:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758817AbXGPUjw
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 16:39:52 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:59151 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756683AbXGPUjv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 16:39:51 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id AE5603F442; Mon, 16 Jul 2007 22:39:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707161332280.20061@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52719>

Hello,

> No, but we don't *want* the "rmdir for directories" part! 

that is what I meant. We call unlink because we want unlink to _fail_ on
directories while it deletes file. I forgot about the original
discussion but Johannes refreshed my memory.  If a file in our history
becomes a directory we want to get it out of our way. And we want to do
that by call unlink.

	Thomas
