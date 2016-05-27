From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [RFC/PATCH 2/2] log: add "--no-show-signature" command line option
Date: Fri, 27 May 2016 11:38:32 +0530
Message-ID: <CA+DCAeTnkTRnmscduio1-buKd2gNcaScYkLY7YfEQ+_Cm=Z28Q@mail.gmail.com>
References: <20160526130647.27001-1-mehul.jain2029@gmail.com>
	<20160526130647.27001-3-mehul.jain2029@gmail.com>
	<20160526163241.GC18210@sigill.intra.peff.net>
	<xmqqiny0wx8m.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Austin English <austinenglish@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 08:08:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Awn-0003A0-Q7
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 08:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbcE0GIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 02:08:34 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:36863 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034AbcE0GId (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 02:08:33 -0400
Received: by mail-qg0-f50.google.com with SMTP id q32so46896165qgq.3
        for <git@vger.kernel.org>; Thu, 26 May 2016 23:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=PFW+0AsEgW03lnYBhrDQJmc0yJT3m5V2JRa+/duGKe0=;
        b=hjrWCvbska1fSmIqlaB3ZuBJyQoBl5l5UquP5h5MejllLKaztPqOhITJfr9sbOOhM/
         jQoL6nD5GsdyuyBiiym1kTbH9KVMN6A5FIIlr0JRKS8GB17tHe4bjnFHzwocfq9rfr9X
         zWBrb6Pglnzq9t/ThxVkB7n3agZ3b8B/e/FOkewBLtw/gIr+LEhe8sX2zQOLOXr1Q+nC
         zTUNwZb4QQljhgyF0ts0OeLjD9t5xQUGUuHp/dMscjRHutpYha3k3GE+/VHfoTssOcwi
         MQXS6PMRv3TcVje9gpiDspyPvivgGe0b65pZhmiYAQ4UGRe+ydlsc6Sf/1b/CDn9m4SK
         wWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=PFW+0AsEgW03lnYBhrDQJmc0yJT3m5V2JRa+/duGKe0=;
        b=dkc5Q2WRICne14X8CgtxqiZHCx6S7xqDOzADV/mL+Tqao0OBVyiZ5Wxb5LnH5PpGaU
         Uph6BDIp8+ccGvzrii8nlydAsz4QAJHoz6RFtc893b2U1VpL7pC3R4DIcUJWTwJyMgrl
         l01O9q99E1zWxssL+vYtUYHUc8On0yxnrhefnGhUYihDE3k+9koRUgkuNj6X9CRyFr7o
         ZdYxUfOihrSKlNwJDwDTsG5tLiSEOcpGv61y/7X7+Seqe9sKLXLG9cWjtChiRy0KBY4s
         qlFO3o12CAXT7yR6HO8rB/Wd0i02CF2Pf6+GhHsrBupxuIbfvDpkdLutzDyNp6yK4t+p
         vYBA==
X-Gm-Message-State: ALyK8tJvxxGLE400o2ON3LGAZJpKQtdQhhdBbfawBJqLC5xaBhjgWCFNoBbPdnYz2b4+au4x7UiRE0xfL8s4mg==
X-Received: by 10.140.18.197 with SMTP id 63mr11654726qgf.18.1464329312408;
 Thu, 26 May 2016 23:08:32 -0700 (PDT)
Received: by 10.55.51.212 with HTTP; Thu, 26 May 2016 23:08:32 -0700 (PDT)
In-Reply-To: <xmqqiny0wx8m.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295734>

On Thu, May 26, 2016 at 10:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Thu, May 26, 2016 at 06:36:47PM +0530, Mehul Jain wrote:
>>
>>> If "log.showsignature=true", then there is no way to override it using
>>> command line switch.
>>>
>>> Teach "git log" and "git show" about "--no-show-signature" command line
>>> option.
>>
>> I think this is teaching all of the revision machinery about it (which
>> is a good thing).
>
> I agree that the proposed commit log message should be updated to
> say so.
>
> Because we do not want .showsignature configuration to affect
> rev-list nor format-patch, and we will not make "--show-sig" the
> default for them either.  From that point of view, there is no
> reason for them to know about the "--no-show-signature" option.
>
> The only reason why teaching the "--no-show-signature" option to
> these commands is a good idea is because it would help people who
> create an alias with "--show-sig" in early part of the command line,
> e.g.
>
>         [alias] fp = format-patch --show-signature
>
> by allowing them to countermand with --no-show-signature, i.e.
>
>         $ git fp --no-show-signature ...
>
> If we are updating the log message in the final submission of this
> patch, we'd want it to be clear that the presence of this option is
> not an excuse to introduce .showsignature that affects rev-list
> later to make sure we do not have to waste our time rejecting such a
> patch in the future.

Currently, with the [patch 1/2], only git-show, git-log, git-whatchanged
and git-reflog are able to learn about log.showsignature config variable.
But commands which will learn about "--no-show-signature" with
[patch 2/2] are notably a super-set of above mentioned commands.
Introduction of this option should not give an impression that we might
need log.showSignature for commands like git-format-patch etc, and
it will definitely be a wise decision to convey the same in the commit
message of this patch. I will do the necessary change.

Just out of curiosity, I was thinking that we might be able to teach
"--no-show-signature" option only to git-show, git-log, git-whatchanged
and git-reflog. To do this we can introduce a new member
"no_show_signature" in struct rev_info, and use this variable further
to modify the value of value of "rev.show_signature" after init_revision()
is called. This way we can selectively decide which commands should
learn about "--no-show-signature". This may be a bad idea because
we will have two variables in rev_info, for option --[no]-show-signature.
Any thoughts?

Thanks,
Mehul
