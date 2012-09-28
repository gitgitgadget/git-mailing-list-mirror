From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: git gui does not open bare repositories
Date: Fri, 28 Sep 2012 10:35:23 +0200
Message-ID: <CAH6sp9ME0og0E-=oW6MBFMBv8hD0y8PpmdpyaV4qqr7Mb7c5VA@mail.gmail.com>
References: <CAB9Jk9CA+e8xR9sz7cW+5+990FmTeYN3pjxs4ZKFpkzb6OL35Q@mail.gmail.com>
	<CAH6sp9N1cFH7orPNmfbhgHq6oUNtQNe=-5f5jkYNXzr+6Xp_pQ@mail.gmail.com>
	<CAB9Jk9BivVrH7daMR=u5Y6Ut=pZGRBcgKNZ_afZ53XFxhFBnZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 10:35:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THW2s-0006mU-3R
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 10:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392Ab2I1If0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 04:35:26 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:36767 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab2I1IfX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 04:35:23 -0400
Received: by qchd3 with SMTP id d3so1743939qch.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 01:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=re2z6jso97Bs0V7ffpMGCIyv6tiE+us+p78VsHTPmE8=;
        b=HJapVFdScnjHj5GGmdlIJQ1loqv1mzZ/KySobm9GrSNKDtoxlFS/7IpvKRnbBXWiy8
         AJBZhYTZDKGTCA8Sq56us4otNRFkSSMKvWpY5k3ggSEQixSJ4djYWZPBd60zEhi799ss
         RlrwezSqk+szeJ2WaX5KK96+WQrzoMh5mME6gd7iiFAdfdpgXFdRJphtqRIBh2sxmdTk
         8JxeDu5Iyfy6ldpzaIc50c6lMZ7+OkY3Ujd+iDzVLxChns30JLCdTzvJqBeTAfcRG72e
         FbrPZzn30QNKCapLbum1JCktGatGbzhJDW2HuBLX+uX89Y+OcsEZRfQURnEad1kjtWh7
         udeQ==
Received: by 10.224.78.140 with SMTP id l12mr15427930qak.48.1348821323327;
 Fri, 28 Sep 2012 01:35:23 -0700 (PDT)
Received: by 10.224.80.141 with HTTP; Fri, 28 Sep 2012 01:35:23 -0700 (PDT)
In-Reply-To: <CAB9Jk9BivVrH7daMR=u5Y6Ut=pZGRBcgKNZ_afZ53XFxhFBnZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206545>

Hi,

Please remember to reply to all when discussing things on the git mailing list.

On Fri, Sep 28, 2012 at 10:29 AM, Angelo Borsotti
<angelo.borsotti@gmail.com> wrote:
> Hello
>
> I apologise for having used the wrong script to reproduce the error.
> This is  the right one:
>
> angelo@ANGELO-PC /d/gtest (master)
> $ mkdir remote.git
>
> angelo@ANGELO-PC /d/gtest (master)
> $ cd remote.git
>
> angelo@ANGELO-PC /d/gtest/remote.git (master)
> $ git init --bare
> Initialized empty Git repository in d:/gtest/remote.git/
>
> Now with the git gui I try to open the d:/gtest/remote.git/ and
> receive the message
> that it is not a git repository.
>
> I understand that the gui is mostly aimed to non-bare repositories,
> but in such a case
> it would be better it could give me a message like, e.g. "could not
> open a bare repository"
> instead of telling me that it is not a git repository (I thought my
> bare repository was
> corrupt, and tried to figure out what was wrong with it).


Actually git-gui 0.16.0 is telling me that it cannot use bare
repositories, much in the vein of what I wrote earlier. Don't know if
it matters that I'm on Linux though.


Frans
