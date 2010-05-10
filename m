From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control end-of-line conversion
Date: Mon, 10 May 2010 07:14:21 +0200
Message-ID: <3AD575F0-D29E-4E2B-96EA-862C167F7FDC@gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com> <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com> <20100509070043.GB14069@dpotapov.dyndns.org> <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com> <7v632x9dfk.fsf@alter.siamese.dyndns.org> <20100509181853.GA4676@pvv.org> <7vwrvc91r8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 10 07:14:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBLK4-0005fE-09
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 07:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab0EJFO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 01:14:26 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:34962 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab0EJFOZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 01:14:25 -0400
Received: by ewy20 with SMTP id 20so785625ewy.1
        for <git@vger.kernel.org>; Sun, 09 May 2010 22:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=jFQ0ciFiv1thkaPWJzDdg8XqI/N0vIQ4kJbXaR38YHI=;
        b=D17j1Ik2RNDK+BWpOdyZxt8Q/ncdp5qfRkmVWl2fRAfGs9H5xEWe/0myaqkSHs561U
         0BSR32E2OLFdwcvMgjqXWSekMs0KVdXP5J/XL6ao0900WPPCJWWV8M9QyEKR4tsp6v0u
         eRqx/7ce37Wcsj4C3TxIlJN/xkgwu2nx+xhWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=hLEQlRDqsoKfAOI5c4oI5M+cGBnNnftMq8XifSHvX0nw/LNaQ8iawRSUjplCOPW+xq
         9v8iX6HAT4Z2EMenU4I7D13g1Ymq1oOZ2XK556FnM54mnatiS0pMN+9Jwfl+SovZg7Zj
         wfbnMkK1+hbRExWatWif0kt988mQHz2aSRMqo=
Received: by 10.213.49.144 with SMTP id v16mr1421866ebf.46.1273468463345;
        Sun, 09 May 2010 22:14:23 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm2305862ewy.13.2010.05.09.22.14.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 May 2010 22:14:22 -0700 (PDT)
In-Reply-To: <7vwrvc91r8.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146758>

On 9. mai 2010, at 23.57, Junio C Hamano wrote:

> Finn Arne Gangstad <finnag@pvv.org> writes:
> 
>> Are you thinking we could live completely without it?
> 
> Yes, and your description makes it sound like it doesn't buy us anything
> that an entry '* eolconv=true" in .git/info/attributes wouldn't.

I'm not sure I even knew about .git/info/attributes, but it makes a lot of sense.  The config variable would allow a user to turn on normalization globally, I guess, but that's probably not worth it.
-- 
Eyvind
