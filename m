From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: svn to git, N-squared?
Date: Mon, 12 Jun 2006 12:16:46 -0400
Message-ID: <9e4733910606120916o10b0eaf5t65590f88a94e735@mail.gmail.com>
References: <20060612043949.20992.qmail@science.horizon.com>
	 <9e4733910606120832xaf74e77pad7f70df864541fc@mail.gmail.com>
	 <Pine.LNX.4.64.0606120843340.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 18:17:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpp63-0005PQ-Dk
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 18:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbWFLQQs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 12:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbWFLQQs
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 12:16:48 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:43724 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752076AbWFLQQr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 12:16:47 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1669532nze
        for <git@vger.kernel.org>; Mon, 12 Jun 2006 09:16:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LVBBaXutuPr9iVoc0dz0agjtFQXoJeBgGbe/Qgr3zULPMMIBeUQz2tnErZHCqney7h4zSCz0Sop1gRry1FHOZsQvSRzOG5EjKhgduqm8j+LJNBPvURRN7CtfsRbLbFiZqg72xLNzJPD3YDMLoQY8sW7Srk1p0eHi7ALBZ1ePrW8=
Received: by 10.36.250.47 with SMTP id x47mr4830665nzh;
        Mon, 12 Jun 2006 09:16:46 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Mon, 12 Jun 2006 09:16:46 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606120843340.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21710>

On 6/12/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Mon, 12 Jun 2006, Jon Smirl wrote:
> >
> > I've stablized like this. 1GB RAM with 2.8Ghz P4 hyperthread. Is there
> > anyway to tell what it is doing in the kernel for so much time?
>
> oprofile will tell you.

I don't have profiling turn on in the kernel. I've turned it on so
I'll pick it up next time I reboot.
I'll kill everything and restart when my new RAM arrives tomorrow.

Hopefully the SVN import will finish before then but it doesn't look likely.

-- 
Jon Smirl
jonsmirl@gmail.com
