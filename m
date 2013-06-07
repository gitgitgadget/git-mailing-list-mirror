From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] completion: add deprecated __git_complete_file ()
Date: Sat, 8 Jun 2013 00:59:54 +0530
Message-ID: <CALkWK0mvsQC4fbfnd+Kbk6q6qRCQGgGxQ89=D4O1+EKfXgw34A@mail.gmail.com>
References: <1370632168-25298-1-git-send-email-artagnon@gmail.com> <CAMP44s0_YkZeC_Xrd1XUo=4=yJDy=8wQKYe34uybhXVqi9bd9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:30:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul2Mx-0008HO-MR
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639Ab3FGTaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 15:30:35 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36743 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264Ab3FGTaf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 15:30:35 -0400
Received: by mail-ie0-f181.google.com with SMTP id x14so11140765ief.26
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 12:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oA5/4mazLz0qJVNG+7O0nSuJTAj7jP8Z0NcoYTuUNQI=;
        b=f32ZPo6gLyMIX6tg25OutSoE58I16jXPZZU2haoLmJy4w6GDHrhrR+APa3KSL+djqs
         2SOqCnu0FIscsNSz2F3Vssn2dulNwjSuESdFBJHaCYNNZB0dVzu1aGpHNzLyuXiIqsZj
         2jGtWLp5iGp7y6FnMUtCOixT09slGMfz+I78LWFrZdqEf5xq6/sJw8uN138VMm56aElx
         /zOiAP9LoiQa9bCopYcWutKHyPx6xZQOMZ1bSwQAQPJgELsEl0518VCaE0bhKrmtVu8N
         c1YltQgfIeq93bk2jMNnu4n3e6DgFs6RLYNUkiHINsXIXLKKsZQt9C3j4FMfePNXULu+
         ixhw==
X-Received: by 10.50.70.101 with SMTP id l5mr1898949igu.104.1370633434932;
 Fri, 07 Jun 2013 12:30:34 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 12:29:54 -0700 (PDT)
In-Reply-To: <CAMP44s0_YkZeC_Xrd1XUo=4=yJDy=8wQKYe34uybhXVqi9bd9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226683>

Felipe Contreras wrote:
> This is fine by me, but at some point we need to decide how we should
> prefix the functions that are supposed to be used by external scripts.

Yeah, I thought __ meant "internal" :/

> Also, maybe we should start adding '# TODO remove in v2.0' so we
> remember to do that in v2.0.

While at it, let's also clean up the deprecated zsh nonsense in
git-completion.bash.
