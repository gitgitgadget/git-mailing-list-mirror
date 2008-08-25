From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] "git shell" won't work, need "git-shell"
Date: Tue, 26 Aug 2008 00:26:28 +0400
Message-ID: <20080825202628.GA8072@dpotapov.dyndns.org>
References: <20080824202325.GA14930@eagain.net> <7vfxoukv56.fsf@gitster.siamese.dyndns.org> <20080824203825.GB14930@eagain.net> <7vbpzikt4b.fsf@gitster.siamese.dyndns.org> <20080825170816.GQ10544@machine.or.cz> <37fcd2780808251020j1ef51b38h7c6d6e8f050a92ce@mail.gmail.com> <alpine.DEB.1.00.0808252015080.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <gitster@pobox.com>,
	Tommi Virtanen <tv@eagain.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 25 22:27:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXif5-00020q-3g
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 22:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbYHYU0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 16:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbYHYU0e
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 16:26:34 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:38244 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbYHYU0e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 16:26:34 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1072744fgg.17
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 13:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=sIb/mjCV8ZLkM5ZXqZuBhBkuf4Ax0zpMzTzn6V80xl4=;
        b=FZ5lNyYvGT9Bnzyw+UOWbswXifBK4th+aYfhqsnjWCFw3hZgiVPSYbzAW1oq8MPH2g
         nzVPZdRgkNGQ5DFJO5Nn4ok2CbtIW9zXcg7MzRU97P4P7FZ13Dr30OxrzMiPAX4j0YyR
         yQMqB/nu0sWKxTzGf2YtkqcX+TSsm8VimrEyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=x8LRAn/tOlkFbrm9nZtJDCcHX30fUvHdUiEDOR0zWw2aTNj3NnnfL6kJeDFENrd1YY
         eoY4LGnv63vkbbsreOOCB/NwwPzrvRYrENha1Rpv1dvsvLMEEB43Zt8ii/dUKDJx6QS0
         hXuPcCglHj5bK7C9zk4zhSMjTK9JcXRSzgbO4=
Received: by 10.86.90.13 with SMTP id n13mr3704764fgb.3.1219695992716;
        Mon, 25 Aug 2008 13:26:32 -0700 (PDT)
Received: from localhost ( [85.140.171.104])
        by mx.google.com with ESMTPS id l12sm5959737fgb.6.2008.08.25.13.26.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Aug 2008 13:26:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808252015080.24820@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93668>

On Mon, Aug 25, 2008 at 08:17:12PM +0200, Johannes Schindelin wrote:
> 
> Does it not strike you as odd, then, that "sh" -- by far the most common 
> login shell -- does not live in /usr/sbin/?

Not at all. "sh" is *often* run directly from the command line. Without
it being in PATH, system(3) and many other things would not work, but
no one tuns git-shell as the real shell to do some job.

Dmitry
