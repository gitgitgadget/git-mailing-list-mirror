From: Yamada Saburo <devil.tamachan@gmail.com>
Subject: Fwd: [PATCH 4/4] Update Japanese translation (Git-gui)
Date: Fri, 19 Jul 2013 05:52:08 +0900
Message-ID: <CAPM==HLEiwcP6ubgBh42j3w0VPMzXVhfjB9VM=6QWGxvk7M9jg@mail.gmail.com>
References: <CAPM==H+fCx3k-iL2x4GQLtVxg662CqiPuD0g4v2+_a8MTrG4gQ@mail.gmail.com>
	<7vzjtj1zmw.fsf@alter.siamese.dyndns.org>
	<CAPM==HK6o+vMbrb0o16qiKAG2azvBDPdXrXWaVro1W=Z-rXr7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 22:52:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzvBS-00089l-U3
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 22:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783Ab3GRUwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 16:52:12 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:45448 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759359Ab3GRUwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 16:52:09 -0400
Received: by mail-vc0-f182.google.com with SMTP id id13so2714690vcb.27
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 13:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=y5O7J2mb4MlN92V5LO/0ruhM2bNyzYoFxGwH89lnOwo=;
        b=LnTga++fcvXvriX6jX5FNZihxHmrFlHi8SffS/gVPKUDxIMA8Gm2VDg+U/OVZeP/aV
         JDHFtOAL1VIo0ERbjkHYAcjCg9GdAwyzF9PVD3JnfijBEQqDQLVDsE9HmL5z9Qk8EeoQ
         UTvdRRzhE7Ken69jDBcEabDia4pkqxebqrfdlaKfkkyNL8bZWv83Ot6xlQgeKZH+kRH8
         NK9oV5XSWyU6u/K00z1QHSQagv0RkI4ZPxh+5TlkiP0VpA/4IwdXM5/RfG0GfsCZ/PJU
         KQHBdHRvDw4vGBbkV5BW43wnjSfQDb4WfEpgxZZuyPxzFVQEES2u4RB6HqZCxBMHPNS5
         wESg==
X-Received: by 10.221.63.2 with SMTP id xc2mr4698060vcb.74.1374180728287; Thu,
 18 Jul 2013 13:52:08 -0700 (PDT)
Received: by 10.221.24.7 with HTTP; Thu, 18 Jul 2013 13:52:08 -0700 (PDT)
In-Reply-To: <CAPM==HK6o+vMbrb0o16qiKAG2azvBDPdXrXWaVro1W=Z-rXr7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230743>

---------- Forwarded message ----------
From: Yamada Saburo <devil.tamachan@gmail.com>
Date: 2013/7/19
Subject: Re: [PATCH 4/4] Update Japanese translation (Git-gui)
To: Junio C Hamano <gitster@pobox.com>


Hi Hamano,

> dubious ones like this (there is no change to the string, just the
> way msgstr is formatted to make them all overlong single strings).
changed by QT Linguist for Win.

>  Perhaps "元のファイルタイプでの変更をコミット予定済", or something?
Your translation looks right. New mail is due to be thrown later here.

Thanks

2013/7/19 Junio C Hamano <gitster@pobox.com>:
> 悪魔野玉茶無  <devil.tamachan@gmail.com> writes:
>
>> @@ -124,26 +127,23 @@ msgstr "コミット予定済、ファイル無し"
>>
>>  #: git-gui.sh:2087
>>  msgid "File type changed, not staged"
>> -msgstr "ファイル型変更、コミット未予定"
>> +msgstr "ファイルタイプ変更、コミット未予定"
>
> There are good changes like this in this patch, and ...
>
>>  #: git-gui.sh:3095
>>  #, tcl-format
>>  msgid "fatal: cannot stat path %s: No such file or directory"
>> -msgstr ""
>> -"致命的: パス %s が stat できません。そのようなファイルやディレクトリはありま"
>> -"せん"
>> +msgstr "致命的: パス %s が stat できません。そのようなファイルやディレクトリはありません"
>
> dubious ones like this (there is no change to the string, just the
> way msgstr is formatted to make them all overlong single strings).
>
>>  #: git-gui.sh:2088 git-gui.sh:2089
>> -#, fuzzy
>>  msgid "File type changed, old type staged for commit"
>> -msgstr "ファイル型変更、コミット未予定"
>> +msgstr "ファイルタイプ変更、コミット予定の形式が古い"
>
> Is this correct?  I do not personally use git-gui, but I _think_
> this message is given when you did something like this:
>
>         edit file ;# "file" is a regular file
>         git add file
>         rm file
>         ln -s something file ;# "file" is now a symbolic link
>
> at this point, "git status" would say "MT file".  The latter half of
> the translated Japanese reads "format planned to commit is ancient".
>
> Perhaps "元のファイルタイプでの変更をコミット予定済", or something?
>
> In any case, I think the organization of the series should be
>
>         [PATCH 1/3] git-gui: mark yes/no/ask for translation
>
> which is your 3/4, and then
>
>         [PATCH 2/3] git-gui: update git-gui/po/git-gui.pot
>
> which is your 1/4, and then
>
>         [PATCH 3/3] git-gui: update Japanese translation
>
> which is all the changes to git-gui/po/ja.po in your 2/4 and 4/4.
>
> Also I forgot to notice when I was reading the earlier patches, but
> git-gui has a separate root commit, so please base your work on
> Pat Thoyts's tree at:
>
>     git://repo.or.cz/git-gui
>
> Thanks.
