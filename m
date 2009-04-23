From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: Git-SVN on Cygwin: svn+ssh good, https awkward
Date: Thu, 23 Apr 2009 20:32:47 +0200
Message-ID: <op.usuq4xw71e62zd@balu.cs.uni-paderborn.de>
References: <op.usulh7a71e62zd@balu.cs.uni-paderborn.de>
 <loom.20090423T175124-165@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: "Eric Blake" <ebb9@byu.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 20:34:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx3kp-0001CY-5e
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 20:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869AbZDWScw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 14:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754856AbZDWScw
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 14:32:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:53366 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753702AbZDWScv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 14:32:51 -0400
Received: (qmail invoked by alias); 23 Apr 2009 18:32:48 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp062) with SMTP; 23 Apr 2009 20:32:48 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1+uudoEb2Suvfq8eVN2f4r/2kIMOSlMoGdcwhYoOh
	dJoix30/8oqupS
In-Reply-To: <loom.20090423T175124-165@post.gmane.org>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117358>

Am 23.04.2009, 19:58 Uhr, schrieb Eric Blake <ebb9@byu.net>:

> These last two points are old information.  I would first recommend that  
> you try running the new cygwin 1.7 (still in beta), where unlink()  
> semantics have been greatly improved (you can actually unlink() an  
> in-use file and recreate a new file by the same name while the old  
> handle is still open).
>
> http://cygwin.com/#beta-test

Indeed, with a fresh Cygwin 1.7 install, all this seems to work smoothly.  
I'd rather not bet on Cygwin release dates though, and can't judge on  
short notice what else will break with Cygwin 1.7... so I'd still  
appreciate help with fixing git-svn on Cygwin 1.5.

-- 
Matthias Andree
