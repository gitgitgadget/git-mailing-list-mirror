From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: How do I run tests under Valgrind?
Date: Mon, 17 Sep 2012 23:58:27 +0530
Message-ID: <CALkWK0kjar3q74EJMSY54S0_bWmurWiUuxkRxoYYjNUYm+6RWg@mail.gmail.com>
References: <CALkWK0m_9OsAfG_pF3hUDW+EKCyZCn9NiDKKEW6AEOMmAw=yuA@mail.gmail.com>
 <20120917172022.GA1179@sigill.intra.peff.net> <CALkWK0m378ApSwa1xiYUqEjMny5m0wt3KacqdDRU1qt=cw6k8g@mail.gmail.com>
 <20120917173531.GB1179@sigill.intra.peff.net> <CALkWK0kDPGY_3v5SLPtyf+azUwA7msvQOvA+MaCgueZ71i2yGw@mail.gmail.com>
 <20120917174439.GD1179@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 20:29:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDg43-0007F5-1K
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 20:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757185Ab2IQS2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 14:28:50 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:35435 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757008Ab2IQS2u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 14:28:50 -0400
Received: by qaas11 with SMTP id s11so1846720qaa.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 11:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ccw0emnG1oo5kECKNxzdatpXmf/LQi963nBJiwuaTqY=;
        b=xYDIUfTWl7WQY0PCiL+yvD4q5av6evSTWYGj1szL7wsipCTlFWOnqsPNgGWlK0/QeC
         sq9Dx7UAltMNb7HQJ96F+f52CqhnsAYHeSaV8xGM9gR/kDk6nCm6K+Bw39rFDYYt1FCu
         7zB2aRis0yC35EWmADgB40nnAVt7zbX+Ym9gAl8HWxasIddKzCqsmpZykQAQqJviLLrU
         in9mL3sXUHK+KQxVgow0THJoDvzoGT3jlXkUzxrYGI2kaRslhHCa/6qYqTkIkfFlo4r6
         gL0qSE8Supbp4GUoKmeQKhv3KicIGif+Pu0bo6DHlVC2TVqYElOuresQqdxecH8BFEiw
         CZhQ==
Received: by 10.224.58.147 with SMTP id g19mr29349323qah.77.1347906529150;
 Mon, 17 Sep 2012 11:28:49 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 17 Sep 2012 11:28:27 -0700 (PDT)
In-Reply-To: <20120917174439.GD1179@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205728>

Hi,

Jeff King wrote:
> Oh, bleh. Stupid automatic --tee for valgrind. Try this:
>
>   SHELL="/usr/bin/zsh -x" ./t0000-basic.sh --valgrind

I got tons of output, but found it unhelpful.  Any other ideas?

Ram
