From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file descriptor
Date: Fri, 11 Jan 2008 23:19:45 +0100
Message-ID: <e5bfff550801111419o33a8904ajcf295417d3499bde@mail.gmail.com>
References: <4787E981.7010200@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, drafnel@gmail.com
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jan 11 23:20:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDSEZ-0000bm-79
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 23:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761117AbYAKWTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 17:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761597AbYAKWTr
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 17:19:47 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:54182 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761102AbYAKWTr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 17:19:47 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1067294rvb.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 14:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=o+5CCL9e9j2Dg3Ym4tYBhcPWrtBQO7cwZxhEhfCWrfY=;
        b=kFcJZW6fniuakfhuFPUwq+cfdHPUT7rF1j2qpOi4tiFdz1sRi7zGvUzaqVpIuDWFYx8pZi9kH65is2Ngyv7+qP9z5bOgmEiUPEqfgxd0PU6xNreGbYN8l08fYUp2xtX0bfF66FwddkUJG6VUO1A9q/FL09uOTBH7O1exhwStors=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r3dnnp5x4e8iiam1uz9QDFyRnWZ3RjAcFSDEXX8jP0dSH5jyhteBBpIdME4dwkx6uZXN3vlyhMBJHs+lN7PC6ZVz8BbZ5OHpDmOZwJzsSPfbsM3VKAj3laZoInsGe9eNtkIK6d2qVAs2Imcnu3BPCsnV/OpjvspUwy13D/4Ow+c=
Received: by 10.141.88.3 with SMTP id q3mr2349058rvl.94.1200089985784;
        Fri, 11 Jan 2008 14:19:45 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 11 Jan 2008 14:19:45 -0800 (PST)
In-Reply-To: <4787E981.7010200@nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70216>

On Jan 11, 2008 11:11 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>
> I got this message from git-commit:
>
> $ git commit -a
> <edit message, :wq>
> fatal: Out of memory? mmap failed: Bad file descriptor
> Create commit <my_prompt_string>
>
> The exit status was 128.
> Looks like the commit was successful though.
> The partial message 'Create commit ' comes from print_summary()
> in builtin-commit.c which is _after_ the actual commit.
>
> $ git --version
> git version 1.5.4.rc2.84.gf85fd-dirty
>

I had the same message about one week ago for few times, same
symptoms, I didn't had the time to dig it out and today it seems no
more happening.


> It was compiled with NO_CURL=1. The dirtiness comes from the
> patches I submitted for relink earlier today.
>
> The other possible clue is that this repo is on NFS.
>

I don't use any NFS mount.


Marco
