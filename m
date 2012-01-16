From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Signed tags in octopus merge..
Date: Mon, 16 Jan 2012 15:06:41 -0800
Message-ID: <CA+55aFzZXSCt1AwOotMZJ+GcNcJKL2OcsPOtaZ3=cvraJ=PD+Q@mail.gmail.com>
References: <CA+55aFzRN2F5PZDZPRmbj9occZwA6E6Pi+S+M_Qq2EfS6sctyA@mail.gmail.com>
 <7vobu3uusw.fsf@alter.siamese.dyndns.org> <CAJ8aY1Hi47uyYSjAmtXfDEqgyc8T21WqXdEA0kGS7SQKxQ5b5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jacob Helwig <jacob@technosorcery.net>
X-From: git-owner@vger.kernel.org Tue Jan 17 00:07:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmvdv-0004jG-LF
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 00:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827Ab2APXHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 18:07:05 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37959 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab2APXHE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 18:07:04 -0500
Received: by wgbdq11 with SMTP id dq11so1206233wgb.1
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 15:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=vpncW0p8yFmCi+lfCn64wBL5KHJ/zYIoWKfx1yfmcEs=;
        b=UVHpt6Mj9J53sQ1ph/i89qz/zo/hF9R4ICCrXv3ar3YVcuYXB7V2xapPqJhfi3HtUy
         M/40TQldU+JPNMBNp2+cigM7b8o204Y9hJ3JaE2+C+4w7QAu5VmLCnOm0g+MZ/jdjl+F
         s/JhBabLS+ZbYvOQTNGvND6bofBLNNURzqsbs=
Received: by 10.180.93.193 with SMTP id cw1mr23753106wib.5.1326755222198; Mon,
 16 Jan 2012 15:07:02 -0800 (PST)
Received: by 10.216.63.135 with HTTP; Mon, 16 Jan 2012 15:06:41 -0800 (PST)
In-Reply-To: <CAJ8aY1Hi47uyYSjAmtXfDEqgyc8T21WqXdEA0kGS7SQKxQ5b5g@mail.gmail.com>
X-Google-Sender-Auth: DKhIp8jsZcayRi5E6yuCHeKAZsc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188666>

On Mon, Jan 16, 2012 at 2:58 PM, Jacob Helwig <jacob@technosorcery.net> wrote:
>
> My immediate thought regarding the "side branch #1" version is not
> wanting to have to do the math (even though it's a simple n+1)

"Math is hard, let's go shopping".

But I think even barbie could do the "add one" thing. That said, I
think the current thing is already more than good enough, and I don't
think it's at all confusing to talk about "parent #2". In fact, I
think it's more obvious than "side branch #1".

                  Linus
