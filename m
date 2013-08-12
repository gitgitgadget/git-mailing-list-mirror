From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: git should not use a default user.email config value
Date: Mon, 12 Aug 2013 23:01:03 +1000
Message-ID: <CAH5451=PK15n4U-3Mb_TLevF3-r+vrpk1PXD15Oo1A2KFc5i_w@mail.gmail.com>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com> <20130809223758.GB7160@sigill.intra.peff.net>
 <20130809231928.GY14690@google.com> <20130810064717.GB30185@sigill.intra.peff.net>
 <52060EF9.2040504@alum.mit.edu> <7vvc3d1o01.fsf@alter.siamese.dyndns.org>
 <CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com> <20130812123921.GA16088@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 12 15:01:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8rkw-0004n4-0o
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 15:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756202Ab3HLNBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 09:01:44 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:45859 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034Ab3HLNBo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 09:01:44 -0400
Received: by mail-vc0-f171.google.com with SMTP id ij15so2774586vcb.16
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 06:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wZv8Sd6MX2v9awUYuPhqHwecYmWngUBm2cPQimGY7p0=;
        b=xow8OWOTeZ/oIJJPMJ+P22hvZqfHwgze2FQpx7pRT8KwKbc3skmOSErx9fQAlxsYLv
         DBaBNcuCLuVk4cVOohRP3R4dxjZ+NFd47C5Z8pSff85mrsA3POXsW2AmYUCLHqfWVjPn
         afnd+DijvvOVz//eJ+h0bDu6LVXwlu8RdwSvGmIpqd43zejXIQVYDpi1+71gJZvbcBcT
         1qAou/5XxSXmdN4vkkPu+WtjRMwdaF3ovqAWDUh57XXNcnoqcByf6Lmtta9lyg4avRLy
         +uj4WTvIT1l6HLiLEutIVR81ZdSEwQqg5o36ymQnjZyDZsMpUDptgugRSBSkd+DVGFOZ
         3hag==
X-Received: by 10.220.6.8 with SMTP id 8mr6284849vcx.82.1376312503346; Mon, 12
 Aug 2013 06:01:43 -0700 (PDT)
Received: by 10.220.195.133 with HTTP; Mon, 12 Aug 2013 06:01:03 -0700 (PDT)
In-Reply-To: <20130812123921.GA16088@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232190>

On 12 August 2013 22:39, Jeff King <peff@peff.net> wrote:
> We could do something like the patch below, which allows:
>
>   $ git config --global include./magic/.path .gitconfig-magic
>
> to read ~/.gitconfig-magic only when we are in a repository with a
> directory component "/magic/".

Thanks, this looks great! I'll have a play with it tomorrow.

Would locally configured config options override this one? From a
quick read of the patch there doesn't look like there is a way of
turning this off for a specific repository, but perhaps that is
unnecessary. I think after a bit of use the edge cases will be a bit
clearer.

Again thanks, this will scratch an itch I didn't even realise I had.

Regards,

Andrew Ardill
