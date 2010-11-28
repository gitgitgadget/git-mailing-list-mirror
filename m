From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: how to git with google code
Date: Sun, 28 Nov 2010 15:18:22 +0800
Message-ID: <AANLkTi=1vVBiHeoYGzY+0Y6w7zXc3yhgZUHRH_v7ZauV@mail.gmail.com>
References: <AANLkTi=5muNrriBoU0ZGnMqQUOjrJAvwLfyYO07-Ad3m@mail.gmail.com>
	<4CEFCE5E.1050003@drmicha.warpmail.net>
	<AANLkTik_HMVsHuvA00ZCcGJaOS_m8Tipq_fDyLucG9wN@mail.gmail.com>
	<AANLkTi=kuAkJSeJAWYQokOM2NFo08_98Eoodw_cz_c0r@mail.gmail.com>
	<AANLkTimSdCOqC_nyLi4FsHPcJ+L9CnYzFK5OyQBoWUC7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Bond <jamesbond.2k.g@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 28 08:18:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMbWo-0005qa-Nv
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 08:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729Ab0K1HSY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Nov 2010 02:18:24 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55918 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab0K1HSY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Nov 2010 02:18:24 -0500
Received: by eye27 with SMTP id 27so1474743eye.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 23:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dtvwiyrwcKZwE4fyEqCtpEnsIwLGQ+o/QCKTc9KXczc=;
        b=lvmHirST0qbTjd5UxCbB2+L8XygE7m6hOk/jQBehyjn/O8BuByArZYPIbaSyyq5Aw+
         JNyKjYkLQm8XfmbkYck2xg0ancDUfXTjM9+BkcjQQZv5PYNvlyil6rO1P8ySPYUh7/bt
         zK5h5bOThxx3lVn/MPfeTp0XU9GhsAQHRczVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B/MzBmn0tqWvbZEpXxY+c9xMOsxdk+xvDMWAYdxshISurvDD5YZSaiqO53UwEZ9F7H
         xLw2rPp6XE/BBjzJeFB7Bm66TAdslnXzrvd0QLW9efBtk8kKd3A0Zz5WPdafo1JoZrSG
         /9cQGKutRCB9SXFrb7Mx8QBCkNRi00wYM5NAg=
Received: by 10.213.13.3 with SMTP id z3mr5381666ebz.28.1290928702508; Sat, 27
 Nov 2010 23:18:22 -0800 (PST)
Received: by 10.213.112.195 with HTTP; Sat, 27 Nov 2010 23:18:22 -0800 (PST)
In-Reply-To: <AANLkTimSdCOqC_nyLi4FsHPcJ+L9CnYzFK5OyQBoWUC7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162337>

On Sun, Nov 28, 2010 at 12:36 PM, Bond <jamesbond.2k.g@gmail.com> wrote=
:
> On Sun, Nov 28, 2010 at 9:57 AM, Tay Ray Chuan <rctay89@gmail.com> wr=
ote:
>> Hi,
>> You can take "official source tree" and "Git-capable server" to be
>> your git repo that you git init-ed in your first post. But it's empt=
y
>> isn't it? So, just skip the "git fetch" step. That leaves:
>>
>> =A0$ git svn clone ...
>> =A0$ cd trunk
>>
>> Then go on from there.
> What do I do from that is what I asked in first post of this thread?

Assuming you did

  $ git svn clone http://svn.googlecode/url/to/your/repo

You'd have a git repo that is "linked" to the Google Code svn repo.
Now go inside the git repo and do whatever you want. That was what I
thought you were looking for in this thread.

But if you need advice on "how to do stuff in git", (eg. adding files,
commit, push), just google for a git tutorial, I'm sure there are some
pretty good ones out there.

--=20
Cheers,
Ray Chuan
