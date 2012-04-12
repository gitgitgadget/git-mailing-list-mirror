From: David Barr <davidbarr@google.com>
Subject: Re: Parallel refactoring and git merge nightmare
Date: Thu, 12 Apr 2012 15:49:25 +1000
Message-ID: <CAFfmPPMbr-db+OnTwK-ry+wGQSEeunsD+QrmAVS2fzDH+hGnbg@mail.gmail.com>
References: <1334160803.74554.YahooMailNeo@web160603.mail.bf1.yahoo.com>
	<CAJDDKr6v6uPLoAQ96fP7JM5F0_WHqfbaD=QKyfrWPWd2St7tKQ@mail.gmail.com>
	<1334208237.82681.YahooMailNeo@web160606.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Pap_L=F4rinc?= <paplorinc@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 07:50:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SICv3-0008DI-6t
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 07:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639Ab2DLFt0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 01:49:26 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48795 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756612Ab2DLFt0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 01:49:26 -0400
Received: by yhmm54 with SMTP id m54so892899yhm.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 22:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=gUY143ga9BY5BUmph4rAtBU58XtG9QdsPJrIW39aye4=;
        b=cHIHUmXYLKjHAGHE8S4E8U4mz93ZiP908gGR8u+5cPa5Q9HkeFsagfRE/SXPcE6tf2
         XYbM0n2rKKp48zXt0i0sjztQkkscf0U1zVH4Z9+USeF3WaMlC0/JVu0Eh1Un4d/Lqnbf
         8h8BvXGhszCiOsRd24ocH4J9/pCUtvbuyf+HRJbMv127lwN5iBZD5LtGfiyRRe4WM2aM
         sMhL65CoqZ/k8rH6DMxiSfeZ+PZwfUKIwzrqk8FM4aS6Ra3XTp7a9cx/3LmrOcYv42mq
         +yMIFTD2YMNo5ppjnM4m2y4mdVrpDtZEXW3Zq3o8yUa1UNrfOEfQIT6Sk2I59b2hNIW7
         CW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=gUY143ga9BY5BUmph4rAtBU58XtG9QdsPJrIW39aye4=;
        b=RNAvgm+rSdjpHMk6idrqBIxCMp8PHpSGQs4mzSTjKue7PgkWp2DofXIetGE8Ki1DkM
         69iR8R61xTZlUh048Xd4S5GlC0rgXJ5YiNBOqSAls3Pb7id56D1jkhoZ/Idh2uJjw6Tk
         yBk9tnvBSF0a4izTG0xTJuDza3ppcWDIzRhWTr9Ua17nLM/JLN68koUyLaNXRVMUHNeI
         tKox2EoVUs1uLVxq6ReG6Ubh4t+SqNhtAwwILIrsiv2ty2J5RiXLBdfDajy7oRMDUl1U
         wDeobqVrBFf/Lnv5p6HD8oJy6waiLjBQikM5OqTDTFY/RbjpKK1v2NzPxErh2KPy2Ydp
         1cng==
Received: by 10.100.246.16 with SMTP id t16mr323021anh.3.1334209765440;
        Wed, 11 Apr 2012 22:49:25 -0700 (PDT)
Received: by 10.100.246.16 with SMTP id t16mr323012anh.3.1334209765296; Wed,
 11 Apr 2012 22:49:25 -0700 (PDT)
Received: by 10.101.83.5 with HTTP; Wed, 11 Apr 2012 22:49:25 -0700 (PDT)
In-Reply-To: <1334208237.82681.YahooMailNeo@web160606.mail.bf1.yahoo.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQmilyytW2I6g2hK56eEYnYKufZ4hrJ46s32/1oeXjUu08oNWJ7Cc5UPBXVw6zCh85dHmeLBTC0UAG8GKJrG667hRWmNhv/wsR9LJgABIREqa/tROKJxY7gqn25gl8X8/9PNSM+hDK6wh4Tcsopc7r0zUzH+3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195296>

On Thu, Apr 12, 2012 at 3:23 PM, Pap L=F4rinc <paplorinc@yahoo.com> wro=
te:
>>> Hello! :)
>>>
>>> We are working in parallel on the refactoring of a
>>> small project. The team uses SVN and I decided to give GIT a chance=
 to
>>> demonstrate it's merging capabilities I've read so much good about =
:).
>>>
>>> However
>>> =A0- I must be doing something VERY wrong - every time I try to mer=
ge from
>>> =A0the remote svn (git svn fetch and git merge remotebranch) into m=
y
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

Hi Pap,

I think I understand the issue you are facing.
I assume that your collaborators are following the practice of
one-commit-per-factor-operation.
My experience with this has been that synchronizing work best if
changes are "bubbled up".
I did this by progressively rebasing my branch against each upstream co=
mmit.
I hope this helps a little.

--
David Barr
