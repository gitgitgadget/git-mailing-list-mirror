From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: git-contacts questions
Date: Tue, 29 Oct 2013 04:35:49 -0600
Message-ID: <CAMP44s2KdHPH-UaSwdiJtT8WNo7uT9K_ArXwqHhCryPRsX1qjA@mail.gmail.com>
References: <CAHGBnuPW3dtiL-=6BgvaOB4VvOAPyZhrVS3WGreVH_Pt81=wyg@mail.gmail.com>
	<CAMP44s1+npNnR8-exARL8kamQ81JwyLhhQnnkv6DvK8e3qOfHA@mail.gmail.com>
	<CAHGBnuP6nyTCGGNntvWVYAtxNX9xgt6=F3HheiEUcPU_9TP-1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 11:36:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb6eZ-0000XL-2G
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 11:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab3J2Kfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 06:35:53 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:62291 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab3J2Kfv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 06:35:51 -0400
Received: by mail-lb0-f180.google.com with SMTP id y6so3814465lbh.39
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 03:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3NuQ7PHCqAyJjlIjD35NoMPNfxywK+XAx/rZwKXjvG4=;
        b=bK+nOhSycGShawH/TAwtjjUW7BNw9z7B1EJ6RAQQ5FXRMA3nNjrMluIuZSn3iJHzAw
         z6SdHqsYW8KT4/qAu1A3C4wn6iOW+6FiDTr4FwDM0HuNHZUC19JVXqcbmAakdbwmVw6E
         +N9y2opraoZdlAKevtX08vY830A6N8yGluBj3jX5HZemqrqopQvMh9orV5zU0q6lYfZN
         Z9KRv2mydfAJM0nGgOagqN+FuuRjbOJXZ+0f7mLr7kztEXwokZSuMVoy1NZLneHUoyX/
         /U+ZxFr/nbCmlHHKbYxNc3O+rrZL7SP91MCbiVtIHbYRTLMNqvMSzcGDQTlqkHtVqpQJ
         a4qQ==
X-Received: by 10.152.203.233 with SMTP id kt9mr4880591lac.29.1383042949647;
 Tue, 29 Oct 2013 03:35:49 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Tue, 29 Oct 2013 03:35:49 -0700 (PDT)
In-Reply-To: <CAHGBnuP6nyTCGGNntvWVYAtxNX9xgt6=F3HheiEUcPU_9TP-1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236920>

On Tue, Oct 29, 2013 at 3:12 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> On Tue, Oct 29, 2013 at 9:57 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>
>>> 1) Passing just "HEAD" as a committish like in "git contacts HEAD"
>>> does not output anything for me, but using the SHA1 for HEAD does
>>> neither. My HEAD commit does not add any files, but only modifies
>>> previously existing files, so I would have expected some output. In
>>> case it turns out to be correct to have no output in my case, could we
>>> probably say that in some message to the user?
>>
>> It should be HEAD^, or -1, like with 'git format-patch'.
>
> Oh, that's pretty much unexpected. Wouldn't it be much more natural if
> I had to specify the commit(s) that introduce(s) the changes that I
> want others to look at?

Yeah, that's exactly what you are doing. How do you tell 'git log' to
show you certain changes?

>> You can also try git-related instead[1].
>>
>> [1] https://github.com/felipec/git-related
>
> I just did very quickly (with Ruby 1.8.7) and I get:
>
> $ git related b0783baacd20be7007df40cf274985c4863d63fb
> C:/Program Files (x86)/Git/libexec/git-core/git-related:309:in
> `popen': can't convert Array into String (TypeError)
>         from C:/Program Files
> (x86)/Git/libexec/git-core/git-related:309:in `from_rev_args'
>         from C:/Program Files (x86)/Git/libexec/git-core/git-related:345

Fixed.

-- 
Felipe Contreras
