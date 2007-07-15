From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Sun, 15 Jul 2007 13:32:55 +0200
Message-ID: <e5bfff550707150432v780d8361yba2fc729504d5b73@mail.gmail.com>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	 <7vodiehko7.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550707141346q2eba4ab8ka1c85e8b5a2c1b1d@mail.gmail.com>
	 <20070715093529.GD2568@steel.home>
	 <e5bfff550707150306t3196f723ia3071ac301fb3f24@mail.gmail.com>
	 <20070715104858.GG2568@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 13:33:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA2LU-0004L8-Lq
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 13:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757873AbXGOLc5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 07:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757279AbXGOLc5
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 07:32:57 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:47367 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631AbXGOLc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 07:32:56 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1237089wah
        for <git@vger.kernel.org>; Sun, 15 Jul 2007 04:32:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qA8sCVieH2dVUq4SmM0JYYt0KFGE8Zri3OJCRBA3DBncvlCwoGyzPtdKyJBgoq9qA43ADq5ZYr7Ogx2kmozgHX7HbvkWoRwiWZ2dqUGgnr43k0KgaPpTr/IKua4AaeuleQjWEI3VMO3IpTYFuXk7UpqyGfF4amLeWefw31flE4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vm76IcCRejcKoEbUrF551QSKF18manbPHJyzB6HoNJx2Rw8pshwvruN5GXq3frw3iWLIR2cuiLyrf+QDliHEp5m1pTazp1OaN8N7Byboc7XmpdUEyg74i3EC5PXKLHsLlwQrgphua4t69v89i2gFY5f7h9i6+KSagODWJBrkrhE=
Received: by 10.114.178.1 with SMTP id a1mr3204265waf.1184499175433;
        Sun, 15 Jul 2007 04:32:55 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sun, 15 Jul 2007 04:32:55 -0700 (PDT)
In-Reply-To: <20070715104858.GG2568@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52543>

On 7/15/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> Marco Costalba, Sun, Jul 15, 2007 12:06:53 +0200:
> >
> > Hope this clears any doubts regarding (supposed) slowness of Qt classes.
>
> No, it does not. Look at the implementation of memchr.
>

If this is the implementation you refer:
http://www.google.com/codesearch?hl=it&q=+lang:c+license:gpl+package:libc+memchr+show:6Tvt4_C8w_Q:Sdpf5XO0rrM:Emqlj8d07Ns&sa=N&cd=4&ct=rc&cs_p=http://ftp.gnu.org/gnu/glibc/glibc-2.2.1.tar.gz&cs_f=glibc-2.2.1/sysdeps/i386/bits/string.h#a0

I would say that I would prefer to avoid assemply and Qt libs seems to
do the same, perhaps for portability, but it's only a guess.

Anyway with the proposed patch to git you don't need assembly at all
(to me it's would seem an overkill)

Marco
