From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Tue, 11 Jun 2013 14:01:15 -0500
Message-ID: <CAMP44s3SL7qs-Pmfz=kV-4U5OnPedK2RDLZDOyU-eq8WebLt+Q@mail.gmail.com>
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
	<CAMP44s02KaMaMUz4618n5RqVqVSXzr_D9rPS1uesy2XEdqnq5A@mail.gmail.com>
	<7vd2rsbjgr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 21:01:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmTon-00063J-VH
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 21:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492Ab3FKTBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 15:01:18 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:35218 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248Ab3FKTBR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 15:01:17 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so7055536lab.41
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 12:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4PQWyE0tyR9o57kvdJFM8lxRBt9Edh8f4UZ9VQdCi9g=;
        b=NMBKomRCk3Rrefb5PYKEsue4y3WAhRXewFzMgwI8Qhzlp413dBH7E5SPwhES9Edlu/
         sRRNp1i6Fy+kCZ4jyG5guNHgdlqqtXrzrWgb+qzwJSKwEMwKmbaUxa5amY2YMvK1lg++
         D/JsvIGi/y2sA7FYi8BV72YfP+DeYjzi5f8yZ/gj9wg/zWrIM05OZ0W1YplJRVA2M9pn
         nRCnQA3Ot0CKIXeKqBw9vuKuDaDkw5UmYDDZK3v916XLpWmIFuMFXNflcD8dw0qvD8aM
         qneLKIeifnp9Q3k15bZW+Xktr0Ck7KpyCx6+vIPaHWFJhp61zBQQ2qFu++/oF1BidAsa
         dKRA==
X-Received: by 10.152.7.74 with SMTP id h10mr7997973laa.83.1370977275812; Tue,
 11 Jun 2013 12:01:15 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Tue, 11 Jun 2013 12:01:15 -0700 (PDT)
In-Reply-To: <7vd2rsbjgr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227498>

On Tue, Jun 11, 2013 at 1:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Moreover, if you are going to argue that we shouldn't be closing the
>> door, then why not link ./builtin/*.o to libgit.a?
>
> Huh?  It does not make any sense.  builtin/*.o files have cmd_foo()
> that are expected to be called from git.c::main(), but libgit.a
> files are linked with no constraints whose main() they are linking
> with.


>> If you are
>> seriously considering the highly unlikely hypothetical standalone
>> git-filter-branch scenario, you should consider the even more likely
>> scenario where somebody needs to access code from ./builtin/*.o; that
>> scenario is not even hypothetical, we know it's happened multiple
>> times, and we know it's going to happen again.
>
> That is exactly why I said that builtin/*.o should be refactored to
> pick "does not have to be in builtin" bits, which will result in a
> better division of labor.  Reusable bits should live in the library,
> while a particular implementation of command remain in builtin/*
> that utilize the reusable bits.
>
> You still haven't justified why we have to _forbid_ any outside
> callers from calling copy_notes_for_rewrite().

Because only builtins _should_ use it. I asked you for an example, and
you said a hypothetical standalone 'git-filter-branch' might use it,
but you have not explained why it should be standalone, when it's
clear it should be a builtin.

If we assume your argument is valid for the hypothetical
'git-filter-branch', if that's the case, then it would be even more
reasonable to assume that there will be other standalone binaries that
would want to use all sort of functions from ./builtin/*.o. Let's put
an example: reset_index(). Some standalone program wants to use that
function. What do you we do?

The shortest route is to make it non-static, and add it to builtin.h.
But that would not be enough, we need the infrastructure prepared for
that; link libgit.a with ./builtin/*.o.

I don't think that's the way to go, but your line of argumentation
leads directly there; if we are worrying about anything that any
potential standalone program could want, then we should worry about
reset_index() not being easily accessible to them.

IMO we should be clear and say no; standalone programs should not
access copy_notes_for_rewrite(), that's for builtins. If we move all
the code that potential standalone programs could want to libgit.a, it
wouldn't be a library at all, and it would basically contain
everything.

-- 
Felipe Contreras
