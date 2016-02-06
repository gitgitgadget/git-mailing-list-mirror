From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git show doesn't work on file names with square brackets
Date: Sun, 7 Feb 2016 06:48:39 +0700
Message-ID: <CACsJy8ChZzYWXePSwF6D8vPZMuz3dQe1=jtw6rSG7M1oC+RiNw@mail.gmail.com>
References: <6A7D4447-AC25-4591-9DA7-CD153198EC64@jetbrains.com>
 <alpine.DEB.2.20.1602061518220.2964@virtualbox> <25D155FA-6F05-425C-AB2D-7F0B44E0D1C5@jetbrains.com>
 <alpine.DEB.2.20.1602061708220.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 07 00:49:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSCbr-0005R4-F9
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 00:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbcBFXtL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2016 18:49:11 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35733 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbcBFXtK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2016 18:49:10 -0500
Received: by mail-lf0-f42.google.com with SMTP id l143so77158483lfe.2
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 15:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kKwX1UrFsTZdzmXu4zQycqfdk17sR2LBBlYMM1LfFl8=;
        b=BXkeJPeUXCexooP6Bqq1lZPsw2n0VjsNWemM3L5HbKovAsSlIJnx5U/KJGZKPRXGZc
         td4Ad9HMslWSnTwvy5rVHM5cU3SyfVPl6BPVmJ4xOndFtnahaWzwGx6F3plDcMzz1wiz
         rBjjoZZ1DJi2eNDbTA/PD5e+Jz09GR51RZnRLMSqz+cnGd8Rm7Jsd48TVU27YWYp4/XQ
         5JHLUVuCC9GofFykP6MfX84BcoesCKmekggvvwHrXhvwvoP9Mlf8W3ffzyad0TRNSNJL
         3DCISL0jR3yZ5i0AcWbha/QbJYf09CEKD/dfP/fCz6FEfx7YuqqHT02HP9uXTad9r3VF
         1Xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=kKwX1UrFsTZdzmXu4zQycqfdk17sR2LBBlYMM1LfFl8=;
        b=k35jX58i0pJOTNbVFDd6OfaSqRApCeTUPZGtAm+D/wUyh70EdUvKeS9lG6KPT+bMUI
         cKbYUs9M/zCMdDAmX/FPFUpzx0H3WOO1O7PCgyqGmsJBF375rR3hi57kaUTQUhyMmkQd
         nV2iGdXJvicZccMmPVp/7NmJy1I6+cYrO+vD8Tw7j/A8YDIXn4Tb4wLzUVtrPMXM0WMH
         5e4p4QnjGVAsHQOViqffdjOYsboF4ukF6o7ZYn4Tfxh8ugf/pyTe5GTonJ7yYs78JGaM
         cy+4spKEwhW6t123cgrBuJHJDqF9Y8lUKtEvkQv5GKrRvgRnh0cZj3nT69sU5HQMaNRq
         2LRA==
X-Gm-Message-State: AG10YOR8AlC/5no5ZMbWRcc4WYyhDdlgtTC7WIvLRRv0vkdxD8tS2om8advqjHIoL8JRiQxOLlv54NGPi8c3vA==
X-Received: by 10.25.212.11 with SMTP id l11mr8637119lfg.118.1454802548681;
 Sat, 06 Feb 2016 15:49:08 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sat, 6 Feb 2016 15:48:39 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1602061708220.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285707>

On Sat, Feb 6, 2016 at 11:10 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Kirill,
>
> On Sat, 6 Feb 2016, Kirill Likhodedov wrote:
>
>> > On 06 Feb 2016, at 17:21 , Johannes Schindelin <Johannes.Schindeli=
n@gmx.de> wrote:
>> >
>> > This is expected behavior of the Bash you are using. The commands =
that I
>> > think would reflect your intentions would be:
>> >
>> >     git init brackets
>> >     cd brackets
>> >     echo 'asd' > 'bra[ckets].txt'
>> >     git add 'bra[ckets].txt'
>> >     git commit -m initial
>> >     git show 'HEAD:bra[ckets].txt=E2=80=99
>>
>>
>> Nope. This command sequence doesn=E2=80=99t work for me: the same er=
ror is returned:
>>
>>     # git show 'HEAD:bra[ckets].txt'
>>     fatal: ambiguous argument 'HEAD:bra[ckets].txt': both revision a=
nd filename
>
> Whoops. Sorry. I actually ran those commands now and it is true that =
it
> still does not work, which is funny. Especially since
>
>         git show 'HEAD:bra[ckets].txt' --
>
> actually *does* work.

It's from 28fcc0b (pathspec: avoid the need of "--" when wildcard is
used - 2015-05-02)
--=20
Duy
