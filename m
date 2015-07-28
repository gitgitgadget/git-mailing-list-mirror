From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/6] Documentation/config: mention "now" and "never" for
 'expire' settings
Date: Tue, 28 Jul 2015 13:33:53 -0400
Message-ID: <CAPig+cTbTi5Uj_BFWBQ+rDc0=PhY1pu9Emr9TwTwPzGCeE5J2A@mail.gmail.com>
References: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com>
	<1437710457-38592-3-git-send-email-sunshine@sunshineco.com>
	<55B58C3B.7040200@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 28 19:34:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK8lK-0001iw-V5
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 19:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbbG1Rdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 13:33:55 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34944 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbbG1Rdy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 13:33:54 -0400
Received: by ykdu72 with SMTP id u72so101745056ykd.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=V/yWVbBLO27ijpOx01KJj9YBVdXyKCH1lpyvLhbP26k=;
        b=Ybuc5+2cYiFbAH1zAKaaNmAT9ZLIcMw2NKddnnM4djGBn6pzSwHMoir04hEHl7r+Tm
         r9pw0guHQE915634nUMLX1UZB++/Jl++QQJ5jEz3FcZV1rd0ivtYx4g3LZXBcx6I8X36
         IJgbKpsdyCDqGFEWNA85Q0oNVNoEr1A8vdGrcHC7/yWU6M5TN/Z5Y8OuZQkRGRvbZoEZ
         n27GCEvfthnetBifbxUrkcF/SIWgkgYnokl8lomaD1lP3pFQSm01y9Miy3RtknR82gWA
         JgEEcR/B8OPHEWg3yEZNy1lSwLN6IYhgc2bJPVX8CYcqu2dCHtt/0Qy1pMg1NlXxDvPe
         FY2g==
X-Received: by 10.170.233.10 with SMTP id z10mr37571776ykf.71.1438104833605;
 Tue, 28 Jul 2015 10:33:53 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 28 Jul 2015 10:33:53 -0700 (PDT)
In-Reply-To: <55B58C3B.7040200@alum.mit.edu>
X-Google-Sender-Auth: EFP-dK_ar88nTJp0ow6L-BWIaKE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274796>

[+cc:Paul Tan]

On Sun, Jul 26, 2015 at 9:41 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 07/23/2015 09:00 PM, Eric Sunshine wrote:
>> In addition to approxidate-style values ("2.months.ago", "yesterday"),
>> consumers of 'gc.*expire*' configuration variables also accept and
>> respect 'now'/'all' ("do it immediately") and 'never'/'false' ("suppress
>> entirely").
>>
>> Suggested-by: Michael Haggerty <mhagger@alum.mit.edu>
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>> ---
>>  gc.pruneExpire::
>>       When 'git gc' is run, it will call 'prune --expire 2.weeks.ago'.
>>       Override the grace period with this config variable.  The value
>> -     "now" may be used to disable this  grace period and always prune
>> -     unreachable objects immediately.
>> +     "now" may be used to disable this grace period and always prune
>> +     unreachable objects immediately; or "never" to suppress pruning.
>
> A semicolon should be used without a conjunction, and the parts of a
> sentence joined by a semicolon should be independent clauses. So this
> should probably be

I was just getting ready to re-roll this series[1] to address
Michael's comments[2] and noticed that the add-on patch 7/6 which I
sent later[3] seems to have been botched when Junio applied it to
'pu'. It's currently at 36598db (Documentation/git-tools: drop
references to defunct tools, 2015-07-24) in
es/doc-clean-outdated-tools and it appears that the --scissors option
didn't cut off the leading cruft from the email conversation, thus the
commit has the wrong "subject" plus a bunch of email conversation gunk
in the commit message which doesn't belong. I understand that Junio
uses a relatively bleeding-edge version of Git for his day-to-day work
and was wondering if this is possible fallout from the git-am rewrite
in C?

[1]: http://thread.gmane.org/gmane.comp.version-control.git/274537
[2]: http://article.gmane.org/gmane.comp.version-control.git/274647
[3]: http://article.gmane.org/gmane.comp.version-control.git/274602
