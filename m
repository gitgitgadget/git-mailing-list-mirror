From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC] Introduction and Project Discussion
Date: Sun, 20 Mar 2016 13:55:52 +0100
Message-ID: <20160320125552.GA32027@hank>
References: <CAJj6+1Ewdn_FNHR-qPqYzKEfQ6kgjXRBvc7dzMLK_2pPKukRvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Chirayu Desai <chirayudesai1@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 13:55:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahctQ-0000Wy-BV
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 13:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508AbcCTMza convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2016 08:55:30 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36956 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755478AbcCTMzX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 08:55:23 -0400
Received: by mail-wm0-f45.google.com with SMTP id p65so91848796wmp.0
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2Zh7r5IwtdghX8hEW4R1hXQvSTNb/fpYSjI4In4JRA4=;
        b=ABqP+AOx8zafaRGdczQRJ9zIHPo5MqKZcsVfM8dj2ivyTy+kKb5WZheVLpk4scIYDg
         yw9+RMfxFtH/ipKeTIoG/+7XGiHOKaJQiG9qvYilRjDoLbd/PQpdIu6Q1eVxiMJTEsos
         /oB+BBcwnkQ3Z1C7paqF9gAydX5r6D0QvEmHINxlhuDVPNiKOZE9mcdgXhTG9cGvwtZq
         8l67M2+zLo6wY3kvUlY2rzWw2+J2/UixtqhvR9gmjek3orJozU8/lgN5nV4ThUoKf8qH
         UOvJzVJ+p/bp0UdRR5bGL8TymITFCbIvZ828aPN9vahyUzqw35JeHuP2tF+PgOjsOeXJ
         /XEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2Zh7r5IwtdghX8hEW4R1hXQvSTNb/fpYSjI4In4JRA4=;
        b=H0sdV3xXjB/KoYyrj0WMv7RfmyI8a7zaQZf55oATBygAvlyc1wiDP5YmQsq59ua/Hw
         unxqEgsevmlaTvru8aT/+onCgctwH2Yf1bsvPlWruNzGHpLIy1vydiH/piyc5PwVAzPy
         6fdRf2tRs5RXPR9RKJ7/AF1/VuvMBen96QFLJb4iusROYNf5vZZrRQDmN5r2JtlHh8Zo
         CgBe0vtpanuULk5o1+sNBvvZrwB9StkpI5puz195BkilI1Eg/7f3G2ATQZ4aAK2xoT6y
         sVEETAqIPcqL5zHp0ibbaYkKBSJ5DcgqzWg7cMoiVy3nVtIlPVJSFC48wkRjnQ+p5wqH
         Nlig==
X-Gm-Message-State: AD7BkJIvz9zGM4x6F/YFQai5MOYcfm2Qd2QW43ScfL0dGz93Rwh+K3egjR2Kjz5cjvjAnQ==
X-Received: by 10.194.201.166 with SMTP id kb6mr25533970wjc.125.1458478521266;
        Sun, 20 Mar 2016 05:55:21 -0700 (PDT)
Received: from localhost (host86-185-232-204.range86-185.btcentralplus.com. [86.185.232.204])
        by smtp.gmail.com with ESMTPSA id d2sm20576875wjf.28.2016.03.20.05.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Mar 2016 05:55:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJj6+1Ewdn_FNHR-qPqYzKEfQ6kgjXRBvc7dzMLK_2pPKukRvg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289350>

Hi,

On 03/19, Chirayu Desai wrote:
> Hi,
>=20
> I am a first year computer engineering student from India, studying a=
t
> the Silver Oak College of Engineering and Technology,
> I had already put part of this in "[PATCH/GSoC] pull: implement
> --[no-]autostash for usage when rebasing", but at that time I didn't
> notice that another student was already working on the same change,
> and I would like to apologise for that, it was totally unintentional.
>=20
> I have since picked another microproject, "Make =E2=80=9Cgit tag --co=
ntains
> <id>=E2=80=9D less chatty if is invalid", and after looking at the co=
de, it
> would have the same effect for any command with has a "--with" or
> "--contains" option, which currently are 'tag', 'branch', and
> 'for-each-ref'.
>=20
> I have worked on OSS in the past (and am currently semi-active as
> well, working as a device maintainer with CyanogenMod, an android
> distribution)
>=20
> I would like to work on "Git remote whitelist/blacklist". The current
> example on the ideas page [1] looks like something that wouldn't be
> too much trouble to implement. Still need to dig a bit more on that.
>=20
> I also saw Thomas Gummerer's idea on the list [2], seems like a reflo=
g
> on steroids?
> I still don't understand the entirety of that, so some clarity on tha=
t
> would be nice.
> It also seems a bit complex

I can't say much about the other projects you mentioned, but my
proposal is too complex for a GSoC project.  I wrote the idea down to
convince myself whether it would be okay or too complex for a GSoC
project, but came to the conclusion that it is too complex.  I just
posted it to the list since I had written it down anyway, in case
someone was interested.  Sorry for the confusion.

> Apart from this, I was also interested in the "git config --unset
> improvement" idea, as currently something as basic like
> `git config --global foo.bar 1 &&
>  git config --global --unset foo.bar`
> leaves a section [foo] in the config.
> I would like to try to solve this in some way without having to
> rewrite the parser, but if that can't be done easily then I'm open to
> doing it any other way as well.
>=20
> So, to sum it up,
> I would like to work on "Git remote whitelist/blacklist", and if the
> mentors deem it to not take too much time / not be too hard of a task=
,
> I could also try to look at the configuration parser.
>=20
> Thanks,
> Chirayu Desai
>=20
> [1]: http://git.github.io/SoC-2016-Ideas/
> [2]: http://article.gmane.org/gmane.comp.version-control.git/286708
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Thomas
