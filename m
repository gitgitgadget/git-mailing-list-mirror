From: Thore Husfeldt <thore.husfeldt@gmail.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Tue, 19 Oct 2010 20:43:17 +0200
Message-ID: <0B20EFC4-E613-4D4A-B4F8-8B1750AA8AFD@gmail.com>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com> <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com> <20101019175103.GA28847@kytes> <20101019182845.GE25139@burratino> <AANLkTi=DXH1WwGJ-h6s3dFfWZZ3tpu_jQgV1Y9O7c6Xf@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 19 20:44:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8HAF-0003mv-H6
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 20:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756204Ab0JSSnX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 14:43:23 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56153 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755284Ab0JSSnW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Oct 2010 14:43:22 -0400
Received: by eyx24 with SMTP id 24so138857eyx.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 11:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:mime-version
         :subject:from:in-reply-to:date:content-transfer-encoding:message-id
         :references:to:x-mailer;
        bh=lsFUQvAdFVWEvDJnkdcIRSs2kRUWkGKr09j6SzHAmnU=;
        b=Y+CYF8XyidQFUFpWZteRCeuZZr60NE0/Fyp3V5YsvrRuXku9iB1HNCa3afbxV5cJCe
         YTdv6mCVSernhGdn3o+EnLZ0kJ4cl495WVCz0rwsz3JOQWu/KxHKYjFJqg4KYV+XPaVa
         UW8mmVhXcHGAfsb3YXWibaJVZnEmz/42Qhows=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=KnuIik80Wpv81XzfjQIoBRSlnLIOuNXneAe4ajRF+BelB5m++4LlqSVV0AgrcfNwQQ
         oExcEn8+JjT+HrJ1DaT/AKaoyM7YONKXLEz7WvOjmIsTcz/KRoOAanZXfUQLIyaeTTk/
         /MiAb10eG8EMMFy2m5Xr0sTXHEL3/l26ymwLY=
Received: by 10.14.47.78 with SMTP id s54mr4208242eeb.21.1287513800858;
        Tue, 19 Oct 2010 11:43:20 -0700 (PDT)
Received: from [10.0.1.4] (h51baf259.k2290.dyn.perspektivbredband.net [81.186.242.89])
        by mx.google.com with ESMTPS id q51sm10530006eeh.22.2010.10.19.11.43.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 11:43:19 -0700 (PDT)
In-Reply-To: <AANLkTi=DXH1WwGJ-h6s3dFfWZZ3tpu_jQgV1Y9O7c6Xf@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159351>

Also, in the user-manual.txt:

> Examining branches from a remote repository
> -------------------------------------------
>=20
> The "master" branch that was created at the time you cloned is a copy
> of the HEAD in the repository that you cloned from.  That repository
> may also have had other branches, though, and your local repository
> keeps branches that track each of those remote branches, which you
> can view using the "-r" option to linkgit:git-branch[1]:
>=20
> ------------------------------------------------
> $ git branch -r
>   origin/HEAD
>   origin/html
>   origin/maint
>   origin/man
>   origin/master
>   origin/next
>   origin/pu
>   origin/todo
> ------------------------------------------------
>=20
> You cannot check out these remote-tracking branches, but you can
> examine them on a branch of your own, just as you would a tag:

That=92s just wrong, isn=92t it? You absolutely can check out a remote-=
tracking branch.