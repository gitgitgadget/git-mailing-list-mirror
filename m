From: Hans-Juergen Euler <waas.nett@gmail.com>
Subject: Re: git-svn problems with white-space in tag names
Date: Sun, 27 Jan 2013 15:12:27 +0100
Message-ID: <CAK3CF+46a2LsrZ0ef5Bc2XfwCVv1LVk6YbMasa6e5kx-Dp3JTg@mail.gmail.com>
References: <CAK3CF+4GPKBfAmgsHYnf_6nCCOCe-1d31cGsWp4jkKC28cZr0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 15:12:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzSyZ-0006lx-M7
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 15:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184Ab3A0OMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 09:12:31 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:44873 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938Ab3A0OM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 09:12:29 -0500
Received: by mail-wi0-f169.google.com with SMTP id hq12so805543wib.2
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 06:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=LVtuaZ3+ixaF8Rgy4rbUmYreXVzNyAkUz0wqRZWBDmI=;
        b=i+MFr0zKQbb15Hsu0d5wtbfwu3F/Yw3SGPdzO4Ztz7aHIyrX8/aPy4EKo7ePxvE3O/
         nr928kdNQP3QQjbDOgKsB8kmr6Xscnworly4KuNMkR1T8A5Q9UiCoBMI0k7JRYwwvbCV
         biMMGSeeo6LLqtyhJxNjdlmS2WZTStCBVbhZtYgp+C/DDM3CDMXDSbjkfmz13vzLAPls
         cPgHyeWzcAU0KD4CnMLDdLfTplva91Hb1l+N40l+FXVx1OcC/78MbiFtdjEgCyo3N+iB
         9j2Ca1EwWT7j76izrztPEKuvd1zuo0PttQpKwS+v5B9d0W4vxUQTc1BjM2CYI8DzdwCP
         e7cg==
X-Received: by 10.180.78.66 with SMTP id z2mr5340906wiw.23.1359295948007; Sun,
 27 Jan 2013 06:12:28 -0800 (PST)
Received: by 10.194.221.232 with HTTP; Sun, 27 Jan 2013 06:12:27 -0800 (PST)
In-Reply-To: <CAK3CF+4GPKBfAmgsHYnf_6nCCOCe-1d31cGsWp4jkKC28cZr0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214699>

This seems to be a problem of the windows version. At least with its
complete severity. Installed git on Ubuntu in a virtual machine was
able to clone the subversion repos past the tag with the white-space
at the end. I am not sure but apparently this tag has not been
converted.

The git repos I could copy from Ubuntu to windows. So far no problems
seen in this copy on windows.

2013/1/23 Hans-Juergen Euler <waas.nett@gmail.com>:
> I have discussed already the problem a bit more in this thread
> groups.google.com/d/topic/git-users/kfMFZ3uEFsM/discussion
>
> -----Operating system (specifically which version)
> windows 7 64 bit
>
> ------Git version (git --version)
> Git version 1.8.0 for windows obviously.
> git bash and git gui installed and using
>
> ------Git configuration (system, home, repository)
> hmm guess is covered with git bash and git gui. Using the standard config stuff
>
> using subversion
> TortoiseSVN 1.7.11
> Subversion 1.7.8
> Was typically always up-to-date (within 2 months or so) with previous versions
>
> using an external subversion provider for storing the information
> externally. guess the version there is older but do not know
>
>
> I have tried to convert some of my external subversion data bases with
> git-svn clone
>
> I have encountered a problem with one of my subversion repos. I have
> obviously introduced about 2 years ago a problem with an additional
> white space at the end of tag name.
>
> So there is an entry "tags/blabla "
>
> in the subversion repos. The sequential handling of the svn repos with
> git-svn gets stuck there. I could not find a way around this. My guess
> is that the white-space was introduced by accident on windows by
> Tortoise-SVN.
> Unfortunately this occurs at revision 90 something and I have almost
> 1000 revisions stored.
>
> Let me know if you need more details.Thanks.
