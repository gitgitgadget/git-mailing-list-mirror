From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t/test-lib: print pretty msg when git isn't built
Date: Tue, 18 Sep 2012 13:37:57 +0530
Message-ID: <CALkWK0=JY3pTyyMAmFVnQatn6gd3eC7dxiBbTh0WmVwkdLTbHQ@mail.gmail.com>
References: <1347901579-5545-1-git-send-email-artagnon@gmail.com>
 <1347901579-5545-2-git-send-email-artagnon@gmail.com> <7v7grstlp9.fsf@alter.siamese.dyndns.org>
 <CALkWK0k9P9-K5R2Amipujq2DFvJTXy8T3ZyfFa31CcxeKSFL2g@mail.gmail.com>
 <7v627bq0gx.fsf@alter.siamese.dyndns.org> <CALkWK0kbeLtU-5_9QnmQKS1yO02SvCW3ERvami9bmCa0Vym8oQ@mail.gmail.com>
 <7vr4pzoj5a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:08:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDsr9-00083h-M7
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 10:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756337Ab2IRIIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 04:08:22 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:41891 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756310Ab2IRIIS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 04:08:18 -0400
Received: by qcro28 with SMTP id o28so5165662qcr.19
        for <git@vger.kernel.org>; Tue, 18 Sep 2012 01:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oMOwOjKsjB5NPKSaOg/LfEvK4kGZX+usTwkM/nj20Nk=;
        b=fvtVr1nxtzB35I+UKBNY6hOPOzqDy7vo3RQWJ3OL0/kdOngXPupOw45PX6rhJgJcWK
         Q3lGDXZJgFPxo2qMHxcVghWthKWqh/XwNzPZeYxipKzEnOb6AQ8MyjS0+YG6bGcpmc7H
         CMyyuTBqBsjZTPDYuKO6tEx2jjmWq3+qeyR9qAtYgGO+qATsA5yPycTYI6Q3l2+qCz2K
         yOMUfcZ8Fn53UHUgbO0bss1fp4FQpdpaarDdgrR7tM53BGPJ6+Uu8YJeiSE1qNB++aQX
         LfI2Ho8phm2ClwOSLYqi3zi9bP7m4BcD9UFZyBDpwVIQfp6oXxZOg8soLRwmvshxNbbt
         CErA==
Received: by 10.224.9.9 with SMTP id j9mr33429933qaj.32.1347955697617; Tue, 18
 Sep 2012 01:08:17 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Tue, 18 Sep 2012 01:07:57 -0700 (PDT)
In-Reply-To: <7vr4pzoj5a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205810>

Hi Junio,

Junio C Hamano wrote:
>> Junio C Hamano wrote:
>>> Yeah, but why change it so much?  Wouldn't writing
>>>
>>>         "$GIT_BUILD_DIR/git" >/dev/null
>>>         if test $? != 1
>>>         then
>>>                 : You haven't built git!
>>>         fi
>>>
>>> just like the original in 0000 be sufficient??
>>
>> Because that emits an ugly
>> ./test-lib.sh: 54: /home/artagnon/src/git/t/../git: not found
>
> Don't you deserve it? ;-)
>
> The full message would read
>
>     ./test-lib.sh: 54: /home/artagnon/src/git/t/../git: not found
>     error: you do not seem to have built git yet.
>
> which looks perfectly sensible to me.  It makes it clear where on
> the filesystem the test script expects your "git", which is an added
> benefit.

Fair enough- use your version then.  Let me know if you want me to
submit a revised patch.

Ram
