From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH 0/5] some shell portability fixes
Date: Wed, 7 Nov 2007 14:17:22 +0000
Message-ID: <e2b179460711070617h7e9af64egcde5122808a4d924@mail.gmail.com>
References: <20071106201518.GA6361@ins.uni-bonn.de>
	 <7v8x5bgl04.fsf@gitster.siamese.dyndns.org>
	 <20071106210210.GA32159@glandium.org>
	 <Pine.LNX.4.64.0711062324590.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Mike Hommey" <mh@glandium.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Ralf Wildenhues" <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 15:17:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iplj4-0001xl-83
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 15:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757683AbXKGORZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 09:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757649AbXKGORY
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 09:17:24 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:59426 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757554AbXKGORX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 09:17:23 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2459118wxd
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 06:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4Gi5nWM7lGOiMgnrqWjj7XfxPNgJ2dmHi+1pPaGvmRM=;
        b=k1P7JFhykgBCaoPZy/0GftoYCgmz4pVzkvi2BlQcv/3/nfjDA1wwC83XoD5baz6IyRkyoRW1gtPwBwQRzw0WvYjceUI9KZiKMzjn25UODiixY9kAaJr9ezokbnPEsNZeyZEh9fS8j6VXOob7eIMAF3SpGYkiJ3jVh1h89ar8+jI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uWkscahKEtZ1FeIvpbrWmxH57nlonrHSHiLi3E1ON+wtbeUWHfcZWtadZZJS50oXh7pbBaNfh1Q4oMrO7WvgmiA11Urr5KVdFhXDzYD40Jtb+1dHssReG9F+vKQmMNb1V0ktEnwCiPn2jqmZE9+lHEWUkSjIco39Md1uvlPAzRA=
Received: by 10.90.56.11 with SMTP id e11mr5272243aga.1194445042837;
        Wed, 07 Nov 2007 06:17:22 -0800 (PST)
Received: by 10.90.51.10 with HTTP; Wed, 7 Nov 2007 06:17:22 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711062324590.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63809>

Junio C Hamano wrote on Tue, Nov 06, 2007 at 09:46:35PM CET:
> [2/5] Gaah, AIX sed X-<.  I am not opposed to this patch but
>       would want to get Yays from people with non GNU sed.  Is
>       busybox sed good enough to grok our scripts these days?
>       Please ask help and collect Acks at least from folks on
>       Solaris, MacOS, FBSD, and OBSD.

On Nov 6, 2007 11:25 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> As Junio commented in the part you did not quote, there are better shells
> in Solaris.  Use those.

Equally GNU sed is available as a drop-in rpm for AIX. I wonder if it
would be worth adding
Makefile support for a PATH prefix for the git scripts, so they could
prepend (in this case)
something like /opt/freeware/bin or /usr/linux/bin ?

In our AIX environment many GNU tools are installed but I can't
guarantee they come first
in the paths of the git users.

I'm willing to work up a patch if there's any interest.

Mike
