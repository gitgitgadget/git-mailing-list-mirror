From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: Question about "git commit -a"
Date: Fri, 5 Oct 2007 10:39:45 +0200
Message-ID: <4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
	 <545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com>
	 <fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com>
	 <Pine.LNX.4.64.0710042209410.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 05 10:39:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idij1-0005Eu-49
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 10:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581AbXJEIjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 04:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbXJEIjs
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 04:39:48 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:21452 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314AbXJEIjr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 04:39:47 -0400
Received: by nz-out-0506.google.com with SMTP id s18so383840nze
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 01:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=sNojKpJfmxSojGA1SnfxWev73D8mxYW9J/jJFz3oaKA=;
        b=rl7OQMno3hLV6I1gbA6cY6u7QnYsesrcbmqmqJik4s1qqPo9qdYZ1tVaHiJfbgeAmBOQOnihNN3UvvxtHmhLv9dmgyaxBd5euBmzGDT2Oiq6dcbdFXZu/Y4KCpfLBMF2s61QTcDtE0tWRco9S3yZPNqdBkPivL1Z4/C9CJLy5FU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NlMfc+sQXlqp3qSMvVB9hMjARVFAvlYxwjdkHudUNvMMRX+zlEAgfbjkGmneoB0I4L/wClNAkq0Ow2LxLWIb/5QW+ZQf35ujUSb9gpnVaVip9ImE41vACzVn3rz2Kc5FIcijJmiY3PRtprravq24Qti+4Vi0ba1+E/QlkjTFJZg=
Received: by 10.142.177.7 with SMTP id z7mr1380477wfe.1191573585997;
        Fri, 05 Oct 2007 01:39:45 -0700 (PDT)
Received: by 10.143.43.21 with HTTP; Fri, 5 Oct 2007 01:39:45 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710042209410.4174@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60052>

On 10/4/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 5 Oct 2007, Nguyen Thai Ngoc Duy wrote:
>
> > On 10/4/07, Wincent Colaiuta <win@wincent.com> wrote:
> > > > Am I wrong?
> > >
> > > About it being a majority, yes, I suspect so.
> > >
> >
> > Maybe in the next survey we should include question "do you usually do
> > 'git commit' or 'git commit -a'" :-)
>
> Not meaning to discourage you, but it is a known fact that Linus does "git
> commit" without "-a" quite often.
>
> And if that were not bad enough for your plan, I myself omit "-a"
> regularly.  So you would get a veto from me, too.

So you are used to do something like (please correct me if I'm wrong):
- modify A
- modify B
- modify C
- modify D
- modify E

$ git A B E
$ git add A B E (A, B and E are now in the staging area)
$ git commit -m "I just modified A,B and E"
$ git C D
$ git add C D (C and D are now in the staging area)
$ git commit -m "I just modified C and D"

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
