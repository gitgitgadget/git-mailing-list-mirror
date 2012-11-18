From: =?ISO-8859-1?Q?J=F6rg_Rosenkranz?= <joerg.rosenkranz@gmail.com>
Subject: Re: Local clones aka forks disk size optimization
Date: Sun, 18 Nov 2012 18:18:56 +0100
Message-ID: <CAKs0BQ7++Zqn7j=vKW3jLsi8y6UMRXXp5Jk6FsEWGzRaC+EGdg@mail.gmail.com>
References: <CALZVapmG+HL0SQx8zx=Cfz5pWv84hJq90x-7VdjA0m2Z4dC34A@mail.gmail.com>
	<CALZVapmO61d8yXfXXGx6Qc444ka+8n7HabuNRt0rJdE5qy_7aQ@mail.gmail.com>
	<CAKs0BQ7RyLZr+ZU=hAC4U7xXpE0+xvORTrvfzFYb6muA2TgM4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Javier Domingo <javierdo1@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 18:19:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta8Wa-0005jF-P9
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 18:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312Ab2KRRS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 12:18:57 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46083 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab2KRRS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 12:18:57 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so4202442obb.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 09:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3z/VZ6XoYIH2Y+/7zMI1giRGLzbz292OYApXQ7mIAHk=;
        b=b93LXMLwqdu19VTGttDgStC7C/AgG8g4VrkxZq/w7gdJCEgUzUPrmgBDceGbYu+gRP
         Vfpd8f6DB6UlsiQg69I/51MeY7sSVPKkzS5lSwX0nwV6YfihdvldpvMtRcp0ccrZqQLC
         PEmWs6NUfPghIgo5/p79OLisK0R1lDzfx7SCPgiRq0YEKR6gQ/24C9Q/legT3VldyDHh
         5KizMFrScaubZgElcXMqykX0qs7u87CVw1V2EcsZvk2frDoGMtlSDbxXkNe063K7R2Ik
         ahyVYPbje+iHqp5c2kMJrYP7Y0bwypvBQwn+mKYgBzZcitquKWrK+hBbMvXECLL5FUYe
         TMNQ==
Received: by 10.60.171.201 with SMTP id aw9mr8498191oec.126.1353259136578;
 Sun, 18 Nov 2012 09:18:56 -0800 (PST)
Received: by 10.60.10.41 with HTTP; Sun, 18 Nov 2012 09:18:56 -0800 (PST)
In-Reply-To: <CAKs0BQ7RyLZr+ZU=hAC4U7xXpE0+xvORTrvfzFYb6muA2TgM4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210035>

2012/11/15 Javier Domingo <javierdo1@gmail.com>
>
> Is there any way to avoid this? I mean, can something be done in git,
> that it checks for (when pulling) the same objects in the other forks?


I've been using git-new-workdir
(https://github.com/git/git/blob/master/contrib/workdir/git-new-workdir)
for a similar problem. Maybe that's what you're searching?

Joerg.
