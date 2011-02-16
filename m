From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: Corrupted git repository?
Date: Wed, 16 Feb 2011 20:21:47 +0100
Message-ID: <AANLkTimkMSxwkEJGgVrOEOSNFd34DypUQita8n=9jiS0@mail.gmail.com>
References: <AANLkTimMon7ztbyT26YhotiZ=jd=QpNTvOkPCKwHg+e_@mail.gmail.com>
	<7vk4h1nk3x.fsf@alter.siamese.dyndns.org>
	<AANLkTimZgpWUAncLgO=y5CvKsYGdYWTHNUzncjrC5UO6@mail.gmail.com>
	<201102161954.26766.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Feb 16 20:22:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppmwm-00039w-HQ
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 20:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785Ab1BPTVu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 14:21:50 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40897 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670Ab1BPTVs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 14:21:48 -0500
Received: by vws16 with SMTP id 16so757776vws.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 11:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XiyfOOsh4y2NoY8gPJRuFWmmnbh9LBoOizRsxRGOAGY=;
        b=TnT4bBBEjOlUSDNJzr0qzXfSDTa8ncn6oJwjifSxBajfGWncobcHwp+g9n/0g/P5oZ
         8PsSfPDxTwm/hpceXmLrdyjxMHtn5zQUegRoP7d0mWdgSTSF9buCjVby4bQDwlMp471+
         UxJJYSwMMHsfY5vqYk1adM1Q8KBu1a3NoV+HU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Z2HYb8b4bT3PkbZMgbKII+yOklXkDNPPm/H+iGUDl1SWmRM2pbWUwE41CVJPXcLNaP
         FpuKyArmh+jMITGMkF7vKLKHS9PwdPYd4y2VxyDI3IMtOkNrnqHxJ/qSYPw0L2JtNguq
         458haQ1mVGnVtFgZo5A5OdxeuMOTfxqMq4BQs=
Received: by 10.220.194.4 with SMTP id dw4mr192921vcb.141.1297884107318; Wed,
 16 Feb 2011 11:21:47 -0800 (PST)
Received: by 10.220.195.132 with HTTP; Wed, 16 Feb 2011 11:21:47 -0800 (PST)
In-Reply-To: <201102161954.26766.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166989>

On Wed, Feb 16, 2011 at 7:54 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Mittwoch, 16. Februar 2011, Piotr Krukowiecki wrote:
>> I have deleted the whole top-level directory in which the file was a=
nd run:
>>
>> $ git status | grep =A0<<PATH>>
>> # =A0 =A0 deleted: =A0 =A0<<PATH>>
>>
>> $ git checkout -- <<top dir>>
>>
>> $ git status
>> # On branch master
>> nothing to commit (working directory clean)
>>
>> $ git cherry-pick 7d193bb0c1f14908361d9d9d5e30f0c12d5f2c2f
>> error: Your local changes to the following files would be overwritte=
n by
>> merge: <<PATH>>
>> Please, commit your changes or stash them before you can merge.
>> Aborting
>
> A wild guess: You are on Windows or OS/X, and the file exists in your=
 worktree
> with different uppercase/lowercase name? Rename the file so that its =
case is
> the same as it is recorded in the repository.

Nope, I'm on linux with case-sensitive file system.

Some commits to svn repository are coming from windows. But the cherry-=
picked
one was my commit from linux. It was first done in git, then dcomitted
to svn and
then I tried to merge it to git branch - that failed.


--=20
Piotrek
