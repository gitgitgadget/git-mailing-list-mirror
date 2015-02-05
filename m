From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] Correction to git-p4 "exclude" change
Date: Thu, 5 Feb 2015 08:24:12 +0000
Message-ID: <CAE5ih7-Eo9uNCRQHO8bOGCuE0w8U_S4q+aYTNfttSHLQM6GVpA@mail.gmail.com>
References: <1422425284-5282-1-git-send-email-luke@diamand.org>
	<xmqqwq46fx59.fsf@gitster.dls.corp.google.com>
	<CAE5ih7_TJOQ=ttw03V3J9A=jtwUD-Emy-mSp0kNrYKkqMs30ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 09:24:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJHjW-0008Cz-Cp
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 09:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbbBEIYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 03:24:14 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]:56869 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbbBEIYN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 03:24:13 -0500
Received: by mail-oi0-f51.google.com with SMTP id x69so5377439oia.10
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 00:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=L+GekS1x8rfCQyG5Q/CUpd+4xVSwkr0ZOJ+9qOm/s4w=;
        b=Xx035g5oZ0PNYyyWFZgGt9ZwbavVslL3X5u9EC/jSg2sNHpa9Co0AWdpOWyz23p92y
         9WJPLax3RntGju1vcSy2XHNe5RCOQNaIToC9pK2PIhbJWeqSz9JCE6xfx3j/6oo9Vm1R
         GQqakohocdDrLtiTWan8csXr/RzguRc42jCeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=L+GekS1x8rfCQyG5Q/CUpd+4xVSwkr0ZOJ+9qOm/s4w=;
        b=j5m26aL61VQhGlp1uYBlzwuke/7DXZeUCLbZ9/8QiJQGnbC7ldNWDdraxXVKIGs1PE
         JQb2LaaosWPgjtZ7pwLNnzAyMd+lziyg18Icj4KfUUkt7L8mQw/hu0l2x8Y2tQ+yxECe
         g5dCA1TleuH7EfSKwUs9Nn5wOY2+MSXp/4jQDYn8e24RH/78/ZcyUSx9ZyKWk/bXpdcF
         I9EW835SbsyeDg2JPrkpo07jD4ExP46tXkX1E8/Qy+jFFECyIbBjWtQqoFQg0w2Ws7/C
         QMCImmCR3jvp9MkhZjNcf3Jtvz2UGbUEYAYAoFIPdZFG1i8oN2V6pIaacI96Rq2IIyZy
         oY3A==
X-Gm-Message-State: ALoCoQnBt188Fdym4ZG3tedYaOuv3W4ZIRdhlLJknsY/NYq3cfp3ejhG/zN3HfbBdBqa8tUjxW2y
X-Received: by 10.182.74.199 with SMTP id w7mr1605165obv.20.1423124652758;
 Thu, 05 Feb 2015 00:24:12 -0800 (PST)
Received: by 10.60.175.130 with HTTP; Thu, 5 Feb 2015 00:24:12 -0800 (PST)
In-Reply-To: <CAE5ih7_TJOQ=ttw03V3J9A=jtwUD-Emy-mSp0kNrYKkqMs30ng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263367>

(Resending as plain text).

I could be wrong about this, but my correction above doesn't seem to
be in 'next'. Does that mean (reading your last "what's cooking") that
the broken version is going to go out to 'master' soon?

Thanks,
Luke

On 5 February 2015 at 08:19, Luke Diamand <luke@diamand.org> wrote:
> I could be wrong about this, but my correction above doesn't seem to be in
> 'next'. Does that mean (reading your last "what's cooking") that the broken
> version is going to go out to 'master' soon?
>
> Thanks,
> Luke
>
>
> On 28 January 2015 at 20:49, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Luke Diamand <luke@diamand.org> writes:
>>
>> > My previous change for adding support for "exclude" to git-p4 "sync"
>> > was incorrect, missing out a comma, which stopped git-p4 from working.
>> > This change fixes that.
>> >
>> > I've also noticed that t9814-git-p4-rename.sh has stopped working; I'm
>> > going to follow up with a fix for that once I've worked out what's
>> > wrong with it. There's a small shell syntax problem (missing "esac")
>> > but after fixing that it still fails, so I'm not sure what's happening
>> > yet. It was discussed a while back.
>> >
>> > Luke Diamand (1):
>> >   git-p4: correct "exclude" change
>> >
>> >  git-p4.py | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Thanks.
>>
>> Will keep out of 'master' for now.  It may not be a bad idea to
>> squash this fix (and any futher ones if needed) into a single patch
>> when we rewind 'next' after 2.3 final is tagged.
>>
>
