From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] MinGW readdir reimplementation to support d_type
Date: Thu, 7 May 2009 23:26:29 +0200
Message-ID: <20090507212629.GC6751@macbook.lan>
References: <1239224507-5372-1-git-send-email-marius@trolltech.com> <49DE5BDE.9050709@kdbg.org> <49DEFA30.1000101@gmail.com> <49E10F5A.9010400@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <marius@storm-olsen.com>, marius@trolltech.com,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu May 07 23:26:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2B70-0000B4-Bk
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 23:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634AbZEGV0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 17:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753046AbZEGV0c
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 17:26:32 -0400
Received: from darksea.de ([83.133.111.250]:47323 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751731AbZEGV0b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 17:26:31 -0400
Received: (qmail 3252 invoked from network); 7 May 2009 23:26:16 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 May 2009 23:26:16 +0200
Content-Disposition: inline
In-Reply-To: <49E10F5A.9010400@kdbg.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118523>

On Sat, Apr 11, 2009 at 11:44:58PM +0200, Johannes Sixt wrote:
> With a comment in the commit message, it would have been clear, perhaps.
>
> I'll carry this in my (private) tree for a while with the below squashed  
> in to avoid a lot of warnings.

What happened to this patch? Is there any reason it can not be included?
I can confirm the factor 2 speedup which is very noticeable. Especially
when working with "git gui" which does git status very often.

cheers Heiko
