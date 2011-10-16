From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 7/8] mergetools: use the correct tool for Beyond Compare 3
 on Windows
Date: Sun, 16 Oct 2011 12:11:27 +0200
Message-ID: <CAHGBnuPoV0-9ZY9MffB2KTxPyK0TQiPcyZg-bH9WYo7HCS+QKA@mail.gmail.com>
References: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
	<1318632815-29945-8-git-send-email-patthoyts@users.sourceforge.net>
	<7vobxix0pk.fsf@alter.siamese.dyndns.org>
	<4E996012.8090002@gmail.com>
	<7vty79vrdn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 12:11:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFNgr-0008HW-LB
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 12:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677Ab1JPKL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 06:11:29 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45201 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab1JPKL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 06:11:28 -0400
Received: by vws1 with SMTP id 1so1924383vws.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 03:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Z5/a/RgftGwtXRmDnt3gWa2oTk3464DOQkdhXJj1I24=;
        b=FT8NqFcmxVT4B+kVGo96L+5ecI/inBg7ULFafzPcf7QKTNBlPma38z6r4k66y8mV7g
         9Il4+sdA+ZyJy89qddB1lVe0SHUS5yDgpwfMjAlThnwwm9s0VrmGkv6RByB6Lgi9sDBy
         iUV4rkCpa4aobeLl0Tj0VOOW7jRFlhA1m5jbc=
Received: by 10.52.30.69 with SMTP id q5mr8437812vdh.110.1318759887583; Sun,
 16 Oct 2011 03:11:27 -0700 (PDT)
Received: by 10.220.188.69 with HTTP; Sun, 16 Oct 2011 03:11:27 -0700 (PDT)
In-Reply-To: <7vty79vrdn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183700>

On Sat, Oct 15, 2011 at 22:14, Junio C Hamano <gitster@pobox.com> wrote:

>>> Hmm, does this only apply to Windows, or are there other platforms on
>>> which BC3 supplies bcomp for the exact same reason? What I am trying to
>>
>> BC3 is only available for Linux and Windows, so it only applies to
>> Windows currently.
>
> Who asked anything about "currently"?

Heh, no one. But obviously I cannot predict the future, that's why I
explicitly said "currently".

Here's what I was meaning to say in more long-winded words: Although
BC3 only supports Linux and Windows currently, IMHO it is unlikely
that future support for other platforms will suffer from the same
issue as Windows and will require a different executable than
"bcompare". And even if it was the case, that could be fixed then. For
now the proposed patch covers all cases and works well, and although
your suggestion would be more generic, it's not necessary, and the
discussion about whether or not to use your more generic approach is
starting to outweigh the time that was required to write this patch as
well as the time that would be required for a future patch.

-- 
Sebastian Schuberth
