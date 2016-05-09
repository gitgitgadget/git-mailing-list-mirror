From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: t6392 broken on pu (Mac OS X)
Date: Mon, 9 May 2016 12:30:43 -0400
Message-ID: <CAPig+cQ2kSVzy0K303J3Guhk3-NzcReb5V7ohqOy2pPL_5GrSA@mail.gmail.com>
References: <dea0877d-fe83-fb47-4df3-21fd69d8421d@web.de>
	<20160509160725.GA11861@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 18:30:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azo53-0005ol-69
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 18:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbcEIQap convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2016 12:30:45 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:33740 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbcEIQao convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2016 12:30:44 -0400
Received: by mail-ig0-f195.google.com with SMTP id rc4so11835077igc.0
        for <git@vger.kernel.org>; Mon, 09 May 2016 09:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=szb8arU0qpzePBOuM+wkgfwpgUBYfqEHNLxwzQoY03g=;
        b=ZQEew2Hc6350cYafTRVLcKOsLKMoZ/ONQUECuWzRX+soTOUEDQoQlXLkdIb5hM9Gt0
         vFBLo5p6Hz2Xw0KT5xSjzOtgiqDamHYWrgL026LBjM6+F1VFoP/eu8AIlFIw7DLBdpyr
         sLdIuTg6CN8uY7X/HHcPatcd9fsi9jxv//GZfKEhRtWwSi0mMrV8bE89nUKf4JXrN64H
         NFgfxtEnb4GmwLdHXBjs56C5ZunpKgjUheN0WxGsZ5wC/jN1Q6VB7lwmms2bYKF0rkFM
         qANCMDcLNF0FYsnmkbdcrHfFgOoRuiuukE8OpV39plUjdezFDYnXczHUkSrSRS4z496y
         ecZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=szb8arU0qpzePBOuM+wkgfwpgUBYfqEHNLxwzQoY03g=;
        b=cpk8XdZTjPR5zmg2q5H6ymBfDv+khqc4KnE1NPe/1umso4BlNgdaTkuxnSxLQeTdpZ
         bA0OtzmZ2hsrBG7Ekd5f7fAMYjxLMUbrrSih0se8Ro7V4owy85kWwCNbscCeVcIkXCj4
         xMVzRcKMxwPGFzpfjdj0atAZS7pLmza4AScB1jso07CXc8/3ZciRbnYfn8E65hzZP9hm
         mrgoYlhPcsZBERvZTRPQzOxSIYnS9muhtCKh27Ygh2fYPte9Whwtk/uHyJS4Ifko5Ht3
         H6OQJQsXzJ5fzoZvA3toP21yUQyOYpuWuuCyMCeZgoffFzeu+FdwiLvSdFZSX/vyc1J+
         wM2Q==
X-Gm-Message-State: AOPr4FVYldmcbmflrl8MRNnhdN53KMT98lQpQxFZQvcOAroFaxvXQRkvEjYX2xa/Uu/RPJetyV1CWLb6ih3NPQ==
X-Received: by 10.50.6.15 with SMTP id w15mr12672330igw.91.1462811443566; Mon,
 09 May 2016 09:30:43 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 9 May 2016 09:30:43 -0700 (PDT)
In-Reply-To: <20160509160725.GA11861@sigill.intra.peff.net>
X-Google-Sender-Auth: UbrLI7Re68CdMIwzOWBUT4V2Tl4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294012>

On Mon, May 9, 2016 at 12:07 PM, Jeff King <peff@peff.net> wrote:
> On Sat, May 07, 2016 at 06:15:19PM +0200, Torsten B=C3=B6gershausen w=
rote:
>> These tests fail here under Mac OS,
>> they pass under Linux:
>> commit ff3d9b660a4b6e9d3eeb664ce1febe717adff737
>> I haven't had a chance to dig further.
>
> I assume you mean t6302. It looks like the difference is not Mac OS, =
but
> rather that the GPG prerequisite is not fulfilled, so we are missing =
a
> few of the tags.
>
> Commit 618310a introduced a helper to munge the "expect" output. Usin=
g
> that fixes some of the cases, but not test 34. That one is expecting
> blank lines for tags, so test_prepare_expect doesn't know which lines
> are related to GPG.
>
> We could fix it by tweaking the test like this:
> [...snip...]
> However, I wonder if we could improve on the strategy in 618310a, and
> simply create non-signed versions of the "signed" tags when GPG is no=
t
> available. That would make tests looking at the whole ref namespace
> more consistent. And any tests which wanted to look specifically at t=
he
> signed attributes should be protected with the GPG prereq anyway (it
> doesn't look like there are any currently, though).
>
> I.e., something like:
> [...snip...]
>  test_expect_success 'setup some history and refs' '
> @@ -24,9 +20,12 @@ test_expect_success 'setup some history and refs' =
'
>         git tag -m "Annonated doubly" doubly-annotated-tag annotated-=
tag &&
>         if test_have_prereq GPG
>         then
> -               git tag -s -m "A signed tag" signed-tag &&
> -               git tag -s -m "Signed doubly" doubly-signed-tag signe=
d-tag
> +               sign=3D-s
> +       else
> +               sign=3D
>         fi &&
> +       git tag $sign -m "A signed tag" signed-tag &&
> +       git tag $sign -m "Signed doubly" doubly-signed-tag signed-tag=
 &&
>         git checkout master &&
>         git update-ref refs/odd/spot master
>  '

The latter seems very preferable, though perhaps it could be made more
concise like this?

    sign=3D
    test_have_prereq GPG && sign=3D-s

(But that's a minor issue.)
