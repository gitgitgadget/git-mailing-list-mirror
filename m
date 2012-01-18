From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: found some code...
Date: Wed, 18 Jan 2012 12:16:49 +1100
Message-ID: <CAH5451k4bMJtMLsaFi6g_uRGTL0OdQ5Z1Pss3xuMdWYs+6VcLQ@mail.gmail.com>
References: <loom.20120118T015734-175@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ron Eggler <ron.eggler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 02:17:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnK9M-0007Ug-Uj
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 02:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396Ab2ARBRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 20:17:12 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61365 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754181Ab2ARBRL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2012 20:17:11 -0500
Received: by lahc1 with SMTP id c1so1890054lah.19
        for <git@vger.kernel.org>; Tue, 17 Jan 2012 17:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=atB58XHeisBnDcdw5ftgtswuHVeOOA7nI+g8QGGC7qU=;
        b=W483eEBTmsN7pH/MpjAABinLixfTHHIL3ahwwNvXSPF5OPi8DEh5m2xJXuP1apWp3o
         +c4AcUE0Y4Az/Lo9rdHRiX99rt+mLg8kovLwBUUkqHEZD+yJeNmRxk9kAoQmVYHIz0XA
         Ht91JTGBGUViBax3FrqjIWibe/5kggZaMhoj8=
Received: by 10.112.100.199 with SMTP id fa7mr4668656lbb.89.1326849430267;
 Tue, 17 Jan 2012 17:17:10 -0800 (PST)
Received: by 10.152.14.71 with HTTP; Tue, 17 Jan 2012 17:16:49 -0800 (PST)
In-Reply-To: <loom.20120118T015734-175@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188732>

Hi Ron,

On 18 January 2012 12:02, Ron Eggler <ron.eggler@gmail.com> wrote:
> Hi There,
>
> Some mishap had happened with my project:
> I found a piece of code that is the most recent one that never got commited to
> the repository. It is dated December 5th and it definitely is the most recent
> piece of code.
> Now in the mean time I switched computers so I had to reinstall git and get
> create new local folders. Now this directory with the most recent code, shows
> every file as unversioned which should not be true.
> Only a couple, maybe 3 files had changed with that last change. Now when I commit
> this now, is that gonna mess up my old repo or can I safely gio ahead and commit
> that most recent code (even tho it might commit the whole folder) - it almost
> seems like it forgot which files
> were in the repo vs. which files were in my local folder...
>
> Thanks for hints and suggestions how I get myself cleanly out of this mess!
> Thanks,
> Ron
>

Out of interest, how did you transfer the existing code onto the new
machine? In particular, did you clone the existing repository using
git clone, or using some other method (such as zipping/emailing)? If
it was not via clone, did you copy the .git subdirectory, or did you
recreate it?

Is the old repository (on the old computer) still available?

Regards,

Andrew Ardill
