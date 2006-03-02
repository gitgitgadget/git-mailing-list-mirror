From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git-annotate dies when a patch is missing trailing newline
Date: Wed, 1 Mar 2006 20:53:04 -0500
Message-ID: <20060302015303.GA27871@mythryan2.michonline.com>
References: <46a038f90603011653l7956d5dat99d88a7da98d21b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 02 02:54:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEd16-0001AU-HR
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 02:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWCBByF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 20:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWCBByF
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 20:54:05 -0500
Received: from mail.autoweb.net ([198.172.237.26]:33199 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751369AbWCBByD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 20:54:03 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FEd0y-0000cC-PX; Wed, 01 Mar 2006 20:54:02 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FEd0u-0007d8-GB; Wed, 01 Mar 2006 20:53:56 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1FEd0S-0000Ud-KC; Wed, 01 Mar 2006 20:53:28 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90603011653l7956d5dat99d88a7da98d21b6@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17039>

On Thu, Mar 02, 2006 at 01:53:21PM +1300, Martin Langhoff wrote:
> Ryan, (& list)
> 
> git-annotate is dying when a patch is missing trailing newline. There
> _are_ valid situations where code files are not expected to have
> trailing newlines. Just thing of that glorious programming language,
> PHP.
> 
> (Ducks).
> 
> Actually, 99% of my usage of git is tracking CVS projects so this is a
> bit of a problem.
> 
> I had fixed it in Johannes version, but I'm lost as to where to fix it
> in the current git-annotate. Help?

Can you point me at a tree that has this problem?  I'll see what I can
do about fixing it tonight.

-- 

Ryan Anderson
  sometimes Pug Majere
