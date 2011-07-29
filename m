From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] git-send-email: Do not send editor backup files in a directory
Date: Fri, 29 Jul 2011 12:17:10 +0530
Message-ID: <CALkWK0nowSnmN7gj6+_VDX81njev-q6WUgpaFouRHMzJCva9Rw@mail.gmail.com>
References: <865ddd502d9ba4a19c33c69039ecb70ea12c0692.1311319658.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 08:47:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmgrA-0005Di-At
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 08:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755040Ab1G2Grc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 02:47:32 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64535 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949Ab1G2Grb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 02:47:31 -0400
Received: by wyg8 with SMTP id 8so619668wyg.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 23:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JpqwOYFBfKUze4h1dcaWTnOEXAhh1jtkK5ZFwVbcQI4=;
        b=QzbgDTOeuC5udNWQ9tRE86LGuaIl7mvex58KK95w1dSjXQIgzz4rY+kSb924n4ALH9
         eRwBLqof5DVcG8M6wvvhleyZQJO7smpdUmZRQDCjkzFIcy/kdvxU8nA8WB5ilU0JhRNt
         CG/ZEAneyG9C3rAFM7l9vnZ2FwKTZXXtPrf7Y=
Received: by 10.227.55.66 with SMTP id t2mr1241023wbg.109.1311922050124; Thu,
 28 Jul 2011 23:47:30 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Thu, 28 Jul 2011 23:47:10 -0700 (PDT)
In-Reply-To: <865ddd502d9ba4a19c33c69039ecb70ea12c0692.1311319658.git.joe@perches.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178127>

Hi Joe,

Joe Perches writes
> [Subject: git-send-email: Do not send editor backup files in a directory]

I like this change.  I don't have to resort to my normal `git
send-email outgoing/*.patch` anymore.

Thanks.

-- Ram
