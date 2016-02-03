From: Bryan Turner <bturner@atlassian.com>
Subject: Re: Git for Windows crashes on Windows 10
Date: Tue, 2 Feb 2016 23:03:19 -0700
Message-ID: <CAGyf7-EReFk=UrfLfCjCYV8bjDRCs4WFbWxfKtJz2JQmtgBRFA@mail.gmail.com>
References: <34a86972.3610.152a59a27d0.Coremail.sunqiancheng0644@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: =?UTF-8?B?5a2Z5Lm+56iL?= <sunqiancheng0644@126.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 07:03:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQqXE-0000dC-TI
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 07:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbcBCGDV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 01:03:21 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34507 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbcBCGDU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2016 01:03:20 -0500
Received: by mail-qg0-f46.google.com with SMTP id u30so9015617qge.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 22:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=J+WBILmc+j4yI6+zZAGmTiBSevN91T6jNGE4Ihh6JoE=;
        b=zvbbyDBrm6aJLclP+CTljRiK3XKM4TX5M3ddae09Tj2Y8+7lG2Y/kOJdNxIrqLaSih
         Uee9TfOWDdwb/kopZgmwr85eM6g26GUBJpJ0m2FOEx9Gl1zViqHhuBtudS51YMUKWX0n
         zc812Tb8oxw0bV8h3U+RpW3nLPj/uc9HjHPcaMKxKtOOv6jzrqfBCoNGE+qiD/5h+d0X
         xGFJtDNfWkTMqnFV11a/IqhamF6pL4u7bu3OgRv21VKjPU8RR6wqmA5ndebcASzXMq4V
         5VHp8ERz6XNGHjIcPEfZVzMXl+vuZWg79yE4/K1yw4ORxbqlKaaMtuKNNAg4acy9/3QH
         rkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=J+WBILmc+j4yI6+zZAGmTiBSevN91T6jNGE4Ihh6JoE=;
        b=KsXB/+H48kJPVOGBuu5PNs1Jkp3oPqr8qW8CmTm0pgmsqYyRao0WgW3S5J8VVtdIy0
         23jcIbIGBZRE6I4O6ByKiId6V70tsTXtzC8JobCwzW/xqDaPSfPjOfnN4oZvErwE0FO2
         /cA6AXU8OrPjCh+uA29kgwwGuoljTsysQEzhxMSU7dWLkL8f7jq/+vIw+WtGfAMP9Za8
         StUotdsz87Sd5uwX5Ynyyz4j7xZCwr/f9UUrIKq/l7QieeGb7lR/XPUzoklXzXcq5D2o
         CH+vumaeWpu1t6ix4+hrYmw56fSWM/t/3EY+mGHbv0fd+wi7G7QfTWq5jQ/DD2sKJZ9x
         XkjQ==
X-Gm-Message-State: AG10YOS+AkBU/2xkwCv3oe25CA16j2ZS/n0rOXIGgO/TxGArARFouBcQm9JgdhDfb4HNqqhOWWRZ1lfbWpD4GjgH
X-Received: by 10.140.94.50 with SMTP id f47mr8078231qge.0.1454479399668; Tue,
 02 Feb 2016 22:03:19 -0800 (PST)
Received: by 10.55.157.21 with HTTP; Tue, 2 Feb 2016 22:03:19 -0800 (PST)
In-Reply-To: <34a86972.3610.152a59a27d0.Coremail.sunqiancheng0644@126.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285335>

On Tue, Feb 2, 2016 at 10:28 PM, =E5=AD=99=E4=B9=BE=E7=A8=8B <sunqianch=
eng0644@126.com> wrote:
> I'm not a native English speaker. I'm sorry if I didn't explain the p=
roblem clearly.
> I'm using Windows 10 Enterprise Insider Preview (I'll use Win10 inste=
ad below). Until yesterday, I'm using Win10 build 11102, and Git for Wi=
ndows works well. But today I upgraded my system to Win10 build 14251, =
then something wrong happened.

I'm pretty sure you're running into
https://github.com/git-for-windows/git/issues/627. Since it's a bug in
Windows itself, there's not a fix in Git. Your options are:

- Downgrade back to 11102
- Wait for the next preview build after 14251
- Downgrade to msysgit 1.9.5

> I opened a "cmd" in my repository and entered "git pull", then a dial=
og window appeared, saying "Git for Windows has stopped working".
> The version of the git on my system was 2.6.4, and I found out that t=
he latest version was 2.7.0.2. So I downloaded a installer from "https:=
//git-scm.com/". I opened the installer, but as soon as the installatio=
n finished, the same error dialog appeared. I closed the dialog, but it=
 appeared again, so I closed it again. I opened a "cmd" and entered "gi=
t", of course, it crashes and the error dialog appeared.
> By the way, I installed GitHub for Windows on my system and it crashe=
s too when I pressed the "Sync" button in it.
> In my surprise, GitHub Extension for Visual Studio works correctly.
>
