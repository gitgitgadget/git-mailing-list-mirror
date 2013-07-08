From: Matthieu Brucher <matthieu.brucher@gmail.com>
Subject: Re: git p4 clone not processing branches properly
Date: Mon, 8 Jul 2013 12:10:42 +0100
Message-ID: <CAHCaCkJ1rTj3xt4_rHEYTWzRbSDVnULwfkTggevn+qjLj_UC5A@mail.gmail.com>
References: <CAHCaCkJ+zRwu67QsYidmvcwtWtPPd4XPBYDaTnHLt9HrTSDM3A@mail.gmail.com>
	<CAHCaCk+8EehnwMP98EX=cdoyQof=zPj65Vyd_YaADVquztOYww@mail.gmail.com>
	<loom.20130705T195116-413@post.gmane.org>
	<CAHCaCkLpobqTOUMeK2TP_=VkjRo4P3-dMwt85_CaasSuRNE1Kg@mail.gmail.com>
	<CAOpHH-WAjjaa3oOXje3u5bBWb=vm-2wG1KYf8oKwH__XLK4R2A@mail.gmail.com>
	<CAHCaCkJDNqhd0UqnZhrA13V=J_yJBr17BuWohjMRADCPYFiQ4Q@mail.gmail.com>
	<CAHCaCkL=ghxktJHDEVPfn73o-6oPQnXQv1NBCwxkwsM==-bQ4A@mail.gmail.com>
	<CAOpHH-WiH8K__Wm_0WmnDpY8OKMWVz5-sOQWZ1vtb0GPJ44USQ@mail.gmail.com>
	<CAHCaCkL6p2ha-8yj4x0G5NodwSdupftCDO4Rst0WTLBRdK2PcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 13:10:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw9LD-0001eP-BG
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 13:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663Ab3GHLKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 07:10:43 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:62111 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab3GHLKm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 07:10:42 -0400
Received: by mail-oa0-f48.google.com with SMTP id f4so6039256oah.21
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 04:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pnuemvsVFUXCIuNT3f4Kt14UiiY8XJBLJwSAfB6Qyw8=;
        b=dQvaksqyO8YWWdaKLX3v/6/EbHC470s3nIjfOsRQgGQ1W4HGdXBGIx2COyJFDtYtS2
         iPuO1bx3vqySsF5ScG2hKpe9fp+wcQLspBJSdWW5R99IINNOZLKJ9MsmlExlMO7BWnRR
         eOodYfNgWL2WS/8mm96oJyI5z9oGv/bI9bv3xuP47cBN30ESTNfCdeKEBjv6K2xvysWY
         V04HFxLIRcPrL4lVkC3dc83+pPuKtvO/FF1nv9cmI2sWrvhS8tUKwZlsbxs4EtYoDUY7
         Mee6zk1uQR1t0nH+IJQda5STNIXS8iUdzo4mamAAWfgSpMNd9uoysIDm2GXNxXyu1wKZ
         ISyg==
X-Received: by 10.182.87.42 with SMTP id u10mr19824401obz.73.1373281842103;
 Mon, 08 Jul 2013 04:10:42 -0700 (PDT)
Received: by 10.76.153.5 with HTTP; Mon, 8 Jul 2013 04:10:42 -0700 (PDT)
In-Reply-To: <CAHCaCkL6p2ha-8yj4x0G5NodwSdupftCDO4Rst0WTLBRdK2PcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229838>

Without the spec client, it seems that the branches are recognized,
but there are some many binary files that I need to remove them during
the migration.
I tried setting a .gitignore beforehand, but it is not respected (I
tried to remove some folders with folder/ in .gitignore, but the
folder are still imported).
It there a switch for the import somewhere?

Thanks,

Matthieu

2013/7/8 Matthieu Brucher <matthieu.brucher@gmail.com>:
> Unfortunately, git branch -a returns nothing :/
> I tried with the simple detect-branches as well as with the config values.
> Perhaps the spec-client? Although it is strange as it seems that the
> repository is completely empty.
>
> Thanks,
>
> Matthieu
>
> 2013/7/8 Vitor Antunes <vitor.hda@gmail.com>:
>> On Mon, Jul 8, 2013 at 11:09 AM, Matthieu Brucher
>> <matthieu.brucher@gmail.com> wrote:
>>> Hi again,
>>>
>>> I tried with @all, but it didn'y work as expected. It imported a bunch
>>> of revisions (but no files?) and ended with:
>>>   Reading pipe: ['git', 'config', '--bool', 'git-p4.importLabels']
>>>   Not checking out any branch, use "git checkout -q -b master <branch>"
>>>   executing git config --bool git-p4.useclientspec true
>>>
>>> And when I tried to checkout Branch/Main, it failed with
>>>   fatal: Cannot update paths and switch to branch 'master' at the same time.
>>>   Did you intend to checkout 'Branch/Main' which can not be resolved as commit?
>>
>> Hi Matthieu,
>>
>> Please run "git branch -a" in that repository and you should be able
>> to see the various branches under /remotes/p4/
>> Then you just need to choose a branch and run "git checkout -b
>> git_branch_name p4/p4_branch_name".
>>
>> Cheers,
>> Vitor
>
>
>
> --
> Information System Engineer, Ph.D.
> Blog: http://matt.eifelle.com
> LinkedIn: http://www.linkedin.com/in/matthieubrucher
> Music band: http://liliejay.com/



-- 
Information System Engineer, Ph.D.
Blog: http://matt.eifelle.com
LinkedIn: http://www.linkedin.com/in/matthieubrucher
Music band: http://liliejay.com/
