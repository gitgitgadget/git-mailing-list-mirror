From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [GSoC Project Help] Unifying git branch -l, git tag -l and git
 for-each-ref
Date: Sat, 21 Mar 2015 22:32:59 +0530
Message-ID: <550DA443.1030905@gmail.com>
References: <loom.20150319T121328-232@post.gmane.org> <550AC7E9.6060702@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sundararajan R <dyoucme@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Mar 21 18:03:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZMnm-0001yr-Jj
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 18:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbbCURDE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2015 13:03:04 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33451 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbbCURDD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 13:03:03 -0400
Received: by pdnc3 with SMTP id c3so139893117pdn.0
        for <git@vger.kernel.org>; Sat, 21 Mar 2015 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7/se+IpiAojZ+gPGGza//2Yqbs2nsM4gZL32XtGGFCs=;
        b=x9zwzkVKA6V9a+k/4Af+W42qeNj7FfbGSuo7O4/q78ueMYiWVmBskOq9S+gIn/nasS
         8Ncj1ec+AtIKV4J3m8gt2vooGaQWhhW5oECQTYc3KRyNcvhnJ5PAw+g8yTVXGquFUEIy
         hsFnUh4VHoBa8Q1tf4AA5VCnqt1lcRUWGh4iqsGJ1uYfhyMWEpzNGWdo1/DgbC3KydpC
         9Jg4ASh3PaUT8ASOENk0hT4n9Og/ms2U8JzoKw9G2ICb2j7SuV/vuFuhK0ctjCiwsx9k
         N8Sb76YmSQGAipxkHcvSjR1+TRehuH3WEP5dynVjAN59WHAjLf/uA4Z4AAb7lLO7PQWo
         yYaA==
X-Received: by 10.66.234.2 with SMTP id ua2mr176642706pac.137.1426957382942;
        Sat, 21 Mar 2015 10:03:02 -0700 (PDT)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id mi9sm12133934pab.3.2015.03.21.10.03.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2015 10:03:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <550AC7E9.6060702@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266025>


On 03/19/2015 06:28 PM, Michael J Gruber wrote:
> Sundararajan R venit, vidit, dixit 19.03.2015 12:22:
> > Hi all,
> >
> > I am a Computer Science sophomore at IIT Kanpur. I am interested in
> > contributing to git in GSoC 2015. I have been using git for the pas=
t one year
> > and am pretty comfortable with its commands which is what made me t=
hink about
> > contributing to git. I have attempted the microproject =E2=80=9Cadd=
ing =E2=80=98-=E2=80=99 as a
> > shorthand to @{-1} in the reset command=E2=80=9D [1] [2] from which=
 I learnt about
> > how code is reviewed in the community and how a seemingly small cha=
nge can
> > end up being much more difficult. But the thing I liked the most is=
 the warm
> > and welcoming attitude of everyone in the community towards a newco=
mer like
> > me. I wish to take up the project idea =E2=80=9CUnifying git branch=
 -l, git tag -l
> > and git for-each-ref=E2=80=9D. I am in the process of reading and u=
nderstanding the
> > codes of these three commands and figuring out similarities and dif=
ferences
> > in them. I have gone through some of the discussions regarding this=
 on the
> > archive and have also read Junio=E2=80=99s reply to Amate Yolande [=
3], but I haven=E2=80=99t
> > been able to find patches which attempt to unify the selection proc=
ess as
> > mentioned in the description of the idea. It would be great if some=
one could
> > point me towards these patches which would help me when I start des=
igning the
> > details of the unified implementation. Thanks a lot for your time.
> >
> > Regards,
> > R Sundararajan.
> >
> > [1] : http://marc.info/?l=3Dgit&m=3D142666740415816&w=3D2
> > [2] : http://marc.info/?l=3Dgit&m=3D142666773315899&w=3D2
> > [3] : http://article.gmane.org/gmane.comp.version-control.git/26496=
6
>
> I don't think there have been actual attempts at unifying the "displa=
y"
> part of the list modes. A first step would be:
>
> Check what "tag -l" and "branch -l" output you can reproduce using
> for-each-ref format strings.
>
> Then see whether for-each-ref needs to expose more information about =
the
> refs.
>
> I wouldn't mind unifying the actual output format, but some will disa=
gree.
>
> As for the issue of ref selection (contains and such), the following
> thread may be helpful:
>
> http://thread.gmane.org/gmane.comp.version-control.git/252472
>
> Cheers
> Michael
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
Hello,
I am applying for the same project as well, under GSoC. I found some at=
tempts by
Jeff King towards unification here :

https://github.com/peff/git/commits/jk/for-each-ref-contains-wip

Which was discussed here :

http://thread.gmane.org/gmane.comp.version-control.git/230694/focus=3D2=
308

Hope this helps you out too.

Regards
-Karthik
