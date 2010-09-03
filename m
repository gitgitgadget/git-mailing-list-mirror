From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 10/25] gettextize: git-merge basic messages
Date: Fri, 3 Sep 2010 12:13:54 +0000
Message-ID: <AANLkTimBbSz5TF5CBa0us5oLQ-t=S9HNdBSVifUUSiqt@mail.gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
	<1283456446-22577-11-git-send-email-avarab@gmail.com>
	<20100902200940.GB2531@burratino>
	<AANLkTiksZykH4zDbdDReYYgJZk7gmZ_2g0v=9X_MP73p@mail.gmail.com>
	<20100902203711.GE2531@burratino>
	<AANLkTi=ZQAjA9SN1A3WDr-L2rFA6v-XH0mZAkhuUgdAg@mail.gmail.com>
	<20100902211339.GA2801@burratino>
	<AANLkTinvvZ9eVxQXafYBDfSe8ay11mFz4s1=mDozbs14@mail.gmail.com>
	<20100902230410.GA4850@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 14:14:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrVA5-0000zN-MQ
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 14:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757916Ab0ICMN4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 08:13:56 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33995 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756681Ab0ICMNz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 08:13:55 -0400
Received: by ywh1 with SMTP id 1so677972ywh.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 05:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LUyWhKPNwUQtTsJMoQRyAWhQ6XEYYSreQW9cSjpvvFY=;
        b=wtz/YfriWna9ZvCvnFNUaKXeuZbfx6EX4WPsJNM9EyWFYaLf608wbBFWgoDP2ChgGn
         bG5R5VpC3raf+NaNTlE/LR4eYyl8U+xwtrCjERGa9vp9WUSpHwB0ENlEruPRK7ZXIFGo
         jueTN2FWEmPO5Y+Zuy34R5gGorXcrNHr3UNYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SYjRLgfPa1kfPUqpNDXd9VyCxLgaGKvJrP2cRcRLzD3Fux56C1CS/9bItiNW7SzsJe
         4kcYV5POlhdR6HsWtBly06+0T4LqpgbjNxDlLhP1EYc/Cb8x2Jbru0dIgUk/uVuCc8sQ
         H/RJZkjgOXV+DGwwPs+UUO2HkHpqJkLae4K4k=
Received: by 10.151.106.9 with SMTP id i9mr163748ybm.264.1283516034519; Fri,
 03 Sep 2010 05:13:54 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 3 Sep 2010 05:13:54 -0700 (PDT)
In-Reply-To: <20100902230410.GA4850@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155245>

On Thu, Sep 2, 2010 at 23:04, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
>> I can't see why translations in the tree (in po/) should be any
>> trouble at all for us. What sort of issues do you see that the sed.g=
it
>> model might solve?
>
> Only two: log noise and the problem of what to base patches on.
>
> As you noticed while gettextizing (which is pretty much a one-time
> thing), it is not much fun to do work on strings that aren't even
> going to be used. =C2=A0So translators might want to work against "ne=
xt",
> or at least "master". =C2=A0How do the translations get back to "main=
t"?
> Someone has to backport them. =C2=A0What happens when we merge back t=
o
> "master"?
>
> Now multiply that by the number of translations. =C2=A0Making message=
s
> merge up nicely with git tools as they drift from topic to topic if
> translators want to keep both "maint" and "master" translated would
> require at least a nice custom merge driver.
>
> As we noticed before, the .po files are partially automatically
> generated anyway. =C2=A0Merging them as text makes about as much sens=
e
> as merging Word-generated .rtf files as text. =C2=A0To avoid wasting =
time,
> one wants to be able to work with their _content_.
>
> What is that content?
>
> It is a set of key/value pairs: for each string that appears in
> the codebase (maybe together with disambiguating translators' notes),
> what the translation is for it. =C2=A0Merging that between branches o=
f the
> code base is utterly trivial: take the union. =C2=A0Actually "merging=
" as
> an operation here does not make sense. =C2=A0It is not tied to the
> development history at all!
>
> Imagine v6.0.0 of git has message "foo". =C2=A0v6.0.1 changes it to "=
bar"
> because "foo" is not actually true yet, v6.1.0 changes it back to
> "foo". =C2=A0Imagine a linear development history. =C2=A0Do we want t=
ranslation
> diffs like this:
>
> =C2=A0commit v6.0.0
>
> =C2=A0+"foo" is "hello" in language X
>
> =C2=A0commit v6.0.1
>
> =C2=A0-"foo" is "hello" in language X
> =C2=A0+"bar" is "goodbye" in language X
>
> =C2=A0commit v6.1
>
> =C2=A0-"bar" is "goodbye" in language X
> =C2=A0+"foo" is "hello" in language X
>
> ? =C2=A0But what really happened is this:
>
> =C2=A0- add foo:hello to translation database
> =C2=A0- add bar:goodbye to translation database
>
> I have been thinking about how to write a merge driver for .po files
> (and avoid the tedious merge problems that e.g. the dpkg project runs
> into periodically) but the idea of avoiding that altogether is very
> appealing to me.

Those issues might be a bit hard, but I still can't really see how
managing these files outside of git.git would make things easier.

You'd still need to do the merging of e.g. master -> maint
translations, you'd just have to do them outside of git.git, so you
wouldn't be able to do that using the normal merge facilities.

Maybe we can have a custom msgmerge merge driver (someone posted one
in #git-devel, but I've misplaced it), or maybe we should just use
msgmerge with --no-location.

But I'd like to coordinate things on this mailing list, and in
git.git, without some external service being mandatory.
