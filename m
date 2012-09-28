From: Ben Smith-Mannschott <bsmith.occs@gmail.com>
Subject: Re: git gui does not open bare repositories
Date: Fri, 28 Sep 2012 16:15:57 +0200
Message-ID: <CAJ_tm-Q2=ZpUQVHG1om5cfhqoLpCwo2fNoqcWOa-n00-h0raOQ@mail.gmail.com>
References: <CAB9Jk9CA+e8xR9sz7cW+5+990FmTeYN3pjxs4ZKFpkzb6OL35Q@mail.gmail.com>
	<CAH6sp9N1cFH7orPNmfbhgHq6oUNtQNe=-5f5jkYNXzr+6Xp_pQ@mail.gmail.com>
	<CAB9Jk9BivVrH7daMR=u5Y6Ut=pZGRBcgKNZ_afZ53XFxhFBnZw@mail.gmail.com>
	<CAH6sp9ME0og0E-=oW6MBFMBv8hD0y8PpmdpyaV4qqr7Mb7c5VA@mail.gmail.com>
	<50656388.3050400@atlas-elektronik.com>
	<CAB9Jk9C=ndfO37YWS5mg4anu91N4O__iA_msmxU+X2_Nakv-tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>,
	Frans Klaver <fransklaver@gmail.com>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 16:16:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THbMT-0001so-F9
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 16:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973Ab2I1OQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 10:16:00 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:49165 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756195Ab2I1OP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 10:15:59 -0400
Received: by lagh6 with SMTP id h6so1076774lag.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 07:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UPq9fh5G7i7U3gOoqRC45G128l7LQ0DIjjEhp2hAF0Y=;
        b=nTUm4rhcAnFY/Fz6T+lfGHdiS72Ubt6q5z4x4ZsXlsleYSTOLKocvKTKApS/+KmEJZ
         a1Dg0C6hHtBqsury/kBAmdD8p0BlMriiinuKfVQ3VYruM/ULsN4Y1Myix23ptmcNlAwM
         jAv2I68h0ZryeuBuwu6reWSCtzE6kZasnIC8PhIWnFE6XR9W/dSrrXFtT9VMQQTRtwd7
         0HHbLhVdPBgLWvi4JI559xDn+VRvDX2vEcf/2sthjrclKJE84a0j89TtB0iLqMswEJ/o
         n2c44kEXkEzv1tvAYhyTIFmep9tGV7S/dzQLvBZJCXXdplWe+fYsOdSZoGbrdtehPAQL
         xoXg==
Received: by 10.152.135.41 with SMTP id pp9mr6156191lab.7.1348841758062; Fri,
 28 Sep 2012 07:15:58 -0700 (PDT)
Received: by 10.112.25.105 with HTTP; Fri, 28 Sep 2012 07:15:57 -0700 (PDT)
In-Reply-To: <CAB9Jk9C=ndfO37YWS5mg4anu91N4O__iA_msmxU+X2_Nakv-tQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206582>

Hi Angelo,

On Fri, Sep 28, 2012 at 2:09 PM, Angelo Borsotti
<angelo.borsotti@gmail.com> wrote:
> I have removed the Italian localization so as to make git gui use the
> English one.
> The result is the same as I have found before.
> The message is: " Not a Git repository: remote.git".
> Thus, the misleading message is there.

I'm not seeing what you're seeing. I'm running git 1.7.12.1 and I get
exactly this message:

    Cannot use bare repository:

    /Users/bsmith/tmp/repo.git

When I do exactly this:

    $ cd ~/tmp
    $ mkdir repo.git
    $ cd repo.git
    $ git init --bare
    $ git gui

What, exactly, are you doing?

// Ben
