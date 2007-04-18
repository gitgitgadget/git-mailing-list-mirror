From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-format-patch for binary files / merges [Re: Expose subprojects
 as special files to "git diff" machinery]
Date: Wed, 18 Apr 2007 13:52:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704181348410.12094@racer.site>
References: <Pine.LNX.4.64.0704151100550.5473@woody.linux-foundation.org>
 <200704152116.26773.andyparkins@gmail.com> <Pine.LNX.4.64.0704151402130.5473@woody.linux-foundation.org>
 <4625DAEE.3090702@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 13:52:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He8i9-0004OC-EE
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 13:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422894AbXDRLwa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 07:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422900AbXDRLwa
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 07:52:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:33885 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422894AbXDRLw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 07:52:29 -0400
Received: (qmail invoked by alias); 18 Apr 2007 11:52:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 18 Apr 2007 13:52:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181Ty9Bi801VzRLM0h4UNYb8DheDRvpwgX7Z0WiIy
	d9lwqpfxH4gRz4
X-X-Sender: gene099@racer.site
In-Reply-To: <4625DAEE.3090702@vilain.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44891>

Hi,

On Wed, 18 Apr 2007, Sam Vilain wrote:

> Speaking of 'custom' patch file formats, anyone put any thought to a 
> format for the commits which can't be represented with patch, like 
> binary files and merges?

Git has support for binary patches. They are base85 encoded, but you have 
to enable them explicitely (like renames) with --binary.

As for merges, there is the combined diff format. It has more than one 
cell at the beginning to indicate more than one "new" file (we do not use 
this format for merges, but rather for conflicts, but you could easily 
invert that meaning).

Ciao,
Dscho
