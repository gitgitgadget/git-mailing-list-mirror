From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFC PATCHv2 16/16] Add missing &&'s throughout the testsuite
Date: Sat, 25 Sep 2010 10:50:31 -0600
Message-ID: <AANLkTincF9qu62w1+WLcidxFAYb8iqf_Jw+ETwuy=rg9@mail.gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
	<1285366976-22216-17-git-send-email-newren@gmail.com>
	<AANLkTimfvo-nUDROSKWVFzB0HdAH4MfbH+oU4AP+pRqO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 18:52:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzXym-0001jM-OU
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 18:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747Ab0IYQud convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 12:50:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41804 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682Ab0IYQuc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 12:50:32 -0400
Received: by fxm3 with SMTP id 3so1209955fxm.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d3Ssyrof6jd58Ixei80MIwGPUsbolXXO9aA7h4d12ow=;
        b=WPTltP4iRKiR+cJzPD8FgpSKD58uoAHv7OzX7goWBg4xSht/ECPXr9WMEy6FVFkqiI
         jaNFeNiNOjypAkqD95+n8aW/WM49gsSfHQ4R6l0/ZeV+HQMuDV3Axig4Mw+iQNlBMQyG
         KErUzEZXP0vaLId08o09phzcfAAOTH09umIr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HBVg8E5mUuobVwzma0biYSx6R/+fa1ZRtucN6xYz4E+7KsB1yfvu52wY/yiw+S391D
         Nr4V+eBItNKBCaJhYqUcDSoraFJ/v+gjKtCyDBDtZDSytYfj+Km11RZoP3tPOB7L37pe
         DcDHYEKkG+/v2WuEfSV7SmiLmx88dh8uqEoE4=
Received: by 10.223.123.19 with SMTP id n19mr5047253far.75.1285433431472; Sat,
 25 Sep 2010 09:50:31 -0700 (PDT)
Received: by 10.223.119.209 with HTTP; Sat, 25 Sep 2010 09:50:31 -0700 (PDT)
In-Reply-To: <AANLkTimfvo-nUDROSKWVFzB0HdAH4MfbH+oU4AP+pRqO@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157166>

On Fri, Sep 24, 2010 at 5:18 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Sep 24, 2010 at 22:22, Elijah Newren <newren@gmail.com> wrote=
:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0(
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_CONFIG =
GIT_WORK_TREE GIT_CONFIG
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_CONFIG =
GIT_WORK_TREE GIT_CONFIG &&
>
> These are all bad, see c289c315c2bfcd5fde99f9e4dbb109f89e29dfce for
> why. If it's possible maybe we should have a new:
>
> =C2=A0 =C2=A0test_returns_whatever unset FOO &&
>
> To make this more self-documenting

Isn't that what test_might_fail does (even if documented as being only
for git commands)?

<snip>

Thanks for all the feedback!
