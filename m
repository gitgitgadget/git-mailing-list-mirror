From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH 1/1] Use GIT_ASKPASS environment to launch thirdpart UI 
	app to get password
Date: Fri, 26 Feb 2010 08:15:35 +0800
Message-ID: <1976ea661002251615o2373c527y613c2e9c7b90d98e@mail.gmail.com>
References: <1266923463-2828-1-git-send-email-lznuaa@gmail.com>
	 <20100224051307.GA3232@gmail.com>
	 <1976ea661002240013j164fc875o469c0dcdf74afe0c@mail.gmail.com>
	 <20100225091500.GB2903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 01:15:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nknrr-0006Lw-3H
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 01:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934689Ab0BZAPh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2010 19:15:37 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47762 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934593Ab0BZAPg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2010 19:15:36 -0500
Received: by gyh20 with SMTP id 20so1548815gyh.19
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 16:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ecFRSWGAukFiyxW9BVnv5z8EEv54xussimbJHtVcW+g=;
        b=DaPKBnpFfrYzI1xbbLbg0gLT2UHnXaEDR1L5ObMkgOclFs1WVO5mJpQ/zCF+qmP0uW
         Ar/tcBYLFbN8nnNTnkdhzJ/lL1ctvbxuJ8pcB4E6IfmstgtMx+4Y+kfpfyLKQpev+0Ix
         KLVnRwEO+/9MkZZlmp9B44Ft2xjvNjtSLxNjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E0/4puHqExW+/SFDdD0vY0itgS6B9ZNoxNETevD659nm+qfR4tUNyaIAXeIxCFA2Bv
         GNxc9FaxjUuMHT0yZnMfQMXiXa97uIW7UaMYvG2GAWpqyF0PnL2/mPrs199ytMPZtV44
         i1Vu3evhv7uLokNGDr9KWU5QT/jZCkppZl3js=
Received: by 10.150.235.11 with SMTP id i11mr676485ybh.289.1267143335657; Thu, 
	25 Feb 2010 16:15:35 -0800 (PST)
In-Reply-To: <20100225091500.GB2903@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141083>

>
> I would have done it in the script as a localized fix but
> I definately see the value in aiding scripts from
> all having to implement this same fallback, though:
>
> =A0 =A0 =A0 =A0$ENV{GIT_ASKPASS} ||=3D $ENV{SSH_ASKPASS};
>

Add it at [PATCH v2 1/3] git-svn: Support retrieving passwords with GIT=
_ASKPASS
