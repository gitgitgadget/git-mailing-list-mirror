From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile git)
Date: Thu, 9 Aug 2007 15:55:54 +0200
Message-ID: <81b0412b0708090655v7cf8acc3rbca86d0d59ff813c@mail.gmail.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>
	 <E3C81783E0454702B1F38D0B68CE1AC0@ntdev.corp.microsoft.com>
	 <Pine.LNX.4.64.0708032231320.14781@racer.site>
	 <e7bda7770708031716i61f80d89o8970b3236a961613@mail.gmail.com>
	 <Pine.LNX.4.64.0708040123560.14781@racer.site>
	 <e7bda7770708051641h15bd38abo659e74322e6232c0@mail.gmail.com>
	 <Pine.LNX.4.64.0708060054020.14781@racer.site>
	 <46B6B60C.4080805@trolltech.com>
	 <81b0412b0708090147y11783e3i4f0a6251dbe2c736@mail.gmail.com>
	 <Pine.LNX.4.64.0708091013430.21857@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Marius Storm-Olsen" <marius@trolltech.com>,
	"Torgil Svensson" <torgil.svensson@gmail.com>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 09 15:56:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ8Ua-0001RP-SC
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 15:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932978AbXHINz5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 09:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762057AbXHINz5
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 09:55:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:29175 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbXHINz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 09:55:56 -0400
Received: by ug-out-1314.google.com with SMTP id j3so340269ugf
        for <git@vger.kernel.org>; Thu, 09 Aug 2007 06:55:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mmKuOJX1Cmup62i17FsGNw/6oAMzgfkvHOBCTqHMPjFEcO6rWilc+xc/DWTGaLhyUDTUqtluHWORiuKo25nxGuRIb9KfgOHJba8Ob8621ka3Rizm3+j3iYX6Wb7EPXxW9i3YGN49mCKDFqWxI3T83h9KmKPvXrjbfn03kFy5X40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hjQ8GMJsh2/GoUyYq5fKp4LSWlQPOlBqP3inIXV1EzAd0FF/eoAAjJkCix3uWhY9YwPwDIykfSPvLGA1UkW4uFKNyg+jICeaEuXEL1UxsAKRPCtbjIlWoF/0492ogzOjKvtwpH5BVbsbFafcgHijMcH9tg1RdV5EiSeB3tLVz4Y=
Received: by 10.78.180.18 with SMTP id c18mr914999huf.1186667754134;
        Thu, 09 Aug 2007 06:55:54 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Thu, 9 Aug 2007 06:55:54 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708091013430.21857@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55452>

On 8/9/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Very impressive.
>
> I have some issues with it, though.
>
> - I really hate to leave anything older than W2K behind.  You might not
>   care, but I do.
>
> - I tested it, and it gave a constant flicker, at least in the status bar.
>   Does not seem to be that fleshed out.

That's typical for impressive windows hackery...
Switching the transparency completely (frame and background in tabs) off
seem to help with the flicker. At least it does not flicker much for w2k here.
