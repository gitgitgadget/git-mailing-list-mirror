From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 10/25] gettextize: git-merge basic messages
Date: Thu, 2 Sep 2010 20:54:52 +0000
Message-ID: <AANLkTi=ZQAjA9SN1A3WDr-L2rFA6v-XH0mZAkhuUgdAg@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Sep 02 22:54:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrGoF-0000Zu-19
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 22:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757189Ab0IBUyy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 16:54:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61931 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757175Ab0IBUyx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 16:54:53 -0400
Received: by fxm13 with SMTP id 13so628983fxm.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7sF3fyuQbbMvMttU4IlJsbReaaiJCRQC/w4QyxFrtSg=;
        b=g/o5ZfYb1Dj6nmXtXTGoAAkS0iuElGI/5+JanXQnUmINImddGYAePqDH+vzQeJujk7
         /2cpIazDKl8Me8EJfMDTPNKAq6QxbiERTkSZHiY2VM0sC/0Tc8fpKC9Kh/fp79IMITzt
         W9wp7azPAzPQ9aeFv3FDjeoj0gILINp+LEe3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iRKcM0Wrn2ENJxPAEoCYVCE2/Ian7afZ2RpdmF1v3+/qxunw/YcqnAB96pZjXoj6aI
         YhuFYezL46REjktopF6v3k8I+0lAxp4+a6wIvVSfFPT/LZsHzw81qfZfpZVxroIQcWUK
         UPUkVE1hx8IdtWsY0gOTzeKl8N/PkgGNG6IQA=
Received: by 10.223.109.130 with SMTP id j2mr7810019fap.54.1283460892337; Thu,
 02 Sep 2010 13:54:52 -0700 (PDT)
Received: by 10.223.120.14 with HTTP; Thu, 2 Sep 2010 13:54:52 -0700 (PDT)
In-Reply-To: <20100902203711.GE2531@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155206>

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
>
> Also worth mentioning is that topics in "next" are not guaranteed to
> be included in the next release. =C2=A0The "next" branch has content
> matching the "jch" branch which I think has a better name: it is
> just the version of git that Junio uses for ordinary tasks (and
> hence topics in it cannot be completely broken for long).

Yeah, I was just hoping I could get away with it :)

Having whatever Junio is using these days as ab/i18n would be
convenient (since I've lost it), although I suppose I could start at
master and cherry-pick my way forward.

I'll also wait for comment from Junio about what he wants done with it
and what his plans are for it. But I can rebase it if need be.
