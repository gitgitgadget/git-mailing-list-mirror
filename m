From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-bzr: update old organization
Date: Fri, 17 May 2013 05:33:27 -0500
Message-ID: <CAMP44s3zXLwHu0OhLKsoerHaoBGMf66hNJ=hvOiUVAe4+=hDiA@mail.gmail.com>
References: <1368505227-16661-1-git-send-email-felipe.contreras@gmail.com>
	<CABLWAfStOZvKZzsCqb+UiedA7Ra-ermyRJVAeocBE=RdXL8B2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sandor Bodo-Merle <sbodomerle@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 12:33:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdHyj-0007E5-Jz
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 12:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab3EQKda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 06:33:30 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:45944 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794Ab3EQKd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 06:33:29 -0400
Received: by mail-la0-f54.google.com with SMTP id eg20so1453533lab.27
        for <git@vger.kernel.org>; Fri, 17 May 2013 03:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=SDaFdgizNJFEeOvajg3TdR6QBamBP0d5mNry75U6YJI=;
        b=XrR9pbiZKMLj/ed/i21aAcfHo0nZe7ytJZtn0bX2odJw68HoLBAes4n5K1pHmSAD9F
         Tuqd7Eu6wbjeIyR15EpTb2ajBAxWnlrgVUCKTABNawXyOh9Pj+eX4HjZq/8SX/vfR06j
         AXEJ3yxPyQe+z6e91B3PCePnPtS9dd/0s+oDOyRHpE40q2V0IdfIA/IJ/jAvw9IU56Zb
         iBwRXVPebqv9UYfUD3elXrsDEwvv5cWsR77f9u2vTuxXtuOZo7C8yecsEv/zxI1G3ure
         xvoEGqf0M/rMi7f9NXTkYCVeC9lrYuc1d/m+GAaTj6qSsw7pLwhBsGOJKXi7nrswXXbg
         O4Vg==
X-Received: by 10.152.19.98 with SMTP id d2mr8886286lae.19.1368786807429; Fri,
 17 May 2013 03:33:27 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Fri, 17 May 2013 03:33:27 -0700 (PDT)
In-Reply-To: <CABLWAfStOZvKZzsCqb+UiedA7Ra-ermyRJVAeocBE=RdXL8B2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224681>

On Fri, May 17, 2013 at 5:02 AM, Sandor Bodo-Merle <sbodomerle@gmail.com> wrote:

> apparently this breaks my existing clone of the bugzilla repository, where i
> have branches cloned with versions of remote-bzr prior 1.8.2 and after. The
> erro iget is:
>
> Fetching origin
> Traceback (most recent call last):
>   File "/home/bms/bin/git-remote-bzr", line 956, in <module>
>     sys.exit(main(sys.argv))
>   File "/home/bms/bin/git-remote-bzr", line 928, in main
>     repo = get_repo(url, alias)
>   File "/home/bms/bin/git-remote-bzr", line 844, in get_repo
>     bdir.destroy_repository()
>   File "/usr/lib/python2.7/dist-packages/bzrlib/bzrdir.py", line 900, in
> destroy_repository
>     raise errors.NoRepositoryPresent(self)
> bzrlib.errors.NoRepositoryPresent: No repository present:
> "file:///home/bms/workspace/bugzilla/.git/bzr/origin/clone/"
> error: Could not fetch origin
>
>
> The following small patch seems to fix my regression:

The patch is fine by me, in fact, I already had that patch, but
somehow could not trigger the exception, so I removed it.

-- 
Felipe Contreras
