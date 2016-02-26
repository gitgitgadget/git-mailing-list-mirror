From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [PATCH] Update diff-highlight
Date: Fri, 26 Feb 2016 09:41:41 +0000
Message-ID: <CAFY1edZ=zs-MyVFmejy32DUyvCjPeb9Kt9J0bFEqVOQMQgW_Og@mail.gmail.com>
References: <00000153072f5465-fd36f07c-e5e6-4a0f-8cf1-77be99424892-000000@eu-west-1.amazonses.com>
	<CAPig+cRRX4k8jR02YOGTGHUnbOmhHF0oMc-6aCOWuMOpi+BG0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Peter Dave Hello <hsu@peterdavehello.org>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 10:41:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZEuF-0002Rh-DZ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 10:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbcBZJlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 04:41:46 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33632 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbcBZJlm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 04:41:42 -0500
Received: by mail-ig0-f178.google.com with SMTP id y8so34101506igp.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 01:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=uY2lWgsmK1/TAIF/pWcYm962O5RRj2eS4RGNqu56SUg=;
        b=DCR3XkWjlxAVCzQ/+2mEsXqlWs/PPUaMSWVldGmgqlOJ5A5di7xkrjGfe9iCfSrshp
         LeQPgbRrQODEsNm2HpbEE5bx4XWbaaWmvDc7FE2h05TaNC565HELWCQz1uxeyuPectj4
         j5j/b58d0qlLusB34661EBQ/aqOlBg2DyDojUKQi0607TpfpajZNX0vNZhgQk6Z8PJdm
         bv70ImGSvnB/WQz8fp6JhNx68A64vKbaSftWDkfDlvfFZb6/yOZwis1xk7eczAPU7912
         ZXksRypJUkl1ZUyn3tbq+XS1KXMHeJiWLjK0W0EbJerBReSN5jKLnArgj6vakx+ZAHqb
         JCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=uY2lWgsmK1/TAIF/pWcYm962O5RRj2eS4RGNqu56SUg=;
        b=asLKaMdZ8YrIyzHd1cgh4yEFvBbgoJQyN06svhXfvUgKrpvecyiDE8Ua9j0uMXndPv
         WnYtgPyHell3DmUJ+UPbQb3XTQMzUB6DiUb3wo0WpFRq8rJYPlTrZcWXcrnfcpTtE9e7
         /FNUzD5t8+TFP5BG+5lnElvNqyOSe45egaASsTxA/O9kZorMhFkhghC9fISYsuNOa6Ro
         54bqjv8xOYIuSzrv4eriR/p6UwYXR62ccf7pgqzAssZjhF4xP/ouvUcxcNDRGZJieTQ7
         Go9neald8weheJ0CThiLoMTtxRk53hTd0FOUlsnQ/ecn78R1gy2jRuyW0S6JUUJTTy4t
         PyMw==
X-Gm-Message-State: AD7BkJKmklYIxK/qJ3hgzQ87QchyeVp8yJhCXVo0vNIMsFajQeXRpb9rjfi5XRAGRfngoiDqNPHeo9XiHxajLw==
X-Received: by 10.50.176.137 with SMTP id ci9mr2002367igc.53.1456479702028;
 Fri, 26 Feb 2016 01:41:42 -0800 (PST)
Received: by 10.79.93.129 with HTTP; Fri, 26 Feb 2016 01:41:41 -0800 (PST)
In-Reply-To: <CAPig+cRRX4k8jR02YOGTGHUnbOmhHF0oMc-6aCOWuMOpi+BG0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287561>

On 22 February 2016 at 04:49, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Feb 21, 2016 at 11:14 PM, Peter Dave Hello
> <hsu@peterdavehello.org> wrote:
>> From: Peter Dave Hello <peterdavehello@users.noreply.github.com>
>
> This "From:" line looks suspiciously incorrect. If anything, you'd
> probably want to drop the line altogether or use:
>
>     From: Peter Dave Hello <hsu@peterdavehello.org>

Peter's commit (https://github.com/git/git/commit/15415c6e) had an author of
'peterdavehello@users.noreply.github.com' (perhaps because the commit was
generated through GitHub's interface?), and submitGit added it as an in-body
'From: ' line because it differed from the address used to send the email
(hsu@peterdavehello.org - submitGit always uses the user's
primary-email-address-in-GitHub to send the email).

A 'noreply' address is obviously not wanted in this context though, so
I've updated
submitGit to disregard them when deciding whether or not to generate an in-body
'From: ' header: https://github.com/rtyley/submitgit/pull/29

Roberto
