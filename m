From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Tue, 11 Jun 2013 14:49:39 -0500
Message-ID: <CAMP44s0M6Jf_=bL+X06t7Vam+WypL_3JAt1odBkXCpMgqANDiQ@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
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
	<CAMP44s3SL7qs-Pmfz=kV-4U5OnPedK2RDLZDOyU-eq8WebLt+Q@mail.gmail.com>
	<7vobbca1sr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 21:49:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmUZe-0001in-6O
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 21:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886Ab3FKTtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 15:49:42 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:39027 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658Ab3FKTtl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 15:49:41 -0400
Received: by mail-lb0-f178.google.com with SMTP id y6so6381242lbh.9
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 12:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gC0WHei5GOjnaucQKNWK7zDAxCo9K1rlJQuEB62fAD4=;
        b=OI2lzq0+IubRwrjv1BjmeoJWmcQZ5nHn+kgHC7i4hLusciDKv78ZASdgCluh2jRevy
         cEYc/G8p9JsipzlT4Oq9FLqmpNPy+6+09RuDMVOVjte8lWKwDJ/0QdFqErt3WhT45fyr
         mr3vW0SXTGFUHvaacbsXGe9hXLS5Fl0J8uGoBpnzjxLG66UO1nMHA8PAaXmX/j0DjJtZ
         XYt4p3Trlm0L22CceYDceCHulOgZxXXKUhzeni0ExgRLqWH/VqFRAh6s12kFQ3fRecoD
         SBbs6FGSU0vmhf5/6HMt6GiNYnXu8+8IoJVgvQRp0gRlCNAw9wn7QdvJgB0TMQW8T/Q3
         Jqog==
X-Received: by 10.152.22.73 with SMTP id b9mr8178793laf.36.1370980179398; Tue,
 11 Jun 2013 12:49:39 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Tue, 11 Jun 2013 12:49:39 -0700 (PDT)
In-Reply-To: <7vobbca1sr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227506>

On Tue, Jun 11, 2013 at 2:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, Jun 11, 2013 at 1:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> Moreover, if you are going to argue that we shouldn't be closing the
>>>> door, then why not link ./builtin/*.o to libgit.a?
>>>
>>> Huh?  It does not make any sense.  builtin/*.o files have cmd_foo()
>>> that are expected to be called from git.c::main(), but libgit.a
>>> files are linked with no constraints whose main() they are linking
>>> with.
>> ...
>>> That is exactly why I said that builtin/*.o should be refactored to
>>> pick "does not have to be in builtin" bits, which will result in a
>>> better division of labor.  Reusable bits should live in the library,
>>> while a particular implementation of command remain in builtin/*
>>> that utilize the reusable bits.
>>>
>>> You still haven't justified why we have to _forbid_ any outside
>>> callers from calling copy_notes_for_rewrite().
>>
>> Because only builtins _should_ use it.
>
> And there is no justification behind that "_should_" claim; you are
> not making any technical argument to explain it.

The first argument of init_copy_notes_for_rewrite() is the name of the
builtin command. There hardly could be any more justification.

>> I asked you for an example, and
>> you said a hypothetical standalone 'git-filter-branch' might use it,
>
> Of course it has to be hypothetical; I already said with the current
> code no standalone does use it---it is not arranged to be doable so
> there is no user.  If you want to have examples of future possible
> callers, they have to be hypothetical---the future by definition
> hasn't happened.  But that does not mean hypothetical is impractical
> nor useless.

So? It's still hypothetical, which is what I said. What are you
complaining about? About the fact that I made a correct assessment?

> There are out-of-tree programs like cgit that will not be built-in
> but already link with libgit.a.  Moving things that can be used by
> outside people out of builtin/*.o to libgit.a would allow uses that
> you and I cannot imagine offhand.  I do not see a reason for us to
> forbid a filter-branch replacement out of tree as a standalone.

Yeah, I already ran that argument, and you conveniently chose to
escape the next logical conclusion that I already put forward:

--- a/Makefile
+++ b/Makefile
@@ -990,6 +990,8 @@ BUILTIN_OBJS += builtin/verify-pack.o
 BUILTIN_OBJS += builtin/verify-tag.o
 BUILTIN_OBJS += builtin/write-tree.o

+LIB_OBJS += $(BUILTIN_OBJS)
+
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =

I don't think that's the right direction.

> I do not see a point in continuing to discuss this (or any design
> level issues) with you.  You seem to go into a wrong direction to
> break the design of the overall system, not in a direction to
> improve anything.  I do not know, and at this point I do not care,
> if you are doing so deliberately to sabotage Git.  Just stop.

That's your opinion, and it's not shared by others (outside of the Git
project). If you were right and Git was moving in the right direction,
there would be no need for libgit2.

-- 
Felipe Contreras
