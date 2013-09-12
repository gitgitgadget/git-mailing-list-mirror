From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC] Developer's Certificate of Origin: default to COPYING
Date: Thu, 12 Sep 2013 16:25:03 -0700
Message-ID: <CA+55aFzNUr8-LQ1JqCBboFktmJRB1ctxP3=huOt5H=GQRLFbow@mail.gmail.com>
References: <1379023862-29953-1-git-send-email-rhansen@bbn.com>
	<xmqqy571n05d.fsf@gitster.dls.corp.google.com>
	<CA+55aFyQZ8EiOg+CZy-KMaX0Hnkdmvq1+8b9p6uuMuHAUzYaAg@mail.gmail.com>
	<52324B1A.2030001@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 01:25:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKGG6-0008Dk-N0
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 01:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756250Ab3ILXZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 19:25:06 -0400
Received: from mail-vb0-f51.google.com ([209.85.212.51]:62382 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756112Ab3ILXZE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 19:25:04 -0400
Received: by mail-vb0-f51.google.com with SMTP id x16so389352vbf.38
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 16:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2Qbk3n+uxEmv44pn+qWjPn+BQr3kQmuNsEKI9dY3hbU=;
        b=OnoiomTHYSqFh2Ev5v2bWsa0JQEShyrrLsWLVfZNakdOazE6cYw9ArT4QWb4z3P2BB
         vIaHb/DBblMILACKYurafyCWKuP9Bwvkb6n/lXD6NfiL1BkJ32vCHWtu8z/jOtcx6qB9
         70L731TPFVxtdAzx5cupLepnU3MJkrCGFaRPRSFsi47ccRovw6Xd2mStXkASPFI/zqmy
         KJiwDXF59qqDP/IzXf7qoRIKlA1niPc1xueemGJGnNMUIoAwCy4Y8IGaD/WMPMqMr7Ld
         Znp+FYvqEpT3sJenTFS89HWyDt99jyKvLmw+wE3y+wPI9Ie8b5mFpyVKg7McLqmYrRFu
         HnDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2Qbk3n+uxEmv44pn+qWjPn+BQr3kQmuNsEKI9dY3hbU=;
        b=f9+E3Ya1ra051KNbCxH9IOmrpuwCrZtFl+u2RxA95tTnJ3l5cn8fzwI7rlnfjhQS1+
         7alLUJNxV/m8FDUj4XoZTwd72htmbAmELuticTb0WVcd2qb1MbxeZQNNh9obzLX+F1JM
         a2IYQrXpO5X9SAzM74OXtnrXbOl+NpKTt5V70=
X-Received: by 10.221.44.136 with SMTP id ug8mr8871253vcb.13.1379028303382;
 Thu, 12 Sep 2013 16:25:03 -0700 (PDT)
Received: by 10.220.3.137 with HTTP; Thu, 12 Sep 2013 16:25:03 -0700 (PDT)
In-Reply-To: <52324B1A.2030001@bbn.com>
X-Google-Sender-Auth: ZmgYx1cODei7mn-d-lxCQ_FtbzA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234713>

On Thu, Sep 12, 2013 at 4:15 PM, Richard Hansen <rhansen@bbn.com> wrote:
>
> Is it worthwhile to poke a lawyer about this as a precaution?  (If so,
> who?)  Or do we wait for a motivating event?

I can poke the lawyer that was originally involved. If people know
other lawyers, feel free to poke them too. Just ask them to be
realistic, not go into some kind of super-anal lawyer mode where they
go off on some "what if" thing.

Note that one issue is that this is kind of like a license change,
even if it's arguably just a clarification. I'd expect that a lawyer
who is so anal that they think this wording needs change would also
think that the DCO version number needs change and then spend half an
hour (and $500) talking about how this only affects new sign-offs and
how you'd want to make it very obvious how things have changed, Yadda
yadda.

IOW, my personal opinion is that if you get a lawyer that is _that_
interested in irrelevant details, you have much bigger problems than
this particular wording. Lawyers do tend to be particular about
wording, but in the end, they tend to also agree that intent matters.
At least the good ones who have a case. Once they start talking about
the "meaning of the word 'is'", you know they are just weaselwording
and don't actually have any real argument.

              Linus
