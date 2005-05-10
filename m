From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] minor Makefile and local-pull.c edits for Darwin
Date: Tue, 10 May 2005 00:23:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505100019350.30848-100000@iabervon.org>
References: <20050510021105.53984.qmail@web41213.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 06:17:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVMAm-0007qD-L5
	for gcvg-git@gmane.org; Tue, 10 May 2005 06:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVEJEXy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 00:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVEJEXy
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 00:23:54 -0400
Received: from iabervon.org ([66.92.72.58]:56069 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261470AbVEJEXx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 00:23:53 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DVMHO-0007A9-00; Tue, 10 May 2005 00:23:34 -0400
To: Mark Allen <mrallen1@yahoo.com>
In-Reply-To: <20050510021105.53984.qmail@web41213.mail.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 9 May 2005, Mark Allen wrote:

> Darwin puts all of the openssl functionality into libcrypto not
> libssl.

Actually, the relevant openssl functionality is always in libcrypto, not
libssl. It's just that ELF shared libraries include dependancies, and
libssl pulls in libcrypto. If you change it, change it for everyone,
rather than just Darwin.

	-Daniel
*This .sig left intentionally blank*

