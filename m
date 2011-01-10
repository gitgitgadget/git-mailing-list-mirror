From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git-archive and core.eol
Date: Mon, 10 Jan 2011 13:11:23 +0100
Message-ID: <AANLkTinxVCQuTMeKHQ9mLbs=94fck90rwJwa1DhzGPmX@mail.gmail.com>
References: <AANLkTi=kfE88F7dY5F_xtbEuh9DyUcN+ymeXqLMWztGQ@mail.gmail.com>
 <4D28683B.4020400@lsrfire.ath.cx> <AANLkTi==eqwrwq-P6czDvOH5GDEi6WgvRUuZ2dMoiK7e@mail.gmail.com>
 <4D29AF80.5060008@lsrfire.ath.cx>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>, eyvind.bernhardsen@gmail.com
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jan 10 13:11:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcGbH-000736-U0
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 13:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868Ab1AJMLp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jan 2011 07:11:45 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52706 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349Ab1AJMLo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jan 2011 07:11:44 -0500
Received: by fxm20 with SMTP id 20so18763063fxm.19
        for <git@vger.kernel.org>; Mon, 10 Jan 2011 04:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=/FAFdLD8KIbQpkZcX0rl+MkZS2+nQqWtDTLYq0k9fGU=;
        b=sWKcLQSnZLGtwB9usO9VP96TwOSH3kIjIcw3Z/hGSk+JtfT0eB33IbO8rOfKm7Lf7y
         9iM53Suw6BDJHjjTDb2d2BRK+LQrygzsPKIwnlFtG++p6qaPOTMxjzExvt9QQoN4nDRt
         SCj4Pf/JzvfHYYEkiDShSWQa3bnFIi6tJAOFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=c31Y9CW1A/YcRsd4Qrfnq4Lx+sQieXsZ/ZqqV/U27vBfOu5/imZ27AOjDjETXFf3wq
         ah7RKDNWZIPRCN0yLR6qtZrbOdBvDu0I9175OK10EEWAKB8Cn1jn1ZMzRMDiS3Yvpw1h
         KYs8xDJwakqLhUpuKiF9d+jw8hdvvTHop5rio=
Received: by 10.223.112.1 with SMTP id u1mr5127546fap.109.1294661503245; Mon,
 10 Jan 2011 04:11:43 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Mon, 10 Jan 2011 04:11:23 -0800 (PST)
In-Reply-To: <4D29AF80.5060008@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164872>

On Sun, Jan 9, 2011 at 1:52 PM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 08.01.2011 18:28, schrieb Erik Faye-Lund:
>> Really? I haven't looked through what the test actually does (I'm ou=
t
>> sick right now, and don't have many working brain-cells), but every
>> single test fails for me:
> [...]
>> $ git --version
>> git version 1.7.4.rc1.3196.gfd693
>>
>> (This is the current 'devel'-branch from
>> git://repo.or.cz/git/mingw/4msysgit.git)
>
> I cloned it, but even though it reports a different version string fo=
r
> me we probably use the same (fd6937e0e6ccb78eb4347c427248e25c2d6739c8=
):
>
> =A0 =A0 =A0 =A0$ ./git version
> =A0 =A0 =A0 =A0git version 1.7.3.4.3902.gfd693
>

This is probably just because you haven't pulled junio's repo
recently, which contains the 1.7.4.rc1 tag. The tip is the same,
indeed.

> And all the tests succeed for me (on Windows Vista Home Premium x64)
> with that one.
>

I'm on Vista 64 if that matters. And I'm using msysGit e59039e.

> I'm especially interested in how the setup step manages to fail for y=
ou.

It's the line "git add .gitattributes" is the first that fails in
'setup'. Actually, all git-commands seems to fail.

But now I also observe that just trying to run t0000-basic fails:

$ ./t0000-basic.sh
=2E/t0000-basic.sh: line 24: ../git: is a directory
You do not seem to have built git yet.

Now this is suspicious:
$ ls ../git.exe
=2E./git.exe*

$ ls ../git
Debug/  git.vcproj  git.vcproj.Hue-PC.kusma.user  git.wwdb

Aha! The MSVC project generator creates a folder called 'git' at the
root, so anything trying to execute '../git' fails!

$ ../git help
sh.exe": ../git: is a directory

After deleting that folder, t0000-basic passes again. As does your
test. So now I've got to figure out what is different between your
test and mine. Perhaps I misdiagnosed to begin with?
