From: "Bahadir Balban" <bahadir.balban@gmail.com>
Subject: Getting a file revision
Date: Sun, 19 Aug 2007 01:42:30 +0100
Message-ID: <7ac1e90c0708181742w531dab4asc7c90835cc56e8a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 19 02:42:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMYsG-0000xq-LN
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 02:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790AbXHSAmd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Aug 2007 20:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753312AbXHSAmd
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Aug 2007 20:42:33 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:22921 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055AbXHSAmc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2007 20:42:32 -0400
Received: by py-out-1112.google.com with SMTP id u77so1437223pyb
        for <git@vger.kernel.org>; Sat, 18 Aug 2007 17:42:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Vbm8YTFFoGFoe8OEAquCpuWk4ZZsNlQ4l5+TEk16nOGLBS58V1FvvvFZoPKGR0Vg4t0uSSVBsarvGcUwBGlmrNGwKuMzkDcNMdjcQr4qVlItefskn4nJBnzqc/N7Hx+iF8Fxa9IRVRoRQhTT6joihwVR16ARoqa7gWaSXQlG4Xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=czG0kbAo6pW1db58HJsjJ0zEJZLCZd13Do+d8E4OnHGwQMxoTE+o29lkwF0dNsbiLZwQuLubJ50WRjv9fLqr8uiEGYzDUcczyzDna85Hm0f+d/DjMO47bq9SUQt9vcPARmpVCzMUXrGOh3qBhnXvwt7Bmzm5Lc5y+afweGZ0dxI=
Received: by 10.35.106.15 with SMTP id i15mr5358460pym.1187484150589;
        Sat, 18 Aug 2007 17:42:30 -0700 (PDT)
Received: by 10.65.250.2 with HTTP; Sat, 18 Aug 2007 17:42:30 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56119>

Hi,

This might sound like a novice question but anyway: I sometimes have a
need to quickly recover an old revision of a file just to check
something or copy some code from it. I would imagine having a command
like:

git-getrev <filename> <commit> or something, and the file would appear
in its path, or the git root directory as <filename>.<commit>

Is there an existing way to achieve a similar result? I can certainly
checkout a branch, revert to that commit I want, copy the file, and
come back to HEAD, but its not as quick.

Thanks,
Bahadir
