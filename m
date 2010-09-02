From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 10/25] gettextize: git-merge basic messages
Date: Thu, 2 Sep 2010 22:45:22 +0000
Message-ID: <AANLkTinvvZ9eVxQXafYBDfSe8ay11mFz4s1=mDozbs14@mail.gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
	<1283456446-22577-11-git-send-email-avarab@gmail.com>
	<20100902200940.GB2531@burratino>
	<AANLkTiksZykH4zDbdDReYYgJZk7gmZ_2g0v=9X_MP73p@mail.gmail.com>
	<20100902203711.GE2531@burratino>
	<AANLkTi=ZQAjA9SN1A3WDr-L2rFA6v-XH0mZAkhuUgdAg@mail.gmail.com>
	<20100902211339.GA2801@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 00:45:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrIXC-0001ke-Kh
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 00:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656Ab0IBWpY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 18:45:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60998 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab0IBWpX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 18:45:23 -0400
Received: by iwn5 with SMTP id 5so914705iwn.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 15:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VKDKsRWh4iOuz/bKDrji2wj8/lAXWLmsjvpv9fKWH0o=;
        b=guUbuUUBJIqJ/nepXrJvmpuMCxeO84Jc/qZg09pLX6p+sR1YuOP9qjDYfYxRtHmTkj
         hu6hBrpWnedxCwEwD+z62aqXfZ7poLUkutvKKoaaak7+ueILTwf2w6/Mz9gxE56MekTb
         jsFyG3Nkc3xEc8VoJf+kYYRAYKcgv4wA9hACI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jBOgWK5K8fkWEOTdZ2m/MUyHOR2TJR1iIuTqj9Xn4RZzNuSzEeuPc1P3Oc3ggA+Vsf
         aT1UOoIq5PQoglyrrr8X49Urs0w3Sqs0twiVAYZUyFs0s4Xb3uD+qjA52SMIDQb6C6lM
         3UMKVz9yOqRpAn/nvS/jz9tYtb81j6EgP1R9w=
Received: by 10.231.11.11 with SMTP id r11mr11306177ibr.135.1283467522681;
 Thu, 02 Sep 2010 15:45:22 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 2 Sep 2010 15:45:22 -0700 (PDT)
In-Reply-To: <20100902211339.GA2801@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155218>

On Thu, Sep 2, 2010 at 21:13, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:

> Aside: maybe for translation (though not for gettextizing) the idea o=
f
> patches that get applied to the development tree is more trouble than
> it's worth. =C2=A0GNU sed and some similar projects do not include
> translations in the development tree but fetch them from
> translationproject.org as part of the "bootstrap" procedure when
> building a source tarball or binaries.
>
> See autoboot in git://git.sv.gnu.org/sed.git for example.

I'd prefer to be able to submit translations directly to git.git, and
build a localized git with "make" and no network access. Most programs
that use gettext do this, sed seems to be an exception, and actually
I've never seen anyone do it like that. Some maintain their
translations in some web interface, but I haven't seen a project that
doesn't commit them *at all*.

I can't see why translations in the tree (in po/) should be any
trouble at all for us. What sort of issues do you see that the sed.git
model might solve?
