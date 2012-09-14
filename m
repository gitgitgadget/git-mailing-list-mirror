From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Revert diffstat back to English
Date: Fri, 14 Sep 2012 18:56:24 +0700
Message-ID: <CACsJy8DnrrB8Fp6xhL8reUgB8-KaQ4Hb9OrEKMupaH70mUqzOw@mail.gmail.com>
References: <20120913132847.GD4287@sigill.intra.peff.net> <1347545786-936-1-git-send-email-pclouds@gmail.com>
 <7vzk4t960y.fsf@alter.siamese.dyndns.org> <7va9wt9377.fsf@alter.siamese.dyndns.org>
 <20120913210111.GA16956@sigill.intra.peff.net> <7v627h7hny.fsf@alter.siamese.dyndns.org>
 <20120913212043.GB16968@sigill.intra.peff.net> <7vr4q562cg.fsf@alter.siamese.dyndns.org>
 <20120913213121.GA31426@sigill.intra.peff.net> <7vehm561eq.fsf@alter.siamese.dyndns.org>
 <20120914001117.GA31647@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 13:57:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCUW9-00087e-OQ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 13:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758441Ab2INL45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 07:56:57 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50003 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347Ab2INL4y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 07:56:54 -0400
Received: by iahk25 with SMTP id k25so2971358iah.19
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 04:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=60ED/lWbqMslwhItxW5BjJEonsGxmKLxw7V88grxZOk=;
        b=Sw0G3BsCA2VjacRubVZdmwyIMi9F+g09VGJYnC6VyzJdqbWwck2/pU3iZ7F5QXRVu0
         ael21yvAK3w/quokNuyizQuYCXgdb6jzHgPB2Rv215KYlw1vxMcpGldHz1Dp8oEAiArx
         x8cBXyQMbunQ5ED0fNtghwOumA7h87N/sSdzFOCZwPHs5lsGljpl7Nm6utGZvYqz+hm/
         rILVcnFqo57/lo3vIk1Au3mcIgIMRvlZ5mc0vcZALoaC39n9KXCKlTZJhUXWodNZL/Zt
         z1p2SuSU3IewJURj1q53/bH/kFV67e4ILhRqkFTi88M1iMg1WGtG3xcWXJn59+u55aud
         kdgg==
Received: by 10.50.13.200 with SMTP id j8mr2831733igc.48.1347623814410; Fri,
 14 Sep 2012 04:56:54 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Fri, 14 Sep 2012 04:56:24 -0700 (PDT)
In-Reply-To: <20120914001117.GA31647@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205482>

On Fri, Sep 14, 2012 at 7:11 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 13, 2012 at 02:47:09PM -0700, Junio C Hamano wrote:
>
>> > I agree that the line is not bright. I do not know if it is worthwhile
>> > or not. I think it will solve some practical problems, but it may also
>> > introduce others.  But basically having a per-repo LANG setting (which
>> > is what the projectlang you are talking about would do) also does not
>> > seem like a solution that people will use, because they will not get any
>> > localization benefit at all.
>> >
>> > So again, I'd rather err on the side of pushing those things that are
>> > near the line into the "do not translate" side, letting people use LANG
>> > to localize the rest, and accepting that occasionally people are going
>> > to accidentally show you output in a language you don't understand. But
>> > hopefully that keeps it to "occasionally" and not "every time you send
>> > out a patch".
>>
>> I am confused asto what you really want.  In a Klingon-only project,
>> I think it is perfectly fine to localize the diffstat summary line
>> to Klingon.  It is not machine readble, and it is not personal, but
>> it is to be shared with project members, who all speak Klingon.
>>
>> Pushing more things to "do not translate" side of the line means
>> robbing the benefit of i18n from people, no?
>
> Yes. But you cannot please both sides without creating a third category,
> as you noted. If you do not translate diffstat, then Klingon-only projects are
> unhappy. If you do translate, then projects run in LANG=C will either
> get public Klingon, or the project members will turn off all translation
> and lose all benefit of i18n.

I agree with Jeff on this. And "everything in $projectlang" is just
like "everything in C", the problem remains. Suppose Chinese becomes a
very popular language (if it has not been so), projects with dominant
Chinese people would prefer Chinese. But large enough projects will
involve non-Chinese people who prefer their native non-Chinese
language as UI.

I'm not pushing "do not translate" side. I just postpone it until a
proper approach is found (preferably by Klingon teams who are upset
about this "do not translate" patch). Supporting two non-C languages
at the same time could be done (not very elegantly) by forking a
process with the second language, which serves as gettext source for
first process via pipes.

The problem is drawing a line between team strings and local strings
without butchering git source code. We're going through sort of the
same process already, separating machine-readable strings and
translatable strings. Maybe we can learn something before deciding
whether to add the team string class.

> So for the time being, I would rather choose LANG=C as a lingua franca
> and err on the side of interoperability with other people and not
> translating. And then if and when somebody feels like putting the effort
> into doing i18n.projectlang by splitting out a third category, they are
> welcome to. I just do not see much point in doing i18n.projectlang any
> other way.
-- 
Duy
