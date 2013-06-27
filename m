From: Johan Herland <johan@herland.net>
Subject: Re: device files should be handled by git
Date: Thu, 27 Jun 2013 15:24:00 +0200
Message-ID: <CALKQrgckBB0Nkf0k9iNcoH2fpqPREEWLrL9eXsZXGK1g=yt-iQ@mail.gmail.com>
References: <21095513-708E-4F82-88D0-A312B74BA7F4@mac.com>
	<20130627130842.GB27497@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Perry Wagle <wagle@mac.com>, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 15:24:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsCBM-00021E-Ab
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 15:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258Ab3F0NYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 09:24:07 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:56939 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab3F0NYF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 09:24:05 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UsCBA-000LUa-Ks
	for git@vger.kernel.org; Thu, 27 Jun 2013 15:24:04 +0200
Received: from mail-ob0-f171.google.com ([209.85.214.171])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UsB0a-000Lkv-IU
	for git@vger.kernel.org; Thu, 27 Jun 2013 14:09:04 +0200
Received: by mail-ob0-f171.google.com with SMTP id dn14so719545obc.16
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 06:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ROPqr2BiC6gjo1hIy2NYXG3qFdaX3p1GpZYAX/inank=;
        b=JWbZZ07Sy6GycAT0+9hZV4trczHnK9W9O/znj+VHbCBDQ8oL6c/Jn1DyGBix9n5o9z
         WOBqizV2wT+wbZUjX/sdpvIwG1zBoHv+0cDhX5a5GV5ylyC96eyeutI+a8V3z/pO1Syg
         15d+4gd/vbAQRsrFcCH/0Ra3lmeBfRvhRtvH7zksoEhIiiSkoUC8eLbzQ0mWSCdrEhBf
         r47qNB2OPYVOr3oIvyJ/GUQckrF9S/ToGpRwJi3B+3EhgEjfWqwxqI34LT3PsUxwvGFD
         3dHdufUnmJNJFgCatxnh+7I4Pf0Dexsbb1UThJRqTVrH/giw1stKvIvgXaUXI1IDK984
         pTyw==
X-Received: by 10.182.66.77 with SMTP id d13mr4168469obt.32.1372339440946;
 Thu, 27 Jun 2013 06:24:00 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Thu, 27 Jun 2013 06:24:00 -0700 (PDT)
In-Reply-To: <20130627130842.GB27497@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229101>

On Thu, Jun 27, 2013 at 3:08 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Wed, Jun 26, 2013 at 08:27:56PM -0700, Perry Wagle wrote:
>> Is there a reason not to handle device files other than "its not traditional"?  That's the only reason given in google or the IRC channel.
>
> In linux you can't create device files if your not root. On windows
> those files won't even exists (afaik).
>
> Wouldn't this be very unportable and hard to use (meaning that you need
> to handle your git repo as root or give git setuid root)?

Device files will probably never be supported by Git for the reasons
mentioned by Fredrik. If anything, etckeeper
(http://joeyh.name/code/etckeeper/) would be a much more appropriate
place to support this, although I don't think it currently does.
Alternatively, you could follow the suggestions of
http://superuser.com/questions/440873/git-unable-add-device-file (and
elsewhere), and write a script for generating the device files, rather
than storing them as-is.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
