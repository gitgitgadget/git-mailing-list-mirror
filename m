From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Mon, 29 Apr 2013 15:14:12 -0500
Message-ID: <CAMP44s3ghzcfTthEEYZgr7ydJFUeA5xKyAxgR1JUYVtWG7f=qg@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<7va9ohhzsi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 22:14:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWuSp-00009v-6f
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 22:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759042Ab3D2UOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 16:14:15 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:52634 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757947Ab3D2UOO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 16:14:14 -0400
Received: by mail-lb0-f181.google.com with SMTP id 13so3969421lba.40
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 13:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=KVHCIKIVEOzeGPEhvps9zmWv7yaz7YwKd7lepNOsNNg=;
        b=HdhZ7sV4N9X31hAtTtyIRtsKrgrLmdm9D9OMwK2CxJ+pipdhKBbLqpUGkMjK1pPiHF
         GtesRLqCOD2gmiCN53QGh+A9ogiUlfSE92aKPMIzI2p8YbFKT/moEAmg/l4fTm9kQAWN
         tiY+DGtZ4ACWOlsfzGKcp+Y6Mt5z60ORmY45euIP1wNAcrMHHiqnLq0ReQ1ag4A+yBwe
         3LhTyiBFI/aIgpO+zCUmCf4Cvak/VcpbVfBqOEcoPuFi0r3fP9wUZzP0Xpc876K7Wa4/
         bxefpv++dihXGtWD678vozL/LiHOyiYBYT/sB7KGPc15mMZeXm7ewuI9OZCSkyDL8gs5
         qlQw==
X-Received: by 10.152.87.69 with SMTP id v5mr2439424laz.24.1367266452701; Mon,
 29 Apr 2013 13:14:12 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Mon, 29 Apr 2013 13:14:12 -0700 (PDT)
In-Reply-To: <7va9ohhzsi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222858>

On Mon, Apr 29, 2013 at 3:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
>> remove '~0', and we can remove 'HEAD', but we can't remove '{0}'?
>>
>> This patch allows 'HEAD@' to be the same as 'HEAD@{0}', and similarly with
>> 'master@'.
>>
>> So we can type '@' instead of 'HEAD@', or rather 'HEAD'. So now we can
>> use 'git show @~1', and all that goody goodness.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>
>> People have complained about the lack of a HEAD shortcut before, and some
>> proposals have been made, but I think this one is a clean trick in accordance
>> with our current syntax.
>
> Technically the notation would be only valid if you have a reflog on
> it, but if we must have such a notation, I think this may end up to
> be the least bad one.  I haven't thought things through, though, so
> won't stand behind it myself (i.e. when there are corner-case holes
> found later, I won't defend the notation myself), at least not yet.

But @ is not used just for reflogs, there's @{now}, @{-1}, @{upstream}.

-- 
Felipe Contreras
