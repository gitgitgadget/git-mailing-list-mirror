From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] test-lib: make test_expect_code a test command
Date: Fri, 1 Oct 2010 19:47:36 +0200
Message-ID: <AANLkTi=geGrRM6kaQ2HqCJBvQTP=rv6LL=N0EQ6zq3FK@mail.gmail.com>
References: <7vd3rtholo.fsf@alter.siamese.dyndns.org> <1285953391-29840-1-git-send-email-avarab@gmail.com>
 <AANLkTim1_Zfbrt4G_S2hj1zfF0VX-fM1AkwFyPp0B1qE@mail.gmail.com> <AANLkTimUe39Z1Ce2NbfsJUyXe0-mY_CcmMmgk+kO_1a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 19:48:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1jiF-0008UN-EX
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 19:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837Ab0JARr6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 13:47:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39046 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677Ab0JARr6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Oct 2010 13:47:58 -0400
Received: by iwn5 with SMTP id 5so4081246iwn.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 10:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=yFh97as6p1r/IGTuLQYTN6E/+wKSwAwtjSHER9lgPgM=;
        b=HHl0jHt5pSvYgZ4qk7rdEuMek20qNa2UqEn4peMEOa6WTpv83wrr23ylbEOBr2fvs4
         XHNRaF6TWyQ+ZRfbDh6VlMacF9AlmBKRYnpFXDasmrbksW5F4WXPoIMw5PNBrzJTNebG
         gIhv+DoKGY+Kb5nK4zxs9llmoAt4fYxUi4sMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gMfL0TZWFMYgJZe6skI3bYK9k12UGqNOIXBQO5+WTanHUwW1p7UvFIf3FHKk8Trwb9
         RB+gXyot2RLONiPFP975ZwV7FuR48OMyhwcT7wvXxM/dT96NDxFX4iNLsGwoZ4uvCOk8
         wH8JPel+I5i7kaU7ulE8gJUYAkM0z/YNe3944=
Received: by 10.231.174.84 with SMTP id s20mr5975137ibz.94.1285955277312; Fri,
 01 Oct 2010 10:47:57 -0700 (PDT)
Received: by 10.231.33.138 with HTTP; Fri, 1 Oct 2010 10:47:36 -0700 (PDT)
In-Reply-To: <AANLkTimUe39Z1Ce2NbfsJUyXe0-mY_CcmMmgk+kO_1a8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157768>

Heya,

On Fri, Oct 1, 2010 at 19:46, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> Since t0000-basic.sh is the sanity test for the test-lib.sh itself
> having at least some comparison of output is a good thing. It's a nic=
e
> sanity check in case something ends up changing it.
>
> It's easy to change it if we change the output, but at least we'll be
> testing for it explicitly.
>
>> Either case, wouldn't it at least be a good idea to get rid of the
>> parts after the # in the comparrison?
>
> I thought it was simplest to just compare the complete output.

Ok, sounds good :)

--=20
Cheers,

Sverre Rabbelier
