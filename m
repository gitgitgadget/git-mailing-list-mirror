From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Tue, 11 Jun 2013 12:41:06 -0500
Message-ID: <CAMP44s02PqGFNmrGEcJVT6xcQHx8k4NYqJ_TtOTUEY8XHPj0BA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 19:41:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmSZG-0003Pf-3A
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 19:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361Ab3FKRlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 13:41:09 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34163 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab3FKRlH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 13:41:07 -0400
Received: by mail-lb0-f178.google.com with SMTP id y6so6259946lbh.9
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 10:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+bqRO4s+uERKhpGlIW/sEXQJLbnx6p+IibcBL1OIpl0=;
        b=DC3tjSf22lpT/YR18YIIbAcHCFsJwBAYqpkcx6O77izC8Y4FzyleANFbK0AWUKJKpX
         wGoVbe2NojCpj6Pzd352vADezHrBFAMCR/89hU1AlTCShElKDEaq55gZb1xM6DNfpSAS
         ALR9/3Pbnl6+X2MCVd2Zcp9M8F1yqebaSM3z8j8+x1+uMxd19FZ+1j4I0RmFUSQy6nAz
         og4Vfiht3Cu5WoQttpDNui8k73kr124Q33ksdAuyxwmgF6aT+BI7Y1Gu6Nmi2FCIW9fv
         HVUzb39m7hJB4CpIiayxwEgs22ww5Cq6G6gEO/fNlr+0MGrCHlWTBpSOVIednaEusOV9
         f57Q==
X-Received: by 10.112.157.226 with SMTP id wp2mr9173142lbb.65.1370972466201;
 Tue, 11 Jun 2013 10:41:06 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Tue, 11 Jun 2013 10:41:06 -0700 (PDT)
In-Reply-To: <7vtxl4blht.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227476>

On Tue, Jun 11, 2013 at 12:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>>  - There may be pieces of usefully reusable code buried in
>>>    builtin/*.o;
>>>
>>>  - By definition, any code (piece of data or function definition) in
>>>    builtin/*.o cannot be used in standalone binaries, because all of
>>>    builtin/*.o expect to link with git.o and expect their cmd_foo()
>>>    getting called from main in it;
>>>
>>>  - By moving the useful reusable pieces ont of builtin/*.o and
>>>    adding them to libgit.a, these pieces become usable from
>>>    standalone binaries as well.
>>
>> What if these reusable pieces should not be used by standalone binaries?
>
> I am not sure what you mean.  A piece is either reusable or not.

It can be reusable for A, but not for B. A being the 'git' binary, B
being other standalone binaries.

>> But this doesn't answer the question; what about code that is shared
>> between builtins, but cannot be used by standalone programs?
>
> Again, I do not know what you mean by "cannot" here.  My tentative
> answer to that question is "the eventual goal should be not to have
> any code in that class, and that is a reasonable goal we can achieve
> once we refactor what ought to be reusable out of builtin/*.o".
>
> What are the examples you have in mind, code that we want to forbid
> standalone from using?

init_copy_notes_for_rewrite(). Nothing outside the 'git' binary would
need that. If you disagree, show me an example.

-- 
Felipe Contreras
