From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 10/25] gettextize: git-merge basic messages
Date: Fri, 3 Sep 2010 18:06:50 +0000
Message-ID: <AANLkTimCZwLg6KvQKc5bhTkLRP_FAYd3TsJbf-S02ug6@mail.gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
	<1283456446-22577-11-git-send-email-avarab@gmail.com>
	<20100902200940.GB2531@burratino>
	<AANLkTiksZykH4zDbdDReYYgJZk7gmZ_2g0v=9X_MP73p@mail.gmail.com>
	<20100902203711.GE2531@burratino>
	<AANLkTi=ZQAjA9SN1A3WDr-L2rFA6v-XH0mZAkhuUgdAg@mail.gmail.com>
	<20100902211339.GA2801@burratino>
	<AANLkTinvvZ9eVxQXafYBDfSe8ay11mFz4s1=mDozbs14@mail.gmail.com>
	<20100902230410.GA4850@burratino>
	<AANLkTimBbSz5TF5CBa0us5oLQ-t=S9HNdBSVifUUSiqt@mail.gmail.com>
	<20100903175142.GA2341@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 20:07:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrafO-000359-Gr
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 20:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757240Ab0ICSGx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 14:06:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38205 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757217Ab0ICSGw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 14:06:52 -0400
Received: by fxm13 with SMTP id 13so1341179fxm.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 11:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S7s2jMPL0rdtzNzhqVVKpGTMoLeyGZ2HS1ROxTo0qQk=;
        b=QDDkI1gFWakNoyTd5ySj9fn/+SHxjE//e4nITsfJ6gPn8lTA2r4JcHrGd1dIfMiK/i
         zP6w7vTYahG23wMsUdUAURMRSkN0J1kRtF0F6jUY55U240d2ldc3niP1soWR4jhsrnKu
         p2JI8ZWw4Fr05AooyuVnNFLe0GKUY1HLpy+1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bFQwH/kj1Pu0LmOL7gbCf73ya5Io40FKtOu0PW4ZMZFG3urnqnSKWU+6Fj+n7Twi8I
         WxnVrLSgCX28y+CnoK4HhaV0pMfBltABcRXntOjbWtI1k+1dg7aNrayXvDSzeP7KcFZM
         8YaLbpbBoA4wxERbdA6KrJo7tRpVb0FtO6/lg=
Received: by 10.223.104.199 with SMTP id q7mr191259fao.6.1283537210657; Fri,
 03 Sep 2010 11:06:50 -0700 (PDT)
Received: by 10.223.120.14 with HTTP; Fri, 3 Sep 2010 11:06:50 -0700 (PDT)
In-Reply-To: <20100903175142.GA2341@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155256>

On Fri, Sep 3, 2010 at 17:51, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Those issues might be a bit hard, but I still can't really see how
>> managing these files outside of git.git would make things easier.
>
> The translationproject.org thing was a red herring. =C2=A0As you noti=
ced,
> the relevant thing is "outside of git.git".
>
> So imagine there is a git-translations.git project, perhaps. =C2=A0My
> only point was that versioning of translations and versioning of
> code can beneficially (in my opinion) be decoupled: with time,
> the translations for even _old_ versions of git improve, too.
>
>> maybe we should just use
>> msgmerge with --no-location.
>
> That would partially alleviate my concerns, and I think we might be
> able to get the --add-location output back in actual checkouts with
> a "smudge" filter.

After looking at this all closer I found that these line messages
really aren't that important to gettext's operation. So I'm in the
process of removing them from the ab/i18n series.

I documented the new process:
http://github.com/avar/git/raw/ab/i18n/po/README

>> But I'd like to coordinate things on this mailing list
> [...]
>> without some external service being mandatory.
>
> No objection here. :)
>
> Of course, what is convenient for translators and maintainers (i.e.,
> not me) takes precedence anyway; I am just throwing out ideas.
>
> Thanks for your thoughtfulness.

Sure, thanks for consistently commenting on all of this. It's great to
get feedback like this.
