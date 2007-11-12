From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 0/5] some shell portability fixes
Date: Mon, 12 Nov 2007 18:20:54 +0700
Message-ID: <fcaeb9bf0711120320jce181d4xd962c538a898c039@mail.gmail.com>
References: <20071106201518.GA6361@ins.uni-bonn.de>
	 <7v8x5bgl04.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0711070758w5832ab83ic16e8fb4edb80972@mail.gmail.com>
	 <fcaeb9bf0711070805x49228d8dq7e8e6f26060c47ab@mail.gmail.com>
	 <7v3avhbxdq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Ralf Wildenhues" <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 12:21:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrXLt-0001fS-0F
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 12:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757054AbXKLLU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 06:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757374AbXKLLU4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 06:20:56 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:25596 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757043AbXKLLUz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 06:20:55 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1059675nfb
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 03:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Os3uw5P34ey50fJvx/uB9YEzZmgRSHzdmFCuXBh94lc=;
        b=jEqVtdsxaBRLp1wVlKJgcnenYBIfZvLvRKM+8WgpntLDWnlOji2SWtFNXYUoULe6GnAVbIC9Pi6e5cwkE4Whn1K2oBWuyz+pYW/yB6IeD8wqXACy+qfeuyQfUyWpZqGaJTWc/B+yMUw3ZEN5i2rFRe6FlGXY5t7cVPFFXi/9sSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KqhiyAGMREQcmpsxxhoXpt8jwDk4ayHk/caAddVEK2ZOJnV4/Z+LdNSrGmXmzlTqwRI+I7LUE5dNIK0uJNm+l0guoTtt7COQLYytkGGwC3iVwW3DTMb15TYOW4ZlIMpFJH4vygqMt4UpyxBG6WhkzTgp+eQNTglhVWYhqUTVaSs=
Received: by 10.86.60.7 with SMTP id i7mr4523232fga.1194866454190;
        Mon, 12 Nov 2007 03:20:54 -0800 (PST)
Received: by 10.86.25.2 with HTTP; Mon, 12 Nov 2007 03:20:54 -0800 (PST)
In-Reply-To: <7v3avhbxdq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64603>

On Nov 8, 2007 3:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>
> > On 11/7/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> >> On 11/7/07, Junio C Hamano <gitster@pobox.com> wrote:
> >> > [2/5] Gaah, AIX sed X-<.  I am not opposed to this patch but
> >> >       would want to get Yays from people with non GNU sed.  Is
> >> >       busybox sed good enough to grok our scripts these days?
> >> >       Please ask help and collect Acks at least from folks on
> >> >       Solaris, MacOS, FBSD, and OBSD.
> >>
> >> I haven't extensively used all the scripts. There seems to be no
> >> sed-related failure from git testsuite results in my git-box branch.
> >> So I would say for now it's good enough.
> >
> > Argh, should have made it clear, busybox sed is good enough.
>
> Thanks.  And you can also happy grok Ralf's rewritten construct,
> right?
>
> That is, existing
>
>         $ sed -e 's/foo/\n/' file
>
> will be rewritten by the patch [2/5] to
>
>         $ sed -e 's/foo/\
>         /' file
>
>

Yes it worked well

-- 
Duy
