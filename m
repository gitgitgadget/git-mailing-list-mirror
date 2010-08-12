From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 9/9] commit: suppress status summary when no changes 
	staged
Date: Thu, 12 Aug 2010 00:05:25 +0000
Message-ID: <AANLkTikVyWjTmRssQyBfRVY=PLguTgHHA+_YdsmsMwP3@mail.gmail.com>
References: <20100725005443.GA18370@burratino>
	<20100725010230.GI18420@burratino>
	<201008110911.40133.trast@student.ethz.ch>
	<20100811073028.GA5450@burratino>
	<AANLkTi=DPu+roNsuWZARkK=cmKhcqMx=CDyiv6cf7tof@mail.gmail.com>
	<20100811235742.GA18499@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 02:05:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjLIk-00060q-Af
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 02:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759460Ab0HLAFb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 20:05:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57358 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932870Ab0HLAF1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 20:05:27 -0400
Received: by fxm13 with SMTP id 13so517404fxm.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 17:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PspcyHvuWnyihLn6UxJN+cJkwBqQFXk7BeTSTxujGWI=;
        b=AFz4jhKvT+SaIhD58gpzlXniaebsIhXJs0h24xPN2qjAKwDmpGoClgr+OzBx41yhNn
         FozybXmmir4hl3VTv838EdhnEkjKOQfkJr3BdncoxHRjgnOK0VLJIlesNmt6PMgi8aSM
         NpbnFlOtiNA1ps3/sjZyOA86/SsUhC3zaf+xU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lC00193tZZp2LBy33CfWol3mjR8XOtlfEGv8w7LKLcrEPGlfrN3Z4WIlaMOF0qRsx1
         whV5bjqZFwqOIRrrmIfg4yWuwxBBNRubslxD6BvUvtUHrQeOJQURs+DhDgT+twaHRMJs
         hO1sDsSVnB3QnWW42Db/aidxHLkVi7VHWRzLY=
Received: by 10.223.124.145 with SMTP id u17mr20896146far.92.1281571525992; 
	Wed, 11 Aug 2010 17:05:25 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 11 Aug 2010 17:05:25 -0700 (PDT)
In-Reply-To: <20100811235742.GA18499@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153316>

On Wed, Aug 11, 2010 at 23:57, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Wed, Aug 11, 2010 at 07:30, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>
>>> -test_expect_success 'status' '
>>> +test_expect_failure 'status' '
>
> Oops. =C2=A0Did you see the follow-up patch?

No, I'm probably missing something. Move along now, nothing to see
here :)

>> Better to test_expect_success like my patch does and explicitly chec=
k
>> the output, otherwise that test will pass if any part of it fails,
>> e.g. if the checkout fails.
>>
>> Not likely, but it's more likely that the output will change again, =
in
>> which case the grep tests I did would start failing again.
>
> The wt-status output series ought have included a separate test for
> the new =E2=80=9Cgit commit --dry-run=E2=80=9D output. =C2=A0But this=
 is not what that test
> script is about, and I think including it there would have been
> confusing.

Sounds like you got this covered, that's good enough for me.

> Sorry for the breakage, and thanks for reporting it.

No problem.
