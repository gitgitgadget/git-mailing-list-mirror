From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGit PATCH] Remove most ASSERT warnings in Git::setStatus
Date: Sun, 20 May 2007 18:06:28 +0200
Message-ID: <e5bfff550705200906x5464dc6bnc31954f5d1dcddd@mail.gmail.com>
References: <200705201401.35991.barra_cuda@katamail.com>
	 <200705201558.53546.barra_cuda@katamail.com>
	 <e5bfff550705200723i7b4e21ebi6a2c51d66659b388@mail.gmail.com>
	 <200705201641.20305.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Sun May 20 18:06:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpnvY-0004w4-BB
	for gcvg-git@gmane.org; Sun, 20 May 2007 18:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757355AbXETQGa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 12:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757466AbXETQGa
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 12:06:30 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:16741 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757355AbXETQGa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 12:06:30 -0400
Received: by wx-out-0506.google.com with SMTP id i26so61198wxd
        for <git@vger.kernel.org>; Sun, 20 May 2007 09:06:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qmAiFO75Oko6PPNO0ji3xqfq9kxVxsvh1VdnDSKic/pL/2nSkFGXIplIA93KrYgbJjDVTPEzbiZrGVZICV2iv9BH5rXMu5m/tm3ttEZPI28QSYsVkpwu/+/kAsqbyFzx9okCr5+5Tz4yjOXvLYrVqQHjsyfAzkMzv+qd+lWK+OI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UIJE8Z99ir2HEmKuai4WHM8aoWsYvN6yk8z9kJTGTOv24GCVjWTqb8PvaWxEdz9P1sg8/GlmhSFb2ZPxrMtpaC/vkmnhp6H8Yrl7fa2lD5QnwTatQo13bL1srYKvju2fR8PWTFpIqYDu6aaU+hn+rBvsKXE+XlEvdGkJr8ZZK94=
Received: by 10.114.56.1 with SMTP id e1mr2070060waa.1179677188790;
        Sun, 20 May 2007 09:06:28 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 20 May 2007 09:06:28 -0700 (PDT)
In-Reply-To: <200705201641.20305.barra_cuda@katamail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47849>

On 5/20/07, Michael <barra_cuda@katamail.com> wrote:
> "Marco Costalba" <mcostalba@gmail.com>:
> > So I rather would prefer something like
> >
> > line.section('\t', 0, 0).section(' ', -1, -1).left(1)
> >
> > because we could have more then one file separated by a tab, so
> >
> > line.section('\t', -2, -2).right(1)
> >
> > it seems to me a little bit fragile. What do you think?
>
> You're right.
>
> > Also I don't understand why you consider the right most (right(1)),
> > instead of the left most character as the status.
>
> Only because it was simpler AND because I didn't know it was wrong.
>

Patch pushed to public repo both for qgit and qgit4.


Grazie per il report
Marco
