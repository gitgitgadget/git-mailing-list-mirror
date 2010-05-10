From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control  end-of-line conversion
Date: Mon, 10 May 2010 20:33:39 +0200
Message-ID: <809F5FF0-B8C9-41A1-A862-3FABD4184A5C@gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com> <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com> <20100509070043.GB14069@dpotapov.dyndns.org> <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com> <u2p76718491005091002v516429ddrf118c35f3312c3ab@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 20:33:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBXnb-0005kd-OL
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 20:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab0EJSdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 14:33:46 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:60342 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384Ab0EJSdo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 14:33:44 -0400
Received: by ewy20 with SMTP id 20so1066496ewy.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=0DV6uDi6cFLjE4HJkKEKtEaESbdZX2YLq0cgtEb7cvc=;
        b=Hz2mVlObB7iXhKcWYGb+mT5oTpr80pLAodlw4PLtgTsxD0x1aq6ZAUkS9nb5IFMuSG
         h9yLaNQL9JKKgIYgOVLR0b/m42wQ1UpyUemcTbkrwMiyu5QOSSMFBsHiC/8DTbyXW0Qs
         wsStW3lCL3dpv6MuPPyE4Z8AnL6BmqXymTr/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=WvRtV5Lh5c/LJ2WrbzEdP7h2Z2x5ycV6gmnFIgnoSLeMaK6nTMG1Xswi8UDJZWGrlq
         u6N2xR5YGteum5m/GskeTpI4QcGLg03q26JBZe6U5H+T0aXMn1wQttVMAU6BJXoyqNvl
         RnzPC8Gwnn/mYl9ACKKqCZPWb18ZRpTtmJf5U=
Received: by 10.213.49.204 with SMTP id w12mr1537476ebf.22.1273516422945;
        Mon, 10 May 2010 11:33:42 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm2650746ewy.1.2010.05.10.11.33.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 11:33:42 -0700 (PDT)
In-Reply-To: <u2p76718491005091002v516429ddrf118c35f3312c3ab@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146842>

On 9. mai 2010, at 19.02, Jay Soffian wrote:

> Bah. I think relegating the old names to "deprecated, for
> compatibility" is absolutely the right thing to do. Is there a use
> case where the existing crlf setup is preferable? If not, why not just
> mark them as deprecated in the documentation and say "see ..."
> pointing to the new functionality and use the new names as you
> suggest.

I don't know if it would get accepted, but I'll add a commit that does that to the next iteration :)
-- 
Eyvind
