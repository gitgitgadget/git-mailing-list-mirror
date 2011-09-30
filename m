From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH] contrib: add a pair of credential helpers for Mac OS X's keychain
Date: Thu, 29 Sep 2011 21:17:11 -0400
Message-ID: <CAEBDL5VbaafKYjJc6spgz94Z4R7QprA7vFPMGWhgk5QY99-wBQ@mail.gmail.com>
References: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
	<20110929075627.GB14022@sigill.intra.peff.net>
	<CAEBDL5WhpVg17aPuRqrE5=2Q293kVD4fYtxGqRzx_K=87t-jgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 30 03:17:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Rj3-0007VN-L1
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 03:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903Ab1I3BRM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 21:17:12 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39369 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712Ab1I3BRL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 21:17:11 -0400
Received: by vcbfk10 with SMTP id fk10so959911vcb.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 18:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZLhtp+Gvr2ebEyJG9lA4n0RYNtsOhprpVWVWxw5XWEI=;
        b=fbtdxfDNvTMkgwJFr9S3jf+5X7mbZlC5LKTl3w8PYzIOitD4+PCnUpcIz6tQF7iQoz
         0iyPPtUsbhuFnDu/kqL5RO1vrazHCCLcZN+syIJcXJZJiA3tR33TqIS63UZO9geoj7gH
         JNGOdQgiyKfl0xg00EFOH90f5cu5JWGdfWdms=
Received: by 10.52.108.68 with SMTP id hi4mr2620013vdb.385.1317345431310; Thu,
 29 Sep 2011 18:17:11 -0700 (PDT)
Received: by 10.220.75.144 with HTTP; Thu, 29 Sep 2011 18:17:11 -0700 (PDT)
In-Reply-To: <CAEBDL5WhpVg17aPuRqrE5=2Q293kVD4fYtxGqRzx_K=87t-jgw@mail.gmail.com>
X-Google-Sender-Auth: -WWViWW8cwsO7-85P1I4KKBIRto
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182460>

On Thu, Sep 29, 2011 at 6:03 AM, John Szakmeister <john@szakmeister.net=
> wrote:
[snip]
> Yep, I agree. =C2=A0And it's worse when using the security command li=
ne
> tool... when you grant security access to the key, then any app could
> technically gain access to the item via the security tool. =C2=A0That=
's one
> of the reasons I didn't pursue that route early on.

Thinking about this a little more, git-credential-anything has the
same problem.  I can run it, and it'll dump out my password for
anybody.  I'd rather it didn't do that.  I think it would be more
satisfying to have the mechanisms built into git itself, without a
separate application.  I'm not sure how practical that is though.

-John
