From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: fatal: Out of memory, malloc failed
Date: Mon, 16 Apr 2007 10:03:48 +0200
Message-ID: <81b0412b0704160103p15924e94idfaa445a30fe8e81@mail.gmail.com>
References: <461FBD02.6050105@eircom.net>
	 <Pine.LNX.4.64.0704131143130.28042@woody.linux-foundation.org>
	 <462277CD.5020609@eircom.net> <20070415214050.GA4417@steel.home>
	 <462329D8.4020302@eircom.net>
	 <Pine.LNX.4.64.0704160853050.7680@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alan Larkin" <nobrow@eircom.net>, git@vger.kernel.org
To: "Julian Phillips" <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Apr 16 10:04:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdMCK-0003fM-5e
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 10:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbXDPIDu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 04:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbXDPIDu
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 04:03:50 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:1766 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964959AbXDPIDs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 04:03:48 -0400
Received: by an-out-0708.google.com with SMTP id b33so1641761ana
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 01:03:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fM0qFZhBKcomFreTersSPuD1H0MTZMcIoQwj4x+0X0gSL85gGRBjOvID9qf3QbgWxUx6Q2oldFFChpvS8ZfEzqQ/fAccoZp2cn97xra0bVNQEQ64ClzVpdoKBQisCFwNBy2NOLCqOlGvHR49lcwfCQeaVGsTVS4bzx9jAVL4Hvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lwoaqnumzzkx/Kx4tMU756icdqTmpVRG19t7nc/BeF4jKbNodiOzftkCJwqyRfUCgZthGGVvY8rHj3OJH3wwl+jEarEZcaC7Qoq3Bc9KBqxgvosEEOqGd49a6W6cD/S6JeC+1Z3l+8O0G0HEKCnPWqR8lwP5vB0PtuezUKx2Gmc=
Received: by 10.100.177.16 with SMTP id z16mr4278490ane.1176710628093;
        Mon, 16 Apr 2007 01:03:48 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Mon, 16 Apr 2007 01:03:48 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704160853050.7680@beast.quantumfyre.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44617>

On 4/16/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
> >
> > Thats what I thought, but malloc continued to fail until the 72Mb file was removed.
> >
> > No, my server is running Debian. I had the push problem when logged in on that.
> > It worked when I pushed it from a Gentoo box.
>
> a problem with ulimit -m on the server?
>

Nah, a process gets killed in case of a limit hit.
He gets malloc returning NULL.
