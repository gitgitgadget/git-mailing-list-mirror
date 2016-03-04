From: Alexander Rinass <alex@fournova.com>
Subject: Re: git diff does not precompose unicode file paths (OS X)
Date: Fri, 4 Mar 2016 15:37:05 +0100
Message-ID: <D9E0FEEC-1987-4045-AD0F-4C7C76DC067B@fournova.com>
References: <0008C25D-C3F0-4A1F-8B50-4EF1E84CA04F@fournova.com> <56D97C8C.1060205@web.de>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 04 15:36:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abqqd-0000nE-Fo
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 15:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbcCDOgu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2016 09:36:50 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33741 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbcCDOgt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2016 09:36:49 -0500
Received: by mail-wm0-f47.google.com with SMTP id l68so22970383wml.0
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 06:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fournova-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MAEaY0i96usdlPn/2oflv60c4bCrCbuNgvHZuMU6/aM=;
        b=mrFrLHA/4MikjrQwajshybogvFn71HRqdSfQx16414zKNhL5KsRlh1R03HIc9E5S1t
         MOxOjnyYgyvWztMADxlMZeuYnxu93EphEJz/zKD60utRnenXdDQruKQ7Ql/8TCDU6VQn
         /6Tj6Gpl4792Uadh+O1yE2YS7jlHB6D6Fd9j3ysVsJvpRIC2MiVugmOT8n56QEvftEPn
         ybzIbKCMCgDpEI0dKpbK3T+u7qL+3ZKKazDK7lNfCFZST73TzPVDmC24LBZ/GrVUbmA4
         nQzvUBA16i5r7WGTjDkowcpX6e/2VQLb3tMXZR4QwPeBHFHeImUnKncMzFnpwYMQLu+P
         ZlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MAEaY0i96usdlPn/2oflv60c4bCrCbuNgvHZuMU6/aM=;
        b=XGSO2C6OwzaH8kcnMZJPLyUwps4BcpwxAWsD0Y5vsx1se3XJtzUTMK3wviXyonolth
         X+IX/6vuqske286M8dU3IJiUssDotWyQFo8mZxpVymo0aMDgASZGWFt0ZJaQgdn/wqkT
         WKXk7Nxyy3Ye0ca73CNE37bYIi4CYq717Q1hfRDpC/aipCrt36aHwvOEIMwl6xCQBGAR
         hBZp6EcrxyzLfE5x2ogGO2qMd3ZWAi+FIV81t+3dkr6/a5CfUKxcmfXoxcGEtvJtrYiS
         YpSI9Wt+BPcaZHWZ770PTA31atVexmdUhoHRdnvJh0E2GE1ESxMob1aOhXKNMRtlVB2U
         /GVA==
X-Gm-Message-State: AD7BkJIbeAWXoD8sw4CZkPirHxz478gB3OsGaRYLG3A3z7avm6xL67TcqxadMV7GlufJXQ==
X-Received: by 10.194.112.98 with SMTP id ip2mr9679463wjb.24.1457102207738;
        Fri, 04 Mar 2016 06:36:47 -0800 (PST)
Received: from ?IPv6:2a02:908:df42:8b00:54b8:eea0:3e61:8f6b? ([2a02:908:df42:8b00:54b8:eea0:3e61:8f6b])
        by smtp.gmail.com with ESMTPSA id c128sm3612734wma.11.2016.03.04.06.36.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 06:36:47 -0800 (PST)
In-Reply-To: <56D97C8C.1060205@web.de>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288257>


> On 04 Mar 2016, at 13:16, Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>=20
> On 03/04/2016 10:07 AM, Alexander Rinass wrote:
>> Hallo,
>>=20
>> It appears that the git diff command does not precompose file path a=
rguments, even if the option core.precomposeunicode is set to true (whi=
ch is the default on OS X).
>>=20
>> Passing the decomposed form of a file path to the git diff command w=
ill yield no diff for a modified file.
>>=20
>> In my case, the decomposed form of the file path is sent by the OS X=
 Cocoa framework's NSTask, wich I am using in an application. It can be=
 simulated on OS X by using $(iconv -f utf-8 -t utf-8-mac <<< FILE_PATH=
) as file path argument on the shell.
>>=20
>> Git commands like add, log, ls-tree, ls-files, mv, ... accept both f=
ile path forms, git diff does not.
>>=20
>> It can be tested with the following setup on OS X (as iconv's utf-8-=
mac encoding is only available on OS X):
>>=20
>>     git init .
>>     git config core.quotepath true
>>     git config core.precomposeunicode true # (default on OS X)
>>     touch .gitignore && git add .gitignore && git commit -m "Initial=
 commit"
>>          echo "." >> =C3=84
>>     git add =C3=84
>>     git commit -m "Create commit with unicode file path"
>>          echo "." >> =C3=84
>>     This gives the following status, showing the precomposed form of=
 "=C3=84":
>>=20
>>     git status --short
>>      M "\303\204"
>>     Running git add with both forms does work as expected:
>>=20
>>     git add =C3=84
>>     git status --short
>>     M  "\303\204"
>>          git reset HEAD -- =C3=84
>>          git add $(iconv -f utf-8 -t utf-8-mac <<< =C3=84)
>>     git status --short
>>     M  "\303\204"
>>          git reset HEAD -- =C3=84
>>     However, running git diff only works with the precomposed form:
>>=20
>>     git status --short
>>      M "\303\204"
>>          git --no-pager diff -- =C3=84
>>     [...shows diff...]
>>          git --no-pager diff -- $(iconv -f utf-8 -t utf-8-mac <<< =C3=
=84)
>>     [...shows NO diff...]
>>=20
>> I took a look at the Git source code, and the builtin/diff*.c do not=
 contain the parse_options call (which does the precompose_argv call) t=
hat the other builtins use.
>>=20
>> But I am not really familiar with either C or the Git project struct=
ure, so this may not mean anything.
>>=20
>> Best regards,
>> Alexander Rinass
>>=20
> Good analyzes, and thanks for the report.
> It should be possible to stick in a
>=20
> precompose_arrgv(argc, argv)
>=20
> into builtin/diff.c
>=20
> Do you you can test that ?
>=20


Sticking a precompose_argv(argc, argv) into diff.c=E2=80=99s cmd_diff f=
unction fixes the issue.

But I had to disable the check (precomposed_unicode !=3D 1) in precompo=
se_argv to make it work. That=E2=80=99s probably because precompose_arg=
v is usually called from parse_options and is missing some other call b=
efore it?

I think it is clear that diff.c and friends are definitely missing the =
precomposing step. I am not sure about the right way to fix though (sho=
uld parse_options be used in the end?) and my C skills are basic at bes=
t, otherwise I would create a patch.
