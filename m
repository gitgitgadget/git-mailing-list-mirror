From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: fatal: Out of memory, malloc failed
Date: Mon, 16 Apr 2007 10:00:04 +0200
Message-ID: <81b0412b0704160100y35d0f86csd2196fb2864a7037@mail.gmail.com>
References: <461FBD02.6050105@eircom.net>
	 <Pine.LNX.4.64.0704131143130.28042@woody.linux-foundation.org>
	 <462277CD.5020609@eircom.net> <20070415214050.GA4417@steel.home>
	 <462329D8.4020302@eircom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alan Larkin" <nobrow@eircom.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 10:00:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdM8E-00020A-Rl
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 10:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbXDPIAH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 04:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbXDPIAG
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 04:00:06 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:62692 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964862AbXDPIAF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 04:00:05 -0400
Received: by an-out-0708.google.com with SMTP id b33so1640847ana
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 01:00:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cuCbUx+Cw/8psZahyOYYot7GsRDYtubO4xiKFgvzvca1ZsUUSxC2EuXPiOW/3HmhmCcjooqBi1IKryZWrcbge+LNUfRigf8FK6a1wM6dicC4Qbq5CAA1H0i7pyyedaYXwp81FgA3dnSIJmIvMsOJWMiSjsQk4twpG1JNTMZld9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V4AhhVcwRn9MDE1RcusnJ7c5He40b+/73G5HxcTADDneSZvNJPen8RfPL0UNsfiGPMZQcV4ZM3ntk9e6iUJPf1fLgmSAXm9EWe8aOoQ94lcFBLsSm3dFMlRGA4I6mbuO8eNsv6tkQnXXJIUyEfiwid8Mdwr0GX7dE/5vtbPe/DA=
Received: by 10.100.127.1 with SMTP id z1mr4282151anc.1176710404333;
        Mon, 16 Apr 2007 01:00:04 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Mon, 16 Apr 2007 01:00:04 -0700 (PDT)
In-Reply-To: <462329D8.4020302@eircom.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44615>

On 4/16/07, Alan Larkin <nobrow@eircom.net> wrote:
> > 72Mb is nothing. Is it Windows/cygwin, by any chance? (I see the
> > problem there sometimes. Tried debugging it, got into some ugly
> > cygwin-windows interactions, threw up, did the same you did and tried
> > to forget it all).
>
> Thats what I thought, but malloc continued to fail until the 72Mb file was removed.
>
> No, my server is running Debian. I had the push problem when logged in on that.
> It worked when I pushed it from a Gentoo box.

Ok, now _that_ is interesting... Any limits on that server?
What git version?  There were some memory leaks fixed recently...
