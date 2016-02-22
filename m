From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: contrib/diff-highlight: stop hard-coding perl location
Date: Mon, 22 Feb 2016 02:13:23 -0500
Message-ID: <CAPig+cQp9H4K2D88bVxRRnwD_rY-8hROzVOp6aBCp9Y=Y6HwUA@mail.gmail.com>
References: <CA+boQ6YWWkudgwC7zn-3UPWqfkw+uJZgwcBWcGvJDcCUakjzHA@mail.gmail.com>
	<CAPig+cSE77JbD9CShrxnFsDLd9DrG9L15BSecERk_Qih9CMOig@mail.gmail.com>
	<CA+boQ6bCH35hu9GfQY_P5bNZCdJ8Knr8zQ+S41RGF0z-JamVgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Peter Dave Hello <hsu@peterdavehello.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 08:13:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXkgT-0006mj-57
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 08:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbcBVHNZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 02:13:25 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34822 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbcBVHNY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 02:13:24 -0500
Received: by mail-vk0-f51.google.com with SMTP id e6so121493720vkh.2
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 23:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=lDVPKjz8PjGy6x8w7P3uIsMOkmaE87FzyjI9ADFmToE=;
        b=DaGv0fsBI7cjT/wGNFXu6p9YW7I4q9Arzpiqc+UjyB/l2X/R5tIta35c77dA2rP+Kn
         Z/v4rRUYlHyK5kgCsgD7oOjPX4a0inJoiBrGFXASnThirvpYdevVfYJS8vtm82dd8u14
         y0AxABhJIQ9rHg0dAf5SJ4O03kExpc+zE1u0WqcIpFJsu40hiQto9v1iLd+CJx2Ee8YS
         84Ckm1hCKUrA2uf8ma48mGdBzKJs9rkl4o+AoD0CBlawMg0YIGtzPf6aHplarL69Y5/k
         0L+X0Mua+i5GjxcAyjyamHG/IzGLbseUPhCDvVNUIjfnJhC+H3p5jAv2ZCyl/yiomv1Q
         kIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lDVPKjz8PjGy6x8w7P3uIsMOkmaE87FzyjI9ADFmToE=;
        b=F2DZZi02I3BLjkvKPJRg2sTXeMOWObkr/zJKxwO9fsU94s4YSrtO4pM8Ib8K3OmmGK
         sbLopEVRwuCJ5lBl3jr80L/wwdli8TOqMUE/XojdZSR7IKDRwtcf5y+wngvH7BKmS2r2
         I5R0slO+oILqmUsW1A88BzpD+M0J1sj82tTiOEU3oeOL5VEIHTEOa1YGNEspCMNZwTe8
         ZVfIgZOhrtpOedzEbQFl+GB3mze0QX3xESMXc86Vg4a6ZfpqILpaekG/H0/iVd7YKwFT
         ebWIhWFmYACICsH5CKqCilrlhSUyiLsxrQryMI1SXCkuaSDo1bTBDxzvGEgtDMHHyBsS
         eDhw==
X-Gm-Message-State: AG10YOR6M1jBQ3IjXpgKKT/bmCOtnUEiMIBMNHt0K6cuE2bDWwQ48eZ9JRKXCBgr81uYHYh4VkCpfbwbh8680A==
X-Received: by 10.31.168.76 with SMTP id r73mr21980933vke.117.1456125203728;
 Sun, 21 Feb 2016 23:13:23 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 23:13:23 -0800 (PST)
In-Reply-To: <CA+boQ6bCH35hu9GfQY_P5bNZCdJ8Knr8zQ+S41RGF0z-JamVgw@mail.gmail.com>
X-Google-Sender-Auth: rqP-6jCVuqWU5UL34qo2J_VlDXk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286886>

[please don't top-post on this list]

On Mon, Feb 22, 2016 at 1:49 AM, Peter Dave Hello
<hsu@peterdavehello.org> wrote:
> Thank you, is there anything I should do? Or I should just wait?

Best is to wait for other review comments, particularly from Junio.
Reviewers work at their own pace as time permits, so don't be
surprised if it takes days or a week or more. If you don't hear back
from Junio after a week or two, and if you don't see that he has
silently picked it up in his "pu" branch and don't see mention of it
in Junio's "What's cooking" email after that time, then it can be
helpful to send a reminder about the patch to the list.

> Best,
> Peter
>
> 2016/2/22 =E4=B8=8B=E5=8D=881:56=E6=96=BC "Eric Sunshine" <sunshine@s=
unshineco.com>=E5=AF=AB=E9=81=93=EF=BC=9A
>>
>> On Mon, Feb 22, 2016 at 12:54 AM, Peter Dave Hello
>> <hsu@peterdavehello.org> wrote:
>> > From: Peter Dave Hello <hsu@peterdavehello.org>
>> >
>> > Use `#!/usr/bin/env perl` instead of `#!/usr/bin/perl`,
>> > the util "env" can help located the "perl",
>> > so that it can work on FreeBSD and other platforms.
>> >
>> > Signed-off-by: Peter Dave Hello <hsu@peterdavehello.org>
>>
>> Better, thanks.
>>
>> > ---
>> >  contrib/diff-highlight/diff-highlight | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/contrib/diff-highlight/diff-highlight
>> > b/contrib/diff-highlight/diff-highlight
>> > index ffefc31..b57b0fd 100755
>> > --- a/contrib/diff-highlight/diff-highlight
>> > +++ b/contrib/diff-highlight/diff-highlight
>> > @@ -1,4 +1,4 @@
>> > -#!/usr/bin/perl
>> > +#!/usr/bin/env perl
>> >
>> >  use 5.008;
>> >  use warnings FATAL =3D> 'all';
>
