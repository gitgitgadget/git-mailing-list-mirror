From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: Git GSoC 2014
Date: Fri, 14 Feb 2014 18:53:02 +0100
Message-ID: <CAFFjANTSy3_2yNv=og71RmVWV2ET76gD0XHFA+QRM0boCruDrg@mail.gmail.com>
References: <20140213091037.GA28927@sigill.intra.peff.net> <87bnya8z6q.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Fri Feb 14 18:53:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEMx6-0005w2-J7
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 18:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbaBNRxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 12:53:25 -0500
Received: from mail-vc0-f178.google.com ([209.85.220.178]:51739 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbaBNRxY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 12:53:24 -0500
Received: by mail-vc0-f178.google.com with SMTP id ik5so9486652vcb.37
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 09:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=20E+sgizyOBYBJlAUZHAMzZJlVKd5UPSeg4o7YKgAOo=;
        b=vzMSrkISdNaycPITqiv8ke5VdU4+M9oC06fji9CGSbGlZaqxF/GdWKZi96Ax4CxGrt
         S99ty37rXQAtQtWthwcbohocNBOp3B6i5YL4YlPEvvFsZqF7zM908/vLxaA4weWy7FB3
         p9BnF4AOyWRGj+YV1N0Vc75r2dq78pnp57vTg92crWAxeL2wtZsZrXgXVa8qhCPrVozs
         /loq5wVkdfeNlMxELIegWAofr8cCbnClFUBAhy3N5t8tnX41qKLRH6wi5iIB/7BtfXEY
         jMZr3SPxUhYFqlL40VyHxeDg5mY2gKleUzPhO/9wiFKHjNGzyGO7qNOt6aEtJZx82jDB
         EPZg==
X-Received: by 10.52.104.68 with SMTP id gc4mr5171159vdb.2.1392400403264; Fri,
 14 Feb 2014 09:53:23 -0800 (PST)
Received: by 10.220.133.73 with HTTP; Fri, 14 Feb 2014 09:53:02 -0800 (PST)
In-Reply-To: <87bnya8z6q.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242116>

On Thu, Feb 13, 2014 at 10:45 PM, Thomas Rast <tr@thomasrast.ch> wrote:
> Replace object loading/writing layer by libgit2
>
> Git reads objects from storage (loose and packed) through functions in
> sha1_file.c.  Most commands only require very simple, opaque read and
> write access to the object storage.  As a weatherballoon, show that it
> is feasible to use libgit2 git_odb_* routines for these simple callers.
>
> Aim for passing the git test suite using git_odb_* object storage
> access, except for tests that verify behavior in the face of storage
> corruption, replacement objects, alternate storage locations, and
> similar quirks.  Of course it is even better if you pass the test suite
> without exception.
>
> Language: C
> Difficulty: hard
> Possible mentors: Thomas Rast and <fill in libgit2 expert>

Note that we have several people in the libgit2 team that are willing
(and excited) to mentor or co-mentor this project or any of the other
libgit2 related projects that have been proposed.

Prospective list is

- Vicent Marti
- Russell Belfer
- Ed Thomson
- Carlos Martin (past GSoC student)

So there shouldn't be any mentor shortage.

Cheers,
vmg
