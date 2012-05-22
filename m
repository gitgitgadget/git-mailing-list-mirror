From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: Re: Question about submodules and absolute paths
Date: Tue, 22 May 2012 22:29:07 +0300
Message-ID: <CAOmKuSqRHMS+hvCXL4Ok6ReTPW-3xT9SunGeibjCCCgVk9SU6Q@mail.gmail.com>
References: <CAOmKuSoYP9fYORDy5twLpFh7SQ7rc6x2A=F8XjfKMqo-ErCauQ@mail.gmail.com>
	<CAOmKuSpqFrC7G4DbZu=uYDwvU6QqrJUi2aNBnSjy7_PXMMJpjQ@mail.gmail.com>
	<7vk4043wc5.fsf@alter.siamese.dyndns.org>
	<CAOmKuSrmxnHKaip2X87Y0Cp=XtLAtpAwUp71QhZ5od3gbDF2sg@mail.gmail.com>
	<70952A932255A2489522275A628B97C31348C70D@xmb-sjc-233.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Matt Seitz (matseitz)" <matseitz@cisco.com>
X-From: git-owner@vger.kernel.org Tue May 22 21:29:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWuli-0006HA-6h
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 21:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760288Ab2EVT3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 15:29:11 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58970 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760238Ab2EVT3I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 15:29:08 -0400
Received: by yhmm54 with SMTP id m54so5819894yhm.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FDEvbsAHSqWPLdXdrpF74mATYs18RR7kR/juNpCkypk=;
        b=rzKEii8YxHPNH/nD6bEaNO8CJCJHH7rU56udV+Yyhs0XHjwXyk7yqX6l2JAfqd+gG2
         Y400Lzro95tz8SeZBf9PAdRK5nk8XTbnNAPSbXG61YubI2f3r5Gd+S4ykliyXNWlVqAr
         BTu2Cfe8ItKeL4VJAaANGl8ZL27bqa7EkBZTDTkK1S5ctHsevLliLFha+aE27n63h6Ey
         2vhbZDqIrK5EcG//55vqgzf9QVkI5gYcIQgeid7SJSmPtUWRh19xYPMi9CfaekGHQTtX
         /f3Na6fY5/9WBx3FNALSNdU3JaMOZN775kzHTIQNOFjp0Fh9Ez1rYE7r7nKBt8Xs0Xxu
         OWNA==
Received: by 10.60.9.170 with SMTP id a10mr24002587oeb.14.1337714947906; Tue,
 22 May 2012 12:29:07 -0700 (PDT)
Received: by 10.182.72.65 with HTTP; Tue, 22 May 2012 12:29:07 -0700 (PDT)
In-Reply-To: <70952A932255A2489522275A628B97C31348C70D@xmb-sjc-233.amer.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198231>

Thanks, Matt.

Indeed this is a workaround, what I was thinking about to use. The
thing I wanted actually to discuss whether it worth to research
possibility of replacing these absolute paths with relative ones. At
least afaik, git repo clone is fully portable (movable) except for
submodules. So I wanted to ask community if this is an intended
behavior, or it may (and should?) be refined.

Best regards,
Alexey

On Tue, May 22, 2012 at 10:25 PM, Matt Seitz (matseitz)
<matseitz@cisco.com> wrote:
>> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
>> Behalf Of Alexey Pelykh
>>
>> Not on two machines, on single machine but with two OSes Windows +
> Linux +
>> shared 'work' partition :) So both Windows and Linux use same repo
> clone
>> that is stored on a 'work' partition. But due to those absolute paths,
> it
>> gives '/cygdrive/d/work' on windows and '/media/work' on linux. Thus I
>> have to keep 2 copies of each repository that uses submodules (and
> that is
>> very inconvenient :( )
>
> As a workaround, how about using Cygwin's mount table to mount "/media"
> to "d:/", or "/media/work" to "d:/work"?
>
> See:
> http://cygwin.com/cygwin-ug-net/using.html#mount-table
>
