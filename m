From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS keyword expansion
Date: Sun, 22 Jul 2007 15:10:04 -0400
Message-ID: <9e4733910707221210t2b2896b5ob4ce7bf95d4a707a@mail.gmail.com>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com>
	 <Pine.LNX.4.64.0707221959100.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 22 21:10:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICgor-00019j-VY
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 21:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762291AbXGVTKN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 15:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762171AbXGVTKN
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 15:10:13 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:3632 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759610AbXGVTKL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 15:10:11 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1728777wah
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 12:10:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kJzlbWdEp8Hx5hAS+kAiD0sjvt8slz/BiECLPvDM5a8+wW7oi1rQK4vk/1JprUYe+Y8Oh2J1WQU3D1mbKBSaPWD+3IjuBJy+NxiQR6nR6ocLVFGlVj7fB0ZmkU9f0zuaMRsQUF/E5H34DdlgpuFImBk0yqvn6wAmy+UKskJPZGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UvxHHFI9hpHC+M0Z7E3nGAgAfEKbcSRj42QVPlAGkGJGuFOyZKMNJDd6yrRS3DHk8bDOVBasopmNi7SONcaEuo5zYjS1u4T5bxFhXnRdylNoe27we7Ly4XKo9H+0w+5LvjkpOn0akJSNfyGYM2FPzZuvtLFinokDQXcV9aoHjxo=
Received: by 10.115.94.1 with SMTP id w1mr2307788wal.1185131404910;
        Sun, 22 Jul 2007 12:10:04 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Sun, 22 Jul 2007 12:10:04 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707221959100.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53297>

On 7/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> [culling lkml list, since this is really a Git problem]
>
> On Sun, 22 Jul 2007, Jon Smirl wrote:
>
> > It would really be useful if git diff had an option for suppressing
> > diffs caused by CVS keyword expansion.
>
> Looks to me slightly a bit like an XY problem.
>
> How about using git-filter-branch to get rid of the expansions?  Or even
> better, if you have access to the CVS server, use the -k option to
> cvsimport?

No access to the server the people handing over the diffs and not
making things easy. You get diffs like this when asking companies to
turn over their changes for GPL compliance purposes. A big source is
from companies building embedded systems., Usually the diffs are
pretty worthless but every once in a while they contain very useful
nuggets (like inadvertently documenting secret hardware features). It
is hard to spot the nuggets in all of the noise.


>
> Hth,
> Dscho
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
