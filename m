From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Makefile: add clean-obsolete-scripts target
Date: Wed, 10 Jan 2007 13:53:53 +0100
Message-ID: <81b0412b0701100453t63b62867ne67819e91f1319b9@mail.gmail.com>
References: <Pine.LNX.4.63.0701101319480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jan 10 13:54:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4cxq-0003U9-Qb
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 13:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932799AbXAJMx4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 07:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbXAJMx4
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 07:53:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:36273 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932799AbXAJMxz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 07:53:55 -0500
Received: by ug-out-1314.google.com with SMTP id 44so102641uga
        for <git@vger.kernel.org>; Wed, 10 Jan 2007 04:53:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sBlgE4kAtvzs6MuomoJEpXl/U740re0fFNsl2mjJJPaKZK8XWs4eSkqr4g6cBG1f+xgJuB6LRci3FhMQjDzGeddaD3RipzHDMVrInLS3M96I4ZeJrM0BWZcAnnH7nwMEkBLGG0d8XjmWgQymVQxHc6L4ZSeq7+kf+W8W5OV2QXs=
Received: by 10.78.187.17 with SMTP id k17mr63137huf.1168433633662;
        Wed, 10 Jan 2007 04:53:53 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Wed, 10 Jan 2007 04:53:53 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701101319480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36506>

On 1/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> On Cygwin, newly builtins are not recognized, because there exist both
> the executable binaries (with .exe extension) _and_ the now-obsolete
> scripts (without extension), but the script is executed.
>
> "make clean-obsolete-scripts" removes these ambiguities by removing the
> older of these file pairs.

Not enough. You have to cleanup the build directory too,
otherwise tests fail, and git-hacking on git itself is ... complicated.
