From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Stable ab/i18n branch
Date: Fri, 15 Oct 2010 04:54:58 +0000
Message-ID: <AANLkTikXnBGHv_TiRNvp35zzpQ5dHW4Y=NZ7a21N5Eho@mail.gmail.com>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
	<AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com>
	<20101014200027.GA18813@burratino>
	<AANLkTim-2V_XtWVLFbWS_A-0rFNmuDvtR58aanxKL-O2@mail.gmail.com>
	<20101014205413.GD28958@burratino>
	<AANLkTi=LEzQu5_EyJ_ncRmsHfufG=AnEv9+eTQuqh5W7@mail.gmail.com>
	<AANLkTin-s8EqssfuOeM6vAmBOFF=JrtgzS96hTSFKZ90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 06:55:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6cJz-0004RP-Ft
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 06:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287Ab0JOEzA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 00:55:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63038 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab0JOEzA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 00:55:00 -0400
Received: by fxm4 with SMTP id 4so212775fxm.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 21:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9bIgdp59sTFkmakZAO9Lsr7/eE6p2c7gbhfPx4BBRAo=;
        b=WkiPlaFcJpNX8I3JMQGhkN9YQzjgUyycdRd7kxy1qt1sbSTtscHVwWg/Be2fPPWgaH
         D9lUg9rt+sDc5kOO63lqyNazjTQEcVHQH3m0WJma3iR1DZqSbI7DbPTF1rbbGNmlUo2m
         cY7mhfabwGSZeKefdqUcy6iEO3+YHO5+SGMZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DeS3PmR+oEduMoAgnuxveTQ6LbRJVONg7e1ncTInq/72nQCZg1nAghGyjFNhaoPphg
         vr6tMdqxf1WMlfLPYYT3dJC5UQiUJi55aHtr9ZknHfQpRSoLVFjGo7xSAS6pB0WQYVuL
         eg92EAaGQLH6I4A5EmA/VoCriHO7UTAE53nsA=
Received: by 10.102.219.16 with SMTP id r16mr73789mug.19.1287118498856; Thu,
 14 Oct 2010 21:54:58 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Thu, 14 Oct 2010 21:54:58 -0700 (PDT)
In-Reply-To: <AANLkTin-s8EqssfuOeM6vAmBOFF=JrtgzS96hTSFKZ90@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159090>

On Thu, Oct 14, 2010 at 21:50, Jon Seymour <jon.seymour@gmail.com> wrot=
e:
> On Fri, Oct 15, 2010 at 8:18 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> On Thu, Oct 14, 2010 at 20:54, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> So what I've tried to do to make this acceptable for inclusion in co=
re
>> is to make this whole thing a no-op unless it's explicitly
>> requested.
>>
> I agree with Jonathan that there might be some value to clearly
> delineating the i18n infrastructure from the application of it to the
> rest of the code base.The i18n infrastructure should be, relatively
> speaking, less invasive than the application of it throughout the cod=
e
> base.
>
> It would be good for Junio (I presume) to have the option to integrat=
e
> the infrastructure in one hit, but allow the application of it to be
> deferred, perhaps on a subject-area by subject-area basis.

It already is pretty much separate internally. To get only the
infrastructure you pull the series and omit the "gettextize"
patches. There is some slight tangling up e.g. here:

    6da9243 gettext tests: skip lib-gettext.sh tests under GETTEXT_POIS=
ON
    234ddee gettextize: git-init basic messages
    b161357 gettextize: git-init "Initialized [...] repository" message
    3ad3f9f gettext tests: test if $VERSION exists before using it
    1f56190 gettext tests: add detection for is_IS.ISO-8859-1 locale
    5f24f25 gettext tests: test message re-encoding under Shell
    ec31cc6 gettext tests: test re-encoding with a UTF-8 msgid under Sh=
ell
    45e8a56 gettext tests: mark a test message as not needing translati=
on
    c9db9aa po/is.po: add Icelandic translation
    83beb97 gettext tests: test message re-encoding under C

Where the tests I'm adding depend on an earlier "gettextize"
patch. That can easily be split up if there's demand for it. But so
far nobody has asked so I haven't done it.
