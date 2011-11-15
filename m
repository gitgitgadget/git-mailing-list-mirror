From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git 1.7.5 problem with HTTPS
Date: Tue, 15 Nov 2011 07:03:52 -0800
Message-ID: <CAJo=hJvdstr39suGMwxNoT+_cKThxsEYHi96eqja7HuHyPmhWA@mail.gmail.com>
References: <CACf55T6BGds_D=nbb8G=m+Jwr+bHFruCs-Q0+FOO+WXitXEJ-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 16:04:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQKYe-0007Tj-Cl
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 16:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab1KOPEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 10:04:15 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35754 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761Ab1KOPEO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 10:04:14 -0500
Received: by yenq3 with SMTP id q3so697019yen.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 07:04:14 -0800 (PST)
Received: by 10.146.236.17 with SMTP id j17mr1219794yah.10.1321369453297; Tue,
 15 Nov 2011 07:04:13 -0800 (PST)
Received: by 10.147.124.5 with HTTP; Tue, 15 Nov 2011 07:03:52 -0800 (PST)
In-Reply-To: <CACf55T6BGds_D=nbb8G=m+Jwr+bHFruCs-Q0+FOO+WXitXEJ-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185461>

On Tue, Nov 15, 2011 at 05:52, Dmitry Smirnov <divis1969@gmail.com> wrote:
> I have problems with downloading Android code from android.googlesource.com.
>
> The error says: fatal: branch stable is not signed
>
> I was trying to figure out what happens and finally came to conclusion
> that this is a problem of the git.

Not likely. This is an error printed by the "repo" tool used by
Android. It typically indicates the repo command you are executing is
pointing to a URL that may be a local mirror and contain additional
patches in it that were not signed by me.

I would suggest starting over by downloading repo per [1] and using
that script to start the process.

[1] http://source.android.com/source/downloading.html

> When I try to clone the git itself using https
> (https://git.kernel.org/pub/scm/git/git.git) I'm getting the follwing
> error:
> warning: remote HEAD refers to nonexistent ref, unable to checkout.
>
> If I use the http URL (http://git.kernel.org/pub/scm/git/git.git) I
> can clone with no problems.

This may be a problem with the git.kernel.org HTTP server. It is
probably not a problem with Git itself.
