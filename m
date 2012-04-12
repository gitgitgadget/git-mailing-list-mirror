From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Parallel refactoring and git merge nightmare
Date: Thu, 12 Apr 2012 15:41:24 +1000
Message-ID: <CAH5451myTL94j5T01vLkfRzf_bh2B_YPehvberr05uMdFyZdPw@mail.gmail.com>
References: <1334160803.74554.YahooMailNeo@web160603.mail.bf1.yahoo.com>
 <CAJDDKr6v6uPLoAQ96fP7JM5F0_WHqfbaD=QKyfrWPWd2St7tKQ@mail.gmail.com> <1334208237.82681.YahooMailNeo@web160606.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Pap_L=C3=B4rinc?= <paplorinc@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 07:41:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SICn4-0003pT-5I
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 07:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756571Ab2DLFlr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 01:41:47 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:39337 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539Ab2DLFlq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 01:41:46 -0400
Received: by wibhq7 with SMTP id hq7so1567677wib.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 22:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kAZvzenUfBxeOrQvUHSdWH+e5zQ+zwB4L5wAgxLtxYs=;
        b=SCNU/GnFgUC/MZ4rWjG/Eqw9TlWpUJNxcPqOdY3FvwqL1Yl7vC5CcJNSM86eUW+FbB
         TnS/LHtCOwcv9L6iXtnhWPCsO1hQvBYNuO+JSJElaIhkWjdtQmwqTx3jOwFS9E1BJt6f
         LYDCxZr1lGepKq2/RL9+1bPm/YBHLunmfppUgC/jh0uA0e4gBzQnTrWGD+ht5mrttptr
         JSQ8hy5P66u7Kce63ydK79k1C0hT3kpx5RnTrwCEV8AGZOvcvAnvRZ91pw6h/bZBJNdN
         3hw/HALNK3CL1BzQOM5JcfZnoBoE6TeABHPUe5DYmJXC9O8sULelJy9mUTm4NM+zmUJN
         dvxw==
Received: by 10.180.102.101 with SMTP id fn5mr2637462wib.6.1334209304956; Wed,
 11 Apr 2012 22:41:44 -0700 (PDT)
Received: by 10.223.159.72 with HTTP; Wed, 11 Apr 2012 22:41:24 -0700 (PDT)
In-Reply-To: <1334208237.82681.YahooMailNeo@web160606.mail.bf1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195294>

2012/4/12 Pap L=C3=B4rinc <paplorinc@yahoo.com>:
>>> Hello! :)
>>>
>>> We are working in parallel on the refactoring of a
>>> small project. The team uses SVN and I decided to give GIT a chance=
 to
>>> demonstrate it's merging capabilities I've read so much good about =
:).
>>>
>>> However
>>> =C2=A0- I must be doing something VERY wrong - every time I try to =
merge from
>>> =C2=A0the remote svn (git svn fetch and git merge remotebranch) int=
o my
>>> branch, I get hundreds of conflicts, mostly because of moved folder=
s.
>>
>>Google is your friend
>>
>>https://wiki.kuali.org/display/KULRICE/git-svn+how+to
>>
>>http://flavio.castelli.name/howto_use_git_with_svn
>>
>>http://viget.com/extend/effectively-using-git-with-subversion
>>
>>http://java.dzone.com/articles/how-start-using-git-svn-based
>>--
>>David
>
> I have no idea why you guys think I'm an idiot.
> I have read every link I could find (most of the Pro Git book and wat=
ched several hours of git video tutorials). The problem is not with GIT=
-SVN, it's with the GIT merge, more specifically with a simultaneous mo=
dify and move, which conflicts probably because it is detected as a mod=
ify and delete.
> Could someone please be a little more friendly, I need advice on how =
to solve hundreds of git merge conflicts (eg. parallel move and modify,=
 which should have been merged automatically).
>
> Thanks,
> L=C5=91rinc
>

Could you perhaps show us what commands you have tried, and what the
conflicts look like?

Regards,

Andrew Ardill
