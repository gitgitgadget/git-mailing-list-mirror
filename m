From: Stefan Beller <sbeller@google.com>
Subject: Re:
Date: Wed, 18 Mar 2015 14:06:22 -0700
Message-ID: <CAGZ79kZwmvZyye-3pHCbDgXhuQTQ8OsgtomK7BtR86qqU1koxQ@mail.gmail.com>
References: <CANSxx61FaNp5SBXJ8Y+pWn0eDcunmibKR5g8rttnWGdGwEMHCA@mail.gmail.com>
	<CAPc5daWNTm5qtd1HJdgQ+-yqUpeMaMmK_UuUiyhxCF6gD3K9dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alessandro Zanardi <pensierinmusica@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:06:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYLAg-0006xv-Cn
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 22:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbbCRVG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 17:06:27 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37098 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933637AbbCRVGX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 17:06:23 -0400
Received: by igcqo1 with SMTP id qo1so56777081igc.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 14:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=U52ah2/UQnbdOlcsd0R5/YvYDQKCOl21cK6iVeW7Cv4=;
        b=Ev3jYlM63t0gj5JlbuR3GVXpHoavQEn8xrfwKBztP0F/H4AEVaPfxUbRHYseXSmTtd
         NiYQRQUTA8dUbS+TB1zHeLYZmWC85qnG09zC0b7h89NcnRcgAtZH/FEV4ao9qdZnQ5Uc
         SPDSZkzRu/H9JZ82vukKyx7im9UFSim7B8Yuv95qQYuRkMhvVX/E8aZQyNmch48aoqeS
         kBLtOG7IjT+qLltimN2SykV6PBnXhcSyQKDPaoYbrNe2Xmzw72PIEXF0coPVCHrtuNbo
         lsZV6e4NZYh0v7FH9jlv0X0nRMbAFu2B0fLB4FOjs0nYgphcZqxQxpr/AeC1dmwco9WF
         /CHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=U52ah2/UQnbdOlcsd0R5/YvYDQKCOl21cK6iVeW7Cv4=;
        b=iTChBIw/rRubY/vwuvnR+T8g3FHap6NPWf5D2Ep3Ve/d+V8Pkc/Bum8HyNwT9NN0M8
         mcZG0S4lafP4Vy7+bpILC4qF5q5djgsiUhl3ZUvIko9i7J9ie4Ussl/S5e1SSu6bmnLN
         6k6z47nBKEx+XRuyzWBKngZAeCBX90tt28S7EwcNGs0vMx8MI4qHS0qdFTWszNjJBpDd
         weUBisEILCeZZ0FlSdTyF6efPw7NwGwScyf1s2gQMpzaJKcf1SmiIhtCXQFLhRovEI51
         PJrDwniKu+a5DVffjncB88PQDQkrAiYCcHpnMv0EzpLDnAKdc3hGZlYTNUkHCda0b0kH
         DlRQ==
X-Gm-Message-State: ALoCoQkHPNrvM+jrwBP5u1ibi1zRCsPjBkR0VMZm50XNatASiQ9WU8elDOoVEJb3MuUbUZ3T+4Vg
X-Received: by 10.42.92.16 with SMTP id r16mr97087349icm.95.1426712783023;
 Wed, 18 Mar 2015 14:06:23 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Wed, 18 Mar 2015 14:06:22 -0700 (PDT)
In-Reply-To: <CAPc5daWNTm5qtd1HJdgQ+-yqUpeMaMmK_UuUiyhxCF6gD3K9dQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265757>

On Wed, Mar 18, 2015 at 1:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Wed, Mar 18, 2015 at 1:33 PM, Alessandro Zanardi
> <pensierinmusica@gmail.com> wrote:
>> Here are other sources describing the issue:
>>
>> http://stackoverflow.com/questions/21109672/git-ignoring-icon-files-because-of-icon-rule
>>
>> http://blog.bitfluent.com/post/173740409/ignoring-icon-in-gitignore
>>
>> Sorry to bother the Git development team with such a minor issue, I just
>> wanted to know if it's already been fixed.
>
> I do not ship your ~/.gitignore_global file as part of my software,
> so the problem is not mine to fix in the first place ;-)

Maybe this can be understood as a critique on the .gitignore format specifier
for paths. (Maybe not, I dunno)

So the `gitignore` script/executable which would generate your .gitignore file
for you introduced a bug to also ignore files in "Icons/...." when all you
wanted to have is ignoring the file "Icon\r\r"
(Mind that \r is an escape character to explain the meaning,
gitignore cannot understand it. Sometimes it also shows up as ^M^M
depending on operating system/editor used.)

But as you can see, there have been several attempts at fixing it right and
https://github.com/github/gitignore/pull/334 eventually got the right fix.
(it was merged 2012, which has been a while now), maybe
you'd want to use a new version of this gitignore script to
regenerate your gitignore?

>
> Where did you get that file from? We need to find whoever is
> responsible and notify them so that these users who are having
> the issue will be helped.

Given that this is part of https://github.com/github/gitignore
which is the official collection of .gitignore files from Github,
the company, we could ask Jeff or Michael if it is urgent.
The actual fix being merged 3 years ago makes me belief
it is not urgent though.

Thanks,
Stefan
