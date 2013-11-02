From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Sat, 2 Nov 2013 11:32:29 +0530
Message-ID: <CALkWK0k-8noAJbgzPx3NEx-ucUdZoS4VmqNCKjm3R_5eqFnR7w@mail.gmail.com>
References: <1383212774-5232-1-git-send-email-artagnon@gmail.com>
 <1383212774-5232-2-git-send-email-artagnon@gmail.com> <xmqq38nh411p.fsf@gitster.dls.corp.google.com>
 <CALkWK0nEMpVUkzafjDkVV-uaLTYzHYUTsZkmwRPkLFa=8NEkPA@mail.gmail.com> <xmqqli182mde.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 02 07:03:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcUJ1-0006dV-JQ
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 07:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453Ab3KBGDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Nov 2013 02:03:25 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:55797 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab3KBGDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Nov 2013 02:03:09 -0400
Received: by mail-ie0-f171.google.com with SMTP id tp5so9041929ieb.16
        for <git@vger.kernel.org>; Fri, 01 Nov 2013 23:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=t8rYtGH/844LlKre+9Mz1yvmTSJpxFetwmAS3DMuW4c=;
        b=KGuTKLvWIuJxfGVqeOwy9gCzWpqhy69RsJHkMNlogBBNL1kZu2hPfr/3oefeF3KJ0l
         jX2COLZRHOYtBhM6tfvedeFRGmHBDP/XgBGEteAeyLU9TFyXHkdnhajHxFqmSvR08iAx
         pRtWJZUtkB3tKSaXIZZdJ/kTTLNSqnJiCDukMST3zXXnhLYTn83SDYa7oZtv03iNoPkR
         4ikcoq/76NPobhET1TSA3yAUeqJHJ0uLOXsxZpu9VZseoySxLmyxHkgHfQFHg4qcUhp6
         jsHDMboqgWm0pPeBa6FQU0HLejzD0UCHJV6yzLEFfk6LBUbglwiibkTxPmQM7CGrwt2y
         2EFg==
X-Received: by 10.50.23.16 with SMTP id i16mr4822037igf.50.1383372189440; Fri,
 01 Nov 2013 23:03:09 -0700 (PDT)
Received: by 10.64.73.36 with HTTP; Fri, 1 Nov 2013 23:02:29 -0700 (PDT)
In-Reply-To: <xmqqli182mde.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237236>

Junio C Hamano wrote:
> This patch is about for-each-ref and your series does not seem to
> aim to unify it in any way with pretty-formats, so I would have
> expected an enhancement in line with the former, not the latter.

While I might never attempt a unification again, there's no harm in
getting the formats to resemble each other in part; it's likely that
users of f-e-r format will be familiar with pretty-formats.
