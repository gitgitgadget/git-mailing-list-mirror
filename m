From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: git pull (Your local changes to ... would be overwritten by 
	merge)
Date: Thu, 17 Jun 2010 11:46:26 +0200
Message-ID: <AANLkTimakxkEzFHSwezpXelLV171zGFEQULNEVpJlrah@mail.gmail.com>
References: <AANLkTinokUxiDdetcrsrlSExQ7hmhLS5szbTt9KzGKr_@mail.gmail.com>
	<AANLkTimeIWseETfYiMajIqesjJ_p55pRislnQQIaCrbG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Blendea <bdaniel7@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 11:46:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPBg8-0005iO-Ur
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 11:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932804Ab0FQJq2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jun 2010 05:46:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:49568 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759231Ab0FQJq1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 05:46:27 -0400
Received: by fg-out-1718.google.com with SMTP id l26so1914935fgb.1
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 02:46:26 -0700 (PDT)
Received: by 10.102.242.22 with SMTP id p22mr3380929muh.44.1276767986391; Thu, 
	17 Jun 2010 02:46:26 -0700 (PDT)
Received: by 10.103.213.14 with HTTP; Thu, 17 Jun 2010 02:46:26 -0700 (PDT)
In-Reply-To: <AANLkTimeIWseETfYiMajIqesjJ_p55pRislnQQIaCrbG@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149294>

On Thu, Jun 17, 2010 at 11:35 AM, Daniel Blendea <bdaniel7@gmail.com> w=
rote:
> Hello,
>
> A while ago I have cloned on my computer a git repo.
> Since then, the developers have modified several files in the repo.
> Now I want to update my copy with the latest changes.
>
> I do 'git pull' but I get 'Your local changes to .... would be
> overwritten by merge.=A0 Aborting.'
> I didn't modified any local file. I tried using 'git stash save' but =
no luck.

Are they known to git? What is their status (git status)?

If they are not known to git, it seams that there are *new* files both
in the remote branch and the working copy (new files in the working
copy are not saved with 'git stash save').

I would rename/mv the conflicting new files in the working copy,
perform the pull and maybe compare the new files from the branch with
the ones from the working copy.

HTH,
Santi
