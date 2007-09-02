From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and make stat use that implementation too.
Date: Sun, 2 Sep 2007 23:41:28 +0200
Message-ID: <20070902214128.GC2756@steel.home>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <200709022016.54262.johannes.sixt@telecom.at> <46DB0478.8050402@trolltech.com> <46DB0F9C.2090306@trolltech.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 23:41:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRxCK-0004EQ-3B
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 23:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbXIBVlc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 17:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbXIBVlc
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 17:41:32 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:52912 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbXIBVlb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 17:41:31 -0400
Received: from tigra.home (Fc92a.f.strato-dslnet.de [195.4.201.42])
	by post.webmailer.de (mrclete mo39) (RZmta 12.3)
	with ESMTP id q01f95j82JeU3Z ; Sun, 2 Sep 2007 23:41:29 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0503C277BD;
	Sun,  2 Sep 2007 23:41:28 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id D6B75BEAC; Sun,  2 Sep 2007 23:41:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46DB0F9C.2090306@trolltech.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAFvMw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57392>

Marius Storm-Olsen, Sun, Sep 02, 2007 21:31:40 +0200:
> +		buf->st_ino = 0;

You sure about that? Ever wondered why it is not so on everywhere else?
