From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: checkout on an empty directory fails
Date: Thu, 5 Jan 2012 16:37:16 +0530
Message-ID: <CALkWK0knVa3V9mX86WhmXmC3_SBPitgAzh_9RAXmWeQcgf=hRw@mail.gmail.com>
References: <4F0576D9.4030207@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?UmVuw6kgRG/Dnw==?= <doss@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 05 12:07:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RilAd-0002jL-7M
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 12:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757121Ab2AELHj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 06:07:39 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:34805 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892Ab2AELHi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2012 06:07:38 -0500
Received: by werm1 with SMTP id m1so265132wer.19
        for <git@vger.kernel.org>; Thu, 05 Jan 2012 03:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kDN+fno9N+UxR63+KLYyKdz8JGhRmOHWDNODh0sJLrY=;
        b=Ww+RPI9WzTyb4LXhBH601VcQ/2uJHj8n4KSMXt0wrf/fyA08kqejsCGhZR0tVCQZlk
         k/dOY9sWs55kfudizDZBgyfrkVxzAixtJbeJummC7Tle+fBFRJjVnA9Yl9zl2JUp8FMg
         tNdhkiDq7pq8iRMAS+2FI9hnYrQcLiORAm9Bk=
Received: by 10.180.93.35 with SMTP id cr3mr465835wib.0.1325761657368; Thu, 05
 Jan 2012 03:07:37 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Thu, 5 Jan 2012 03:07:16 -0800 (PST)
In-Reply-To: <4F0576D9.4030207@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187970>

Hi Ren=C3=A9,

Ren=C3=A9 Do=C3=9F wrote:
> I have a clean derectory ang the git database. Now I want check out t=
he
> master.
> [...]
>
> red@linux-nrd1:~/iso/a> ls -a
> . =C2=A0.. =C2=A0.git
> red@linux-nrd1:~/iso/a> git checkout master
> D =C2=A0 =C2=A0 =C2=A0 SP601_RevC_annotated_master_ucf_8-28-09.ucf
> [...]

In such situations, "git status" usually has something helpful to say.
 You're already on the "master" branch, and you can reset your
worktree with `git reset --hard` (caution: please read the manpage).

-- Ram
