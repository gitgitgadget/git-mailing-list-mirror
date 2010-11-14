From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/4] t7004-tag.sh: re-arrange git tag comment for clarity
Date: Sun, 14 Nov 2010 18:57:03 +0100
Message-ID: <AANLkTik7E6B0oLnSjqw05NhhbSrz51k+O272iFjr1swk@mail.gmail.com>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
	<1289745857-16704-3-git-send-email-avarab@gmail.com>
	<20101114173241.GB26459@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 18:57:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHgpF-0005Wx-ER
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 18:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655Ab0KNR5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 12:57:08 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52461 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756487Ab0KNR5H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Nov 2010 12:57:07 -0500
Received: by fxm6 with SMTP id 6so1265554fxm.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 09:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zLhHJTjOvtkmpYbwlbxulSKptwf44ENm2e5q3xghSQA=;
        b=Z+kURqbVyJ03nfb34LEaQHA6AxjqQXGx8wNJ9Q3IckuAjQnC24Qm75M7oO633OKFzi
         vzt4+7iJk+pUK7yLNRV6wED4+ZufK825TY3ZGGh9/pKAcVjg5+54fXEB/7QmoHlKmLhO
         z6j75u9Sfg9LwJHIrYlefPfKCHEFRYgeRYPO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HQYcIBauTTbqZc8s39TzuzvL6X0h8LGqpMcuyYEflOAxOySYu+VuHwr0GkH4WArGs7
         GfBUCct9jNK/+dpQqRls5JCfAhx17IfdF+EtIIW3J/tpAY8IqxHua8/Mnz5jW0B/QPS+
         8CzOlIftFRlxMNkO9rhgrHMzWyUiqrz9D+xC0=
Received: by 10.223.101.131 with SMTP id c3mr3887738fao.95.1289757423424; Sun,
 14 Nov 2010 09:57:03 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Sun, 14 Nov 2010 09:57:03 -0800 (PST)
In-Reply-To: <20101114173241.GB26459@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161429>

On Sun, Nov 14, 2010 at 18:32, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 I used ! instead of test_must_fail so that
>> the GIT_EDITOR variable was only used in this command invocation,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GIT_EDITOR=3Dc=
at &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0export GIT_EDI=
TOR &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail=
 ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0)
>
> ?
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 and
>> because the surrounding tests use this style.
>
> Oh, okay. =C2=A0I had the test_must_fail version sitting in my local =
tree
> as part of the unsent part of the &&-chaining series
> http://thread.gmane.org/gmane.comp.version-control.git/157903/focus=3D=
160419
>
> I am happy to see this fixed sooner.

Better to fix it up later IMO in something like your series. One
surgery at a time.

> [...]
>> +test_expect_success \
>> + =C2=A0 =C2=A0 'message in editor has initial comment: first line' =
'
>> =C2=A0 =C2=A0 =C2=A0 # check the first line --- should be empty
>> - =C2=A0 =C2=A0 first=3D$(sed -e 1q <actual) &&
>> - =C2=A0 =C2=A0 test -z "$first" &&
>> + =C2=A0 =C2=A0 echo >first.expect &&
>> + =C2=A0 =C2=A0 sed -e 1q <actual >first.actual &&
>> + =C2=A0 =C2=A0 test_cmp first.expect first.actual
>> +'
>> +
>> +test_expect_success \
>> + =C2=A0 =C2=A0 'message in editor has initial comment: remainder' '
>> =C2=A0 =C2=A0 =C2=A0 # remove commented lines from the remainder -- =
should be empty
>> - =C2=A0 =C2=A0 rest=3D$(sed -e 1d -e '/^#/d' <actual) &&
>> - =C2=A0 =C2=A0 test -z "$rest"
>> + =C2=A0 =C2=A0 >rest.expect
>> + =C2=A0 =C2=A0 sed -e 1d -e '/^#/d' <actual >rest.actual &&
>> + =C2=A0 =C2=A0 test_cmp rest.expect rest.actual
>> =C2=A0'
>
> Nice. =C2=A0Note that you've changed the semantics of the test here
> (probably for the better): the $() backquoting operator strips
> trailing newlines, while your sed expression does not.
>
> I assume you've run the tests and made sure they still pass.

Yeah, I've been running all these (also the others in the series) for
months on several different platforms with different options. They all
work.

> For what it's worth,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
