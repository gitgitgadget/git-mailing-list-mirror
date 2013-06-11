From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Tue, 11 Jun 2013 13:06:27 -0500
Message-ID: <CAMP44s02KaMaMUz4618n5RqVqVSXzr_D9rPS1uesy2XEdqnq5A@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
	<CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
	<CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
	<20130609151235.GA22905@serenity.lan>
	<CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
	<51B4BBB7.8060807@lyx.org>
	<20130610214504.GG13333@sigill.intra.peff.net>
	<CAMP44s2-94LTu54oX1_m14tnE3KfwK+N=pPxgUSqGCgd51EA5A@mail.gmail.com>
	<20130610220627.GB28345@sigill.intra.peff.net>
	<7vk3m1efda.fsf@alter.siamese.dyndns.org>
	<7v8v2hedou.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HM0zFvkGmaHrX2Wq2JSzDNk8uwNSz3bNo12eWxDcL8A@mail.gmail.com>
	<7v4nd5ecmy.fsf@alter.siamese.dyndns.org>
	<7vwqq1ct0g.fsf@alter.siamese.dyndns.org>
	<CAMP44s0r96ByEs3+N1Qo+O18rOmT72rHk4zAEFAyFdU_DsQ8wA@mail.gmail.com>
	<7vtxl4blht.fsf@alter.siamese.dyndns.org>
	<CAMP44s02PqGFNmrGEcJVT6xcQHx8k4NYqJ_TtOTUEY8XHPj0BA@mail.gmail.com>
	<7vppvsbkc3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 20:06:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmSxl-0005EG-5j
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 20:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921Ab3FKSG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 14:06:29 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35969 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab3FKSG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 14:06:28 -0400
Received: by mail-lb0-f171.google.com with SMTP id 13so4492785lba.2
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=b7BFHai8gsrZuje1O6w11r6QuYYi0gQOwV4DK2z/Gjw=;
        b=xUSkCxOUUz9L45Li9YBw8NVl7TyDCEPrYera+43+9dtwpH63Hq+uX0/NYO+9gX5g+n
         Wc2jpxvwCqD0ynCoHn2PX1WIBV+mnzOy7If2xwY0DZfCXnJwVMF5JXzb/LZZ3VmmS1ti
         BZqtE8XOss2Xyclai+MC4eR2yJcCI8FBp+/BuNLcj4rQN5j5vHV7jZ9NXn7PxuQPOT+8
         C311hx2fIQTxP+X12y5XcbMTSkEtgM4arG1QovqX6vrkBTqb6FJV1BEhJoy5EXkJIAmg
         tiblSlT3KerwGxwFjYPH5aaWitOdiUL5j85C9+ykKC9yPDv4du+ZSu6BkCW017WbTWRU
         lFXA==
X-Received: by 10.152.7.74 with SMTP id h10mr7896036laa.83.1370973987117; Tue,
 11 Jun 2013 11:06:27 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Tue, 11 Jun 2013 11:06:27 -0700 (PDT)
In-Reply-To: <7vppvsbkc3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227479>

On Tue, Jun 11, 2013 at 12:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> What are the examples you have in mind, code that we want to forbid
>>> standalone from using?
>>
>> init_copy_notes_for_rewrite(). Nothing outside the 'git' binary would
>> need that. If you disagree, show me an example.
>
> "Nothing would need that", if you are talking about the current
> codebase, I would agree that nothing would link to it.
>
> But that is not a good justification for closing door to others that
> come later who may want to have a standalone that would want to use
> it.  Think about rewriting filter-branch.sh in C but not as a
> built-in, for example.

Why would anybody rewrite filter-branch, and not make it a builtin? It
should be a builtin. That's the whole point of builtins.

Moreover, if you are going to argue that we shouldn't be closing the
door, then why not link ./builtin/*.o to libgit.a? If you are
seriously considering the highly unlikely hypothetical standalone
git-filter-branch scenario, you should consider the even more likely
scenario where somebody needs to access code from ./builtin/*.o; that
scenario is not even hypothetical, we know it's happened multiple
times, and we know it's going to happen again.

-- 
Felipe Contreras
