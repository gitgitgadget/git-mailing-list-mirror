From: Nico Weber <thakis@chromium.org>
Subject: Re: Git woes
Date: Thu, 27 Aug 2009 14:06:21 -0700
Message-ID: <ca36ec440908271406t214fee11hed2c5e6da0e5ac0@mail.gmail.com>
References: <ca36ec440908262242l6e818c28gd7b0daff2b537d4@mail.gmail.com>
	 <f4f35435-79b7-46c2-8c2d-2d4c4deb68c4@s15g2000yqs.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 23:06:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgmB0-0002Ek-T3
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 23:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbZH0VGZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2009 17:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbZH0VGZ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 17:06:25 -0400
Received: from smtp-out.google.com ([216.239.45.13]:62167 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbZH0VGY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 17:06:24 -0400
Received: from spaceape14.eur.corp.google.com (spaceape14.eur.corp.google.com [172.28.16.148])
	by smtp-out.google.com with ESMTP id n7RL6PLn004816
	for <git@vger.kernel.org>; Thu, 27 Aug 2009 14:06:26 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1251407186; bh=49Oykk0oDFErqX7OMuIrtW4HnY4=;
	h=DomainKey-Signature:MIME-Version:Sender:In-Reply-To:References:
	 Date:X-Google-Sender-Auth:Message-ID:Subject:From:To:Content-Type:
	 Content-Transfer-Encoding:X-System-Of-Record; b=StZb9gRtKpydlM5aVh
	j91dq/02DwkQbJz6+vujlGTeD8r2Zjue7g832s/xAcmVPYAwakU/FO1jR8+fYG87z0x
	A==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=mime-version:sender:in-reply-to:references:date:
	x-google-sender-auth:message-id:subject:from:to:content-type:
	content-transfer-encoding:x-system-of-record;
	b=dLs4k2r6es8fEqqan1ITayAWtnOCihmUicfqFXI9Ysr/N8pAcwmTaEWMmnpPFagsd
	m7FRdai0ZtO0jnk8Q/QRw==
Received: from wa-out-1112.google.com (wagm33.prod.google.com [10.114.214.33])
	by spaceape14.eur.corp.google.com with ESMTP id n7RL6M3a014156
	for <git@vger.kernel.org>; Thu, 27 Aug 2009 14:06:22 -0700
Received: by wa-out-1112.google.com with SMTP id m33so285468wag.13
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 14:06:22 -0700 (PDT)
Received: by 10.140.144.2 with SMTP id r2mr249726rvd.0.1251407181982; Thu, 27 
	Aug 2009 14:06:21 -0700 (PDT)
In-Reply-To: <f4f35435-79b7-46c2-8c2d-2d4c4deb68c4@s15g2000yqs.googlegroups.com>
X-Google-Sender-Auth: c6702a509402b08f
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127211>

Hi git list,

Alex Riesen asked me to forward this to this list.

On Thu, Aug 27, 2009 at 1:52 PM, Alex Riesen<raa.lkml@gmail.com> wrote:
> On Aug 27, 7:42=A0am, Nico Weber <tha...@chromium.org> wrote:
>> Trying to pull:
>>
>> thakis-macbookpro:~/src/chrome-git/src thakis$ git pull
>> remote: Counting objects: 1859, done.
>> remote: Compressing objects: 100% (1267/1267), done.
>> remote: Total 1393 (delta 1087), reused 195 (delta 107)
>> Receiving objects: 100% (1393/1393), 2.57 MiB | 781 KiB/s, done.
>> fatal: cannot pread pack file: No such file or directory
>> fatal: index-pack failed
>
> You're on MacOSX, right? What version of git are you running?
> Where do you pull from? (So it can be reproduced)
>
> If you can provide this information, then maybe send it to the
> Git mailing list (git@vger.kernel.org, no subscription required),
> or at least back to me? Maybe you can strace (is it possible
> on MacOSX?) the "git pull" (because pread never returns
> ENOENT) and attach the trace as well?
>
> Sorry for asking you off-list, but I noticed your problem
> really accidentally (by browsing the list's archives), and
> not sure I am prepared to deal with the list's traffic.
>

Yes, I'm on OS X 10.5.8.

I'm pulling from git://git.chromium.org/chromium.git. This worked fine
for the last month or so, I had the problem for the first time
yesterday evening.

$ git --version
git version 1.6.0.2

Sadly, I fixed the problem accidentally by running something like

  rm -rf .git/svn/
  git svn fetch; git merge trunk
  git merge refs/remotes/origin/trunk
  git checkout -f HEAD
  git pull

(if that looks like I don't know what I'm doing, you're right)

If it happens again, I'll post a dtrace to this list.

Nico
