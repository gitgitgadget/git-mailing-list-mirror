From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: .gitignore Bug Report on the behavior of *
Date: Sun, 26 Sep 2010 01:27:29 +0200
Message-ID: <AANLkTi=zkyTHyw-xakhdgDBNCPfkwEgPswvCVs31Sgqn@mail.gmail.com>
References: <201009251923.o8PJNJYE031841@no.baka.org> <201009252203.48820.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Seth Robertson <in-gitvger@baka.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Sep 26 01:28:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzeA9-0002r6-Nk
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 01:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412Ab0IYX1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 19:27:50 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50957 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab0IYX1t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 19:27:49 -0400
Received: by ywh1 with SMTP id 1so1280977ywh.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 16:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=0E4DD10mASBGiyROOrTgKR6h0VhxQEtlv17STD+DdzQ=;
        b=wnyjzGB0xw6FtgkZn3SyQurK7WIvywld6lRAgy1bcz2wLykHe2F668b7yRw9StzPYx
         lVr5LYxDZeR17RqSEMhaGFITq0lsaetp/WvXHoBQANrjzQlYVaCTvdH5zFHDrZJaQA3h
         W7E+FlybLZlhIqEBquH3WF5vxJNCILbe5/E4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kdbVIk4h6I/52djs4+MDnNCNGpZ+tadac5tOfWAZCSvAQPi9JqMB/SJfdacvlGPhTS
         2YIh+0mFi/ToVW5jdvPJfpQBNBqMAaPIrRIEZ3Dgpl8IrKfRKkgbtH80JNteBgM0DOib
         vMCeiqMIXvFRFzOULDRzHyvLqKh+fE1jDQ3Qs=
Received: by 10.150.12.16 with SMTP id 16mr4279504ybl.236.1285457269100; Sat,
 25 Sep 2010 16:27:49 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Sat, 25 Sep 2010 16:27:29 -0700 (PDT)
In-Reply-To: <201009252203.48820.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157205>

Heya,

<threadjacking rant>

On Sat, Sep 25, 2010 at 22:03, Johannes Sixt <j6t@kdbg.org> wrote:
> Do you really expect git to walk down this ignored directory, just to make
> double-sure that really, really down there does nowhere exist a .gitignore
> that says "oh, wait, don't ignore *this* file"?

Yet when I (recursively for all files) 'git update-index
--assume-unchanged some-dir' it will still looking at all the bloody
.gitignore making it slow as moleasses.

</rant>

Of course, the above is an insane setup with a .gitignore file in each
and every directory. But it would be so nice if git Just Worked even
in insane cases!

-- 
Cheers,

Sverre Rabbelier
