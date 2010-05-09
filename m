From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control  end-of-line conversion
Date: Sun, 9 May 2010 20:59:04 +0200
Message-ID: <E6434515-5357-4FF4-8049-5E4FCE8B29E4@gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com> <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com> <20100509070043.GB14069@dpotapov.dyndns.org> <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com> <AANLkTikRJ6Hl_fRNRZbxeNNgwv9UTm2fPrOKv4GbT0qJ@mail.gmail.com>
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
	Finn Arne Gangstad <finnag@pvv.org>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 20:59:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBBig-0003BM-Jf
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 20:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315Ab0EIS7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 14:59:12 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:54325 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab0EIS7J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 May 2010 14:59:09 -0400
Received: by ewy20 with SMTP id 20so716513ewy.1
        for <git@vger.kernel.org>; Sun, 09 May 2010 11:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=1mFgY7Ckr1nTVSr+h2G5MsRC3HqSNyfM+DrmkpL0Ex4=;
        b=rkjFcuxcgoAN4NS4Q2+7yBazplajWzrfVXvBa+5FLsLiBzt7ZZB+x35BH/jk2kW/g2
         DBg9IP93ePBQoV5+44wcEsMG/2mKve+Eb8jKlRXKRwXmGh14EcDwPcN+uE9zeAVg8mZW
         v5FWxjCMlo0bJR71XQXJ1Olc7diMlTHoY+Ot4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=g5K4dAcsMN5LUGJRQ2cf1SqS9cZ3xvzNp/h8oNhPTtM3VBtlPoutr7EAoIJFQGkVFk
         cxkP1jdc1jPrf1mmADSUFzTBG9VrfofBTdhTInpFOQQn3TMabVpFRKuKh8Cnb9rWZ+B/
         ogXxf5HxJgyp3G0jVQP1/9hrcBJWpp+4dT1Sw=
Received: by 10.213.37.67 with SMTP id w3mr883524ebd.69.1273431548544;
        Sun, 09 May 2010 11:59:08 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 14sm2162949ewy.6.2010.05.09.11.59.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 May 2010 11:59:08 -0700 (PDT)
In-Reply-To: <AANLkTikRJ6Hl_fRNRZbxeNNgwv9UTm2fPrOKv4GbT0qJ@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146738>

On 9. mai 2010, at 13.14, Robert Buck wrote:

> So, the meanings of these would become...
> 
> core.crlf [ auto | input | false ] : 'auto' means to enable
> bidirectional normalization, and 'false' would mean do not
> normalization, and 'input' would mean normalize on input only,
> otherwise output lf. Is this true?

No, "auto" means to enable normalization for files git doesn't identify as text files, "true" means to always normalize, and "false" means never normalize.  I probably wouldn't implement "input" unless there was a lot of demand.  The idea is to make it act exactly like the "crlf" attribute, even though "core.crlf=true/false" would probably be used very rarely...  I'm having second thoughts, actually.

> core.localcrlf [ crlf | lf ] : this is obvious, and use-friendly

Well, yes.  I was thinking "true|false" (ie "I want crlf" or "I don't want crlf"), but I'm having second thoughts about that, too.

> For the above case have you considered using 'core.crlflocal' instead?
> Usability-wise the related properties start with the same name prefix.

I didn't think too much about the name, so a completely different name might be even better.

Because of this and my second thoughts, I'm going to wait a few days before I make any more changes to allow good ideas to appear and give them time to sink in.

> From a usability standpoint, I personally prefer something similar to
> what you (see "my user interface would have been") specified, slight
> adjustment to the names only:
> 
> core.eolconv [ true | false ] - whether or not to turn on conversions
> core.eoltype [ lf | crlf ] - by default what to convert to for text files

Agreed, but I think getting this feature included is more important than getting the user interface exactly right.  A compromise between backwards compatibility and user friendliness is okay.

> I like this purely because, from the users standpoint, saying
> something like "localcrlf crlf" is strange; meaning the term "crlf" is
> on both sides of the assignment. I do prefer "eol... crlf", where eol
> refers to the applicability of the property and crlf is only one such
> value.

Yes, my "localcrlf" would be true/false instead of crlf/lf.  It's definitely a compromise :)
-- 
Eyvind
