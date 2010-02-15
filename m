From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git locate
Date: Mon, 15 Feb 2010 14:20:35 +0100
Message-ID: <fabb9a1e1002150520v29cf8d59ke27cde3e9697b011@mail.gmail.com>
References: <43d8ce651001191717l58d10919j691f4e5b056fe9b5@mail.gmail.com> 
	<alpine.DEB.1.00.1001200224270.4985@pacific.mpi-cbg.de> <m3zl49bk0o.fsf@localhost.localdomain> 
	<alpine.DEB.1.00.1001201021060.31129@intel-tinevez-2-302> 
	<4B579BA8.8050000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: SungHyun Nam <goweol@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 14:21:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh0st-0005yz-4s
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 14:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189Ab0BONU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 08:20:58 -0500
Received: from mail-px0-f204.google.com ([209.85.216.204]:59263 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab0BONUz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 08:20:55 -0500
Received: by pxi42 with SMTP id 42so3279478pxi.5
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 05:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=PyjK6YMzU/xzIFeO16ipwMiyQvt1c+VR8jnIB+n1z4g=;
        b=n33ETFkvfRaQRx7iIMekJzUAqrRVnZXbBVOcoOV9NTuTQ2QeCvFErMxqjb6XmYD31W
         0zf81RvQx5Y4FYTCFxQpWatAq0eJIiPEPcehtfM9aW/EWiP/B+JU3CF+Lpbs/z5jiUmH
         H69IfTjb8Y1ezUJ+V7Q6R3YT7oM8cqxp8qGXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=q5FDOggLtgjw0SxjBNUOLXNyAGe7dgp7TJWNZZdQO82S39SBSt+Tx7gST3hDlNtvHq
         PuxTR8gerqqgF+cEK7mcozYnnvnVz+wVBuaTrhtQGD1f4uSl1ba2Q+h2uOfeQltFOWTw
         XIrQUJ0tbmjEnFrMo9HOxrfZGnkMEIbke40NY=
Received: by 10.142.9.26 with SMTP id 26mr3406681wfi.24.1266240055056; Mon, 15 
	Feb 2010 05:20:55 -0800 (PST)
In-Reply-To: <4B579BA8.8050000@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140008>

Heya,

On Thu, Jan 21, 2010 at 01:11, SungHyun Nam <goweol@gmail.com> wrote:
> The alias 'git locate' and the command 'git ls-files' runs
> differently if I run them in a subdirectory.
> Is it expected?

I just ran into this (I wanted to alias 'git find' but to me the 'run
ls-files from cwd' is desirable. Also, I prefer to have a trailing
glob as well, so I added one :). An easy solution is to drop
'git-find' in your path somewhere:

sverre@laptop-sverre:~/bin$ cat git-find
#!/bin/bash

git ls-files "*$1*"

-- 
Cheers,

Sverre Rabbelier
