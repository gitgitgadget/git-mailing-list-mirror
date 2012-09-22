From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t/test-lib.sh: do not trust $SHELL
Date: Sat, 22 Sep 2012 10:24:15 +0530
Message-ID: <CALkWK0nTWQ3g75fN5wQLwgeW986vAzGdXajSGCY5SdpK8W=0aA@mail.gmail.com>
References: <505CCA55.6030609@gmail.com> <1348260766-25287-1-git-send-email-artagnon@gmail.com>
 <20120921205834.GC22977@sigill.intra.peff.net> <CALkWK0kRzN_yQZ1JqJogBs6Z1nLhofBijHzeWR5YfQYHOtpaBA@mail.gmail.com>
 <20120921211217.GA24134@sigill.intra.peff.net> <CALkWK0nLLEF7wnUhF0JUAZVP6GG3KHmuYSDZLPS7uGCZPfhV3w@mail.gmail.com>
 <m2k3vn9gyu.fsf@igel.home> <7vhaqr3t6j.fsf@alter.siamese.dyndns.org>
 <CALkWK0kxmD_HJtnV0ShSdpgSjoLQHtv0=b4s=utG52zFLb2Bjg@mail.gmail.com> <7vwqzm3bhf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Schwab <schwab@linux-m68k.org>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 06:54:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFHjp-0007Rf-T8
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 06:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331Ab2IVEyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 00:54:37 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:44326 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab2IVEyg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 00:54:36 -0400
Received: by qaas11 with SMTP id s11so1786231qaa.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 21:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=U5xJoIGD+/kIvd/hPTuo8DPFDQj3DjFQGf7qZuCWroA=;
        b=D1b2bsmrSEPdpk5KRmVtE++hv4K+f0a5NSDRMRBdxgwW1scf92XIEennQVHcZjFGpR
         Dn+PqjvWZCDZRJQUZbDUkM6WBShanmpqPEznX49Vnby4MF/MVyIDmVzaq3MNwtvVSezJ
         ipdv8M0FCy3AC2k/EBlpVrcztl5t2fPsHq2FOd5i26cbr2/m2zA7PL86rYEM9kyVVJn5
         ozKpr6xfBWGj3ePpW/MCkid0fl8xyk0WhJItMp837RxyOLDjoByOD0ESoDifgKdgKwMG
         raIl/xcR+6B7QHUHkUOr6vklxfMS2M8GIpk1OF74pHHPvGBpSp8PLyOGMdhNZaCUdKVq
         9Ztg==
Received: by 10.224.173.84 with SMTP id o20mr17275172qaz.3.1348289676184; Fri,
 21 Sep 2012 21:54:36 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Fri, 21 Sep 2012 21:54:15 -0700 (PDT)
In-Reply-To: <7vwqzm3bhf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206191>

Hi again,

On Sat, Sep 22, 2012 at 10:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>> The reference to ${SHELL-/bin/sh} in the test need to be updated to
>>> SHELL_PATH as Peff suggested in the other subthread.
>>
>> For that, the entire block needs to be moved down to come after `.
>> GIT_BUILD_DIR="$TEST_DIRECTORY"/..`.  Is this okay?
>
> Have you tested it with --tee (or valgrind) and does that work?

Yes, it works.

Ram
