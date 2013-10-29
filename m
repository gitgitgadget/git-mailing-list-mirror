From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: git-contacts questions
Date: Tue, 29 Oct 2013 15:17:57 +0100
Message-ID: <CAHGBnuNWtgH_aYxv0gX44AkGTRo6vsKdd4w1cViLGD9O9RLaNQ@mail.gmail.com>
References: <CAHGBnuPW3dtiL-=6BgvaOB4VvOAPyZhrVS3WGreVH_Pt81=wyg@mail.gmail.com>
	<CAMP44s1+npNnR8-exARL8kamQ81JwyLhhQnnkv6DvK8e3qOfHA@mail.gmail.com>
	<CAHGBnuP6nyTCGGNntvWVYAtxNX9xgt6=F3HheiEUcPU_9TP-1g@mail.gmail.com>
	<CAMP44s2KdHPH-UaSwdiJtT8WNo7uT9K_ArXwqHhCryPRsX1qjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 15:18:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbA7R-00017x-70
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 15:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756281Ab3J2OSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 10:18:00 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:35933 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab3J2OR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 10:17:59 -0400
Received: by mail-la0-f48.google.com with SMTP id ev20so6357915lab.7
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XTFHcj/7Dn0kXcP63u5Pod2DeqZtcy2/X8Wpfc16MVQ=;
        b=FK+/W/wKbbl0DBFN6Q/EdbB16pKheQUiWxaaPKzhqJuAUHjyMK17IytO5kp1fjj5ZN
         vEeMPXbW1r4jEHB4omQUhZaSROTKkFJY1JYejI8ZcgHK0P6osQhKwaFFeLG+ZoWmRvk9
         kQ6r+N387n8dji3MM5lOjK7XweoFHHFTs46rr76Xv7mwma/sVQ/2+AMtJVAby88H8Ejb
         MmQHR4p8FNmL4GL8baL1Y4VOA2m2oqOQ7wxJHTLp7RxtnC+rSO7SUmm0/yOa2OGfl9Wj
         Y4LWTVl1tcmrdokGVI/HfeRUSDvqcT8tBO+iMWCSvO8EdQmyxsU/qK0p2vioKCMQv52D
         9lNQ==
X-Received: by 10.112.159.166 with SMTP id xd6mr375335lbb.22.1383056277878;
 Tue, 29 Oct 2013 07:17:57 -0700 (PDT)
Received: by 10.114.201.134 with HTTP; Tue, 29 Oct 2013 07:17:57 -0700 (PDT)
In-Reply-To: <CAMP44s2KdHPH-UaSwdiJtT8WNo7uT9K_ArXwqHhCryPRsX1qjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236926>

On Tue, Oct 29, 2013 at 11:35 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Oct 29, 2013 at 3:12 AM, Sebastian Schuberth
> <sschuberth@gmail.com> wrote:
>> On Tue, Oct 29, 2013 at 9:57 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>
>>>> 1) Passing just "HEAD" as a committish like in "git contacts HEAD"
>>>> does not output anything for me, but using the SHA1 for HEAD does
>>>> neither. My HEAD commit does not add any files, but only modifies
>>>> previously existing files, so I would have expected some output. In
>>>> case it turns out to be correct to have no output in my case, could we
>>>> probably say that in some message to the user?
>>>
>>> It should be HEAD^, or -1, like with 'git format-patch'.
>>
>> Oh, that's pretty much unexpected. Wouldn't it be much more natural if
>> I had to specify the commit(s) that introduce(s) the changes that I
>> want others to look at?
>
> Yeah, that's exactly what you are doing. How do you tell 'git log' to
> show you certain changes?

I'm not sure what you're trying to point me at. It's clear that from
an implementation view you need to blame HEAD^ if you need to know
which poeple should review your changes in HEAD. But IMHO that is an
implementation detail that should be hidden from the user. Like I
said, I think it would be much more natural if it worked by specifying
the commits that *I* introduced, and then lists all people to contact
for a review.

>> $ git related b0783baacd20be7007df40cf274985c4863d63fb
>> C:/Program Files (x86)/Git/libexec/git-core/git-related:309:in
>> `popen': can't convert Array into String (TypeError)
>>         from C:/Program Files
>> (x86)/Git/libexec/git-core/git-related:309:in `from_rev_args'
>>         from C:/Program Files (x86)/Git/libexec/git-core/git-related:345
>
> Fixed.

Thanks, but now I'm getting

$ git related b0783baacd20be7007df40cf274985c4863d63fb
fatal: ambiguous argument '\^b0783baacd20be7007df40cf274985c4863d63fb': unknown
revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

I've checked of course that the commit exists.

-- 
Sebastian Schuberth
