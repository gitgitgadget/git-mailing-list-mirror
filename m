From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: git should not use a default user.email config value
Date: Tue, 13 Aug 2013 21:05:40 +1000
Message-ID: <CAH5451=WKXUNzovXquFii=EdkeQXJEQ96_CRRebgQW6ow_19VA@mail.gmail.com>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com> <20130809223758.GB7160@sigill.intra.peff.net>
 <20130809231928.GY14690@google.com> <20130810064717.GB30185@sigill.intra.peff.net>
 <52060EF9.2040504@alum.mit.edu> <7vvc3d1o01.fsf@alter.siamese.dyndns.org>
 <CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com>
 <20130812123921.GA16088@sigill.intra.peff.net> <CAH5451=PK15n4U-3Mb_TLevF3-r+vrpk1PXD15Oo1A2KFc5i_w@mail.gmail.com>
 <20130812154520.GA18215@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 13 13:06:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9CQy-0007EH-Qt
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 13:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757399Ab3HMLGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 07:06:24 -0400
Received: from mail-vb0-f51.google.com ([209.85.212.51]:41776 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756929Ab3HMLGW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 07:06:22 -0400
Received: by mail-vb0-f51.google.com with SMTP id x16so6522371vbf.38
        for <git@vger.kernel.org>; Tue, 13 Aug 2013 04:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MPPZQ8uuM2IkYC/o60tmkJEVH3dLdHEOqV1Dd28S28c=;
        b=wbI+QmLc2uNJ0kCyuCERZdJ7aIEwBZ6vUs+cOPDtvJolBzujRH/k6PlMG/u6cw48tG
         LqPgl16LvKjNRP+DFRpmhCHp9N2LAsonGjvVqMV6BQt636Jix2xpW2otQksGx6J50Rzr
         qsHiP8nzo+Cvm2WuzzvqNsKuEGY08XzMHG/aDG6AWn2tLSffhCzl0M8Ll5+vNqjlfd5F
         8XsV4TgfljeyIDfT0T+ngl5Kx5tJOPJIDyF42m1KrZ8Xz5CMLaIBPXQ57tcLUjz3eoQO
         7F4vdUusgj+NaMUFBeTIIjq9aGIqjFQtlaSLLyXxnmhRGY05TX7hYFGF+JxLGK/c+vmL
         E4UQ==
X-Received: by 10.220.75.73 with SMTP id x9mr260137vcj.38.1376391981851; Tue,
 13 Aug 2013 04:06:21 -0700 (PDT)
Received: by 10.220.195.133 with HTTP; Tue, 13 Aug 2013 04:05:40 -0700 (PDT)
In-Reply-To: <20130812154520.GA18215@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232220>

On Mon, Aug 12, 2013 at 11:01:03PM +1000, Andrew Ardill wrote:
>On 12 August 2013 22:39, Jeff King <peff@peff.net> wrote:
>> We could do something like the patch below, which allows:
>>
>>   $ git config --global include./magic/.path .gitconfig-magic
>>
>> to read ~/.gitconfig-magic only when we are in a repository with a
>> directory component "/magic/".
>
> Thanks, this looks great! I'll have a play with it tomorrow.

I applied this on top of latest next (1da3ebde8999d07), and it worked
perfectly for my use case.

For what it's worth, it also passed the test suite!

Would be great to see this, or something on the same theme, get into
master. I'd be happy to review patches/write tests/write documentation
if needed.

Regards,

Andrew Ardill
