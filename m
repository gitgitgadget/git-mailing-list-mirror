From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/4] t3400 (rebase): don't set GIT_AUTHOR_{NAME,EMAIL}
Date: Fri, 10 May 2013 20:26:20 +0530
Message-ID: <CALkWK0nnEg=nyqVE2fGH57+b6h_2FAOZKGWkdL8ZN+H3s-BV9w@mail.gmail.com>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
 <1368196178-5807-2-git-send-email-artagnon@gmail.com> <CAPig+cSW39bnmKOeNDz0H5ZyNzPt3oCLnCUttaMJU9fGuKvJeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 10 16:57:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaokw-0008ET-RK
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757514Ab3EJO5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:57:05 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:43911 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757503Ab3EJO5E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:57:04 -0400
Received: by mail-ie0-f176.google.com with SMTP id at1so8118980iec.35
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=rp8IY4gNkzTyD5w6f08utTdS/YUcnU1Jo10mbukducg=;
        b=Q7OWNMq/ndfmoculFeJND7gyfoVd/5rM7JgbeoDsLjhH+Xshyy78Q6qgD/wWf3MTlQ
         +FTLuSH7N5sYu1qkDnXSAkLrwD5WrE+aBaS8mbc6gdFJA0OqjPh1nTMoGXrpIOUPQR9f
         dK3x+SEN6W4OrKI/5m97lf4raLnSUpNRONw1+kTqx+OwdIj932UeFTRgB5rNw3LHoF6Y
         Ych5/FN//BmmSMN4FFOJicgFU8yJ/oytoOjQaD8rtPw5x917qUted4qmhBeTUMpNosLH
         Rqk9H6edDUR3b1HouEU533IOzw5vbJFtrMbretmsB+vjaN+Usx8DAD56+hNWToo9CyXK
         B05w==
X-Received: by 10.50.3.38 with SMTP id 6mr2287511igz.44.1368197820864; Fri, 10
 May 2013 07:57:00 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 10 May 2013 07:56:20 -0700 (PDT)
In-Reply-To: <CAPig+cSW39bnmKOeNDz0H5ZyNzPt3oCLnCUttaMJU9fGuKvJeQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223860>

Eric Sunshine wrote:
> These values are intentionally bogus. Doesn't this change defeat the
> purpose of 43c2325 (am: use get_author_ident_from_commit instead of
> mailinfo when rebasing; 2010-06-16)?

Oh, oops.  I paid too little attention to this series.

Thanks for catching.
