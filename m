From: John Tapsell <johnflux@gmail.com>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 11:48:31 +0000
Message-ID: <43d8ce650903120448x51220ba0k660be7706acba755@mail.gmail.com>
References: <43d8ce650903120436u261cb7e3p838e4a12e7b54d7d@mail.gmail.com>
	 <alpine.DEB.1.00.0903121240400.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 12 12:50:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhjQI-0005YH-St
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 12:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581AbZCLLse convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 07:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbZCLLse
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 07:48:34 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:32062 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbZCLLsd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 07:48:33 -0400
Received: by wf-out-1314.google.com with SMTP id 28so600436wfa.4
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 04:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MxjRa/7CdsngIlalqHLJpeEW+lkBZhAPUxi8tUeHcRA=;
        b=WIgFtCX+tiLbGskKbkRVD6bc3bJ4W6bBYIHdouASQiECnhPHxAX6RwDYmu5PsDyqFu
         yUgYxc7Vy6iCNnqhna1cbNkXuqs4oHmYz4dgQHdvGExxspxFwGnpOYMizBQh2AyUSLuy
         cdWnSCXefCL9p8SrlKOy9w0iZZUSkQ2t+uWbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SBGBnNtgyQtYj73FX+o2qONMXM0xGV5LcPrqi6BFYorPJHC6oHsokQKOdlz4n2/Le3
         dECLS0eq0jR7MXTzDKnaFGGw5vprZTsMr9UmStIPpHBaQA60gMNHu6Bg36zDR6YwbRJ/
         3HMSvIXLWDUM+bzpIChzQbaDX1hqpeV3GmYcQ=
Received: by 10.143.12.19 with SMTP id p19mr4260197wfi.212.1236858511927; Thu, 
	12 Mar 2009 04:48:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903121240400.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113048>

2009/3/12 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Thu, 12 Mar 2009, John Tapsell wrote:
>
>> =C2=A0 One of my collegues did:
>>
>> git checkout origin/somebranch
>>
>> =C2=A0 git complained that they need to specify the name with -b. =C2=
=A0So they did:
>>
>> git checkout -b origin/somebranch origin/somebranch
>
> Yeah, a pilot error. =C2=A0It should have been
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git checkout -t origin/somebranch

Maybe the error message for "git checkout origin/somebranch"  should
suggest:  git checkout -t origin/somebranch?

> I have to wonder, though, why "git checkout origin/somebranch" did no=
t
> detach your HEAD.

It did.  But that doesn't affect doing "git checkout -b
origin/somebranch origin/somebranch"  afterwards.

>> =C2=A0 Git accepts this with no problems, but boy - all hell broke l=
oose.
>> Doing a push or pull gave errors, because "origin/somebranch" is now
>> ambigous (since there is two of them).
>
> I strongly doubt that it gave errors, but rather warnings. =C2=A0I ha=
ve a
> repository where I get warnings all the time (it has a cvsimport and =
an
> origin remote), but it works without problems.
>
>> =C2=A0They can't even: =C2=A0"git checkout -b somebranch origin/some=
branch"
>> anymore, since "origin/somebranch" is ambigous. =C2=A0It all got int=
o a mess.
>
> I wonder why you did not just "git branch -m somebranch".

Because they didn't know what on earth was going on, and git was
spitting out errors everywhere, they were afraid git would crash.

John
