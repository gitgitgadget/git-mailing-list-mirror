From: Scott Chacon <schacon@gmail.com>
Subject: Re: Important articles on git-scm.com no more accessible
Date: Sun, 5 May 2013 10:20:44 +0200
Message-ID: <CAP2yMa+gqje9xjvcs95kKSA-Se7AyJ9zH5sRdpsZohEfkJZTcw@mail.gmail.com>
References: <20130501212839.c3c5df55da71c69fe11bf5f3@domain007.com>
 <20130501183801.GA2175@sigill.intra.peff.net> <20130501225751.2959d21bf6dbf38579192315@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git list <git@vger.kernel.org>
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Sun May 05 10:21:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYuC5-0008FK-2O
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 10:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485Ab3EEIVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 04:21:10 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:45361 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab3EEIVF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 04:21:05 -0400
Received: by mail-ie0-f176.google.com with SMTP id at1so1814425iec.35
        for <git@vger.kernel.org>; Sun, 05 May 2013 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+TXJ3v6EhkaSPb/hpiDVHBKhC0uF/bDP7a8vDqRWc74=;
        b=f0w98FWeexZgGxxRshaiX/W7u6QBDPUBE9YNk9U+d1PtheAwpXajjV3kD9u6PK++29
         BJ/PxdFxEKd/zF2Av3P47/4gt7SJRSlCFucRiR9tfP9jgN6fAUF+uO0RtTC2Q2aas/0G
         Z1i29h0brTkRp+/vzBfZxAutktz53ZsMw4AhZxdEyRlZMgIjyaIPUtgJxmnlWuj1HhS7
         DgZcvrI6kpMMSDtCs7jMZ8yMFyJj6Kk5krzlwj+YzWpXCvLjZAYdDlbMyP/EXiqWu5PR
         66G7kU/mLCV/7RGh+kQ3eEjipgs48eeLrh9FIbCTpVrFkCdNCe6ZCnbexn1TuHZCMJN+
         1Q/g==
X-Received: by 10.50.12.201 with SMTP id a9mr1391455igc.10.1367742064663; Sun,
 05 May 2013 01:21:04 -0700 (PDT)
Received: by 10.231.184.68 with HTTP; Sun, 5 May 2013 01:20:44 -0700 (PDT)
In-Reply-To: <20130501225751.2959d21bf6dbf38579192315@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223395>

Sorry about that - a recent PR that was merged changed the routes that
handled this for some reason.  I just added the historical routes back
and they all should work again.

Scott

On Wed, May 1, 2013 at 8:57 PM, Konstantin Khomoutov
<kostix+git@007spb.ru> wrote:
> On Wed, 1 May 2013 14:38:02 -0400
> Jeff King <peff@peff.net> wrote:
>
> [...]
>> > Recently I discovered that a number of useful articles which sort of
>> > accompanied the "Pro Git" book are now inaccessible (404), namely:
>> > "Smart HTTP Transport" [1], "Reset Demystified" [2], "Note to
>> > Self" [3] and "Git Loves the Environment" [4].  I wonder if this is
>> > a known problem and/or whom I could contact about this issue?
>> >
>> > 1. http://git-scm.com/2010/03/04/smart-http.html
>> > 2. http://git-scm.com/2011/07/11/reset.html
>> > 3. http://git-scm.com/2010/08/25/notes.html
>> > 4. http://git-scm.com/2010/04/11/environment.html
>>
>> I think those links were broken by the site reorganization about a
>> year ago. You can get to them at:
>>
>>   http://git-scm.com/blog/2010/03/04/smart-http.html
>
> Oh, I was about to respond that links I referred to are returned by
> Google search for their respective article titles (it did so
> yesterday).  So I went to verify this and just observed that Google
> started to return liks pointing to (supposedly) Scott Chacon's site,
> like
>
>   http://scottchacon.com/2011/07/11/reset.html
>
> for the "Reset demystified" article.  Hence I suppose Scott was
> just transferring those articles to their new home.
>
>> and so on. In general, problems with git-scm.com should be reported
>> at:
>>
>>   https://github.com/github/gitscm-next
>
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
