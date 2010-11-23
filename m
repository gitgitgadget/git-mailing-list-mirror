From: Wilbert van Dolleweerd <wilbert@arentheym.com>
Subject: Re: Inexplicably deteriorating performance of Git repositories on Windows
Date: Tue, 23 Nov 2010 20:12:58 +0100
Message-ID: <AANLkTikXkWvHrc7=FjePfX5WyyNF1U=KH2DBCU+CcVu6@mail.gmail.com>
References: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 20:13:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKyId-0000Z2-Fh
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 20:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175Ab0KWTNA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 14:13:00 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60886 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867Ab0KWTNA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 14:13:00 -0500
Received: by gxk22 with SMTP id 22so230386gxk.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 11:12:59 -0800 (PST)
Received: by 10.100.142.10 with SMTP id p10mr5324963and.72.1290539579021; Tue,
 23 Nov 2010 11:12:59 -0800 (PST)
Received: by 10.100.121.6 with HTTP; Tue, 23 Nov 2010 11:12:58 -0800 (PST)
X-Originating-IP: [82.171.76.203]
In-Reply-To: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162012>

> We have a bunch of Windows users, unfortunately, and they're using th=
e
> latest msysGit release (Git-1.7.3.1-preview20101002).
>
> An interesting issue we've noticed is that the Time To Complete of
> their common operations start deteriorating inexplicably, and
> severely, some time after the clone.
>
> For instance, immediately after a clone, `git status` takes about
> 5-6s. Which is slow compared to Linux (consistent 1-2s), but still
> usable (it's a BIG repo).
>
> However, after a reboot (of all things), `git status` latency
> skyrockets to 14-15s, making the repo unusable.
>
> Any idea what's going on? =A0We just recently switched from SVN, and
> those users are getting really frustrated. BTW, the only real
> alternative I'm aware of, Cygwin's git, is even slower.

How big is your repository? We're using some fairly big repositories
over here but I haven't seen this behavior with the latest version of
msysgit.

Kind regards,

Wilbert van Dolleweerd
Blog: http://walkingthestack.wordpress.com/
Twitter: http://www.twitter.com/wvandolleweerd
