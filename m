From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Mon, 24 Jun 2013 10:48:37 +0200
Message-ID: <CALKQrgda0h+FuxepbZfKjRob9kXwU=GPNCLT_OCSps_2ggAmbg@mail.gmail.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-4-git-send-email-gitster@pobox.com>
	<CALKQrgfAT9GhD-_tZHr9wRA6R6g7ttDWTsmUQXdWUhG-gwNBqQ@mail.gmail.com>
	<7vppvcc51j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 10:48:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur2S7-0006EF-Gj
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 10:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455Ab3FXIsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 04:48:43 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:57732 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab3FXIsm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 04:48:42 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Ur2S1-000Moe-9D
	for git@vger.kernel.org; Mon, 24 Jun 2013 10:48:41 +0200
Received: from mail-oa0-f52.google.com ([209.85.219.52])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Ur1LO-000C10-DH
	for git@vger.kernel.org; Mon, 24 Jun 2013 09:37:46 +0200
Received: by mail-oa0-f52.google.com with SMTP id g12so11376268oah.39
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 01:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+w+vKaJHFyDODgpeV2r0+EYghWI6jh6Ae9eln5JWB2Y=;
        b=D0eF0vLQQ6/L8eSJFoLJp6UsdooEKhiQIpam3McCrlt+W0dLheYa/CECkM5xE+FukU
         jNu18BHr90SyCYi2VV7mq8/GitRjSYG96PYkQfbLw8iYUD8yJX/pELsvhIcY4ne2f54Z
         uyrqEZ6EU6dhQVRv0Q7Hu+f7ur3hQEYY3QmqBJYXbEbq/TpkDJcJ0o4PnRnTeR6d5kLv
         Q/Tq9jNYyHZFi/+xIwv4cPOmMSAfJ6E72V71dVlxqCLyxO0Tkg/rZJfqSUVHjNAA0S96
         LOBsPFi0lrkKJtzFbC1W5UQeaNwPtzYAUKhZN4i5do2thze7Ms0YtLnCXeSqeCwT2Xgz
         DXMw==
X-Received: by 10.182.16.137 with SMTP id g9mr7612699obd.17.1372063717631;
 Mon, 24 Jun 2013 01:48:37 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Mon, 24 Jun 2013 01:48:37 -0700 (PDT)
In-Reply-To: <7vppvcc51j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228798>

On Mon, Jun 24, 2013 at 9:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>>> An earlier round of this change by mistake broke the safety for
>>> "simple" mode we have had since day 1 of that mode to make sure that
>>> the branch in the repository we update is set to be the one we fetch
>>> and integrate with, but it has been fixed.
>>
>> Shouldn't there be an acompanying test to demonstrate this mistake being fixed?
>
> An operation that has to expect failure due to safety was disabled
> by the broken version.  The squashed end result reverts that change
> to the test, to make sure we did not break the safety.

Ok, thanks.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
