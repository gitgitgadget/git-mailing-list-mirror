From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 10/25] gettextize: git-merge basic messages
Date: Fri, 3 Sep 2010 13:01:02 +0000
Message-ID: <AANLkTi=5MrU-JyeQ3UVNbVwzn-8FbstUXafgcQaLWXDB@mail.gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
	<1283456446-22577-11-git-send-email-avarab@gmail.com>
	<20100902200940.GB2531@burratino>
	<AANLkTiksZykH4zDbdDReYYgJZk7gmZ_2g0v=9X_MP73p@mail.gmail.com>
	<20100902203711.GE2531@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 15:01:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrVtJ-0006bM-2F
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 15:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320Ab0ICNBE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 09:01:04 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34198 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959Ab0ICNBD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 09:01:03 -0400
Received: by gyd8 with SMTP id 8so697163gyd.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 06:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aAvEODdLaUABLzuVECgCpV9O+UA3kf0Az9D7tvy9eEk=;
        b=UxHy+2RKE7AMfxuQuxEp970e5QJvR8MInEF6uVs2bH1fpV/cLMvh48L17B6hhOGjgo
         A75ql8Zy8dmZqXfJtz3pxT2Ng/jdHCMaKWmSGrCbFsIhTIyB2yPNWnSZQNggiycYJMxj
         gWSbBk5UCqteLWrUAqlBswC1QL4y+09jl1kRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k8ZQe8GNXflURzlskr1yXAT19mpGuE2oegIBZPUbH1AVKBlbkq+u/A0NeSvxAMTQJm
         h+vumA+6UXfY5xIA8uKgYJDwE5KmtzLkyFexq9J6dWg//R6zlQDIGlXENbzndumjrBmz
         9rkowezmRI84Ce1/WtlDCAHADXXcyUFKCjFQ0=
Received: by 10.150.197.2 with SMTP id u2mr113988ybf.75.1283518862352; Fri, 03
 Sep 2010 06:01:02 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 3 Sep 2010 06:01:02 -0700 (PDT)
In-Reply-To: <20100902203711.GE2531@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155246>

On Thu, Sep 2, 2010 at 20:37, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> It's on top of pu,
> [...]
>> But I was hoping that this would
>> make it into pu and after next gets released Any Day Now most of tho=
se
>> other tips in pu would be folded into next along with gettext, or at
>> least the merge conflicts wouldn't be too painful.
>
> Hmm. =C2=A0That really constrains people trying to merge this series.
>
> As SubmittingPatches explains:
>
> =C2=A0- In the exceptional case that a new feature depends on several=
 topics
> =C2=A0 not in 'master', start working on 'next' or 'pu' privately and=
 send
> =C2=A0 out patches for discussion. Before the final merge, you may ha=
ve to
> =C2=A0 wait until some of the dependent topics graduate to 'master', =
and
> =C2=A0 rebase your work.
>
> so this is fine for discussion, but for merging, having to pull in
> _all_ topics from pu (or all topics from next for that matter) for
> the patches to apply really is a problem.
>
> Both next and pu get rewound from time to time. =C2=A0They are not me=
ant
> to be a stable basis for patches.

Junio: I've started work to rebase this whole thing on master, when
I'm done the result should be able to replace the existing ab/i18n
series you have, i.e. it won't have the Conflicts your "Merge branch
'ab/i18n'" commits have.

Also, I'm going to add a special POISON mode to Git so that we can
check if changing these messages breaks anything in the test suite,
basically:

    make GETTEXT_POISON=3DYesPlease

Which enables this in gettext.h:

    #ifdef GETTEXT_POISON
    #define _(s) "GETTEXT POISON"
    #else
    #define _(s) gettext(s)
    #endif

Which in my preliminary tests makes a bunch of tests fail, most of it
is stuff like this in t0001-init.sh:

    #               grep "Initialized empty" again/out1 &&
    #               grep "Reinitialized existing" again/out2 &&
    #               >again/empty &&
    #               test_cmp again/empty again/err1 &&
    #               test_cmp again/empty again/err2

I.e. just something using the porcelain messages that are OK to
translate. I'm going to add a new NO_GETTEXT_POISON test prereq to all
of these, anything that remains would then indicate plumbing messages
that shouldn't be translated.

Unfortunately we *don't* have complete test coverage so these sort of
tests may miss something. But it should make this series a lot more
robust.
