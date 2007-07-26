From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 15:32:47 +0200
Message-ID: <46d6db660707260632q16f927a2r64f6b4588dd3cb48@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com>
	 <Pine.LNX.4.64.0707251510130.14781@racer.site>
	 <fcaeb9bf0707250715p7c183a81vc78f641eef493777@mail.gmail.com>
	 <46d6db660707260600w6c3ca5d2ve6aaf06c7684789d@mail.gmail.com>
	 <fcaeb9bf0707260620i2ec1ab36ka470758edfd570d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 15:32:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE3SX-0005hP-QZ
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 15:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbXGZNcu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 09:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbXGZNcu
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 09:32:50 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:17596 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbXGZNct (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 09:32:49 -0400
Received: by nz-out-0506.google.com with SMTP id s18so468086nze
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 06:32:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sViZwP2jrZyFHRbmDVfCpwv6U7fVU8ZDu5t28pQICXjoU/2RoEbjrCayctBQMklEo/eMhlilUhazuWx55H2Qnrcf7P2HVIwPdt+UDgCW3GfBj0/+JtuSkvhXd1QhwoCTd+u4taa7zFTQI+e+7pcqPbMWtoB4YL0sTyILX+bQ02I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H+kOUeP4dhiuvdpWqTzZ4lJCPZLd6pTWfRHgZ/xq5NS+ihaYzMVsmuXCo7hE5s/iCLhAyyuIy1wjtbumaARe2l8Yv5iiodu9N1SBp/yRwVLy7hFUwYkd+P4qa9xlNemqhJSGVcabwXCD61mf1nPaMNsR5pjvoAY7m85ZdKEdxIQ=
Received: by 10.115.72.1 with SMTP id z1mr1742342wak.1185456767500;
        Thu, 26 Jul 2007 06:32:47 -0700 (PDT)
Received: by 10.115.78.15 with HTTP; Thu, 26 Jul 2007 06:32:47 -0700 (PDT)
In-Reply-To: <fcaeb9bf0707260620i2ec1ab36ka470758edfd570d2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53829>

On 7/26/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On 7/26/07, Christian MICHON <christian.michon@gmail.com> wrote:
> > it seems you're not very far off. I believe you intend to replace in git-commit
> > "#!c:/msys/bin/sh" with something like "#!c:/gitbox/bin/gitbox ash", right ?
>
> No. I tweaked try_shell_exec() to use gitbox shell if the interpreter is "sh".
>

interesting. have you tried inserting busybox vi inside git-box ?

I can commit using "git commit -a -m ok", but then I get this kind of
error message (and ash dies, I go back to xp/cmd prompt)

mv: cannot rename '.git/next-index4540': File exists
C:/gitbox/bin/git-commit: exit: line 658: Illegal number: -1

nice piece of work. it could really be tiny once fixed.

I suggest to replace most git-* by git-box/ash shell wrappers,
calling the git.exe binary directly.

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu
