From: Jeenu V <jeenuv@gmail.com>
Subject: Re: Git reset -p on working tree
Date: Tue, 23 Nov 2010 16:02:43 +0530
Message-ID: <AANLkTindHnjeXEGbKWiQkWgoUBwqZbdx71sQwNr_gFp0@mail.gmail.com>
References: <AANLkTimc=Dt9YSu=J=7C-f1hZ9UODU7VHu6oD8dmFX3N@mail.gmail.com>
 <AANLkTimP9zr=wQDYeBxtvYCE1mZ1aHXQ_nLOxGFfR9YD@mail.gmail.com> <AANLkTimQ644C-dEoJTj8bNd9y+YzpMez7D1KLZFNEe7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 11:33:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKqBf-0002Tv-GY
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 11:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718Ab0KWKdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 05:33:17 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56190 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021Ab0KWKdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 05:33:16 -0500
Received: by ewy5 with SMTP id 5so2314767ewy.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 02:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=oSL0rlBg+HJxlpy945fCvvEB9f11qfrGlxgkzVq5254=;
        b=KcFRTmnxdy+QSjSXp6/41+WU0knSdCKz2z+Ut3w94SiXj0WBgDJLz9nn3wiQCaW2Ms
         SYbB3XRymmloh7gTfWxMHRkTiqTNYx2Q/z+lKhFrNbcXk/ccvAnRV+QzhjtPFTAxRPhm
         py1duEC+fiVDyrYirrPcrBuRgqvOfw1BjsAEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=RAq87tHxrz5O2Qh00GtdH7kiWQRJSpPMjLRhDrnBCcMjiSfix3iK6nb2zvmFYQ30QO
         dQJnbZWwzuBZQvOoSXDp7uFDWHt3Bu5Um6HdB/ZmUw7ioNmkszOI1oGksCs6e8Z2tbZ3
         /s49D4kQaAk1ml2ygjxovdNfss30vvLJKNfI8=
Received: by 10.216.21.9 with SMTP id q9mr869460weq.3.1290508394505; Tue, 23
 Nov 2010 02:33:14 -0800 (PST)
Received: by 10.216.10.209 with HTTP; Tue, 23 Nov 2010 02:32:43 -0800 (PST)
In-Reply-To: <AANLkTimQ644C-dEoJTj8bNd9y+YzpMez7D1KLZFNEe7c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161940>

On Tue, Nov 23, 2010 at 3:56 PM, Jeenu V <jeenuv@gmail.com> wrote:
> On Tue, Nov 23, 2010 at 2:50 PM, knittl <knittl89@googlemail.com> wrote:
>>> Right now I do this with vimdiff, by applying 'git diff' in reverse.
>>> Wish reset supports -p on working tree operations as well because the
>>> -p framework (of add, and reset) feels good to use.
>>
>>
>> there's `git checkout -p` to selectively remove changes from your working tree.
>> (also `git stash -p` to selectively stash changes temporarily)
>
> Surprised to know that checkout and stash supports it! Thanks a lot
> for pointing out.

I think Git could suggest 'checkout -p' and/or 'stash -p' when user
tries to use -p with --{hard,soft,mixed} with reset command (in
addition to mentioning that they're incompatible), since relatively
new users are used to 'reset' than other commands to reset their
working trees.

-- 
Jeenu
