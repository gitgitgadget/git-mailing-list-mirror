From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: git push tags
Date: Fri, 26 Oct 2012 21:00:30 +0200
Message-ID: <20121026190029.GB15328@camk.edu.pl>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
 <CAM9Z-nkxCOyrtJ8vCF=00vrA_1eFr2-Fk7PXjYEx0HbVt0GPkQ@mail.gmail.com>
 <CAB9Jk9A95YrrtH8ue-CJ6Mqe9Z+3nfo=tjurLZjmecfiMFijvg@mail.gmail.com>
 <CAM9Z-nkosbe1NXYnu7x6v4seLqCnMBWg-jrdH2eJ9RetaZBTyQ@mail.gmail.com>
 <20121026174255.GE10560@camk.edu.pl>
 <CAM9Z-nkBO1dbF-sBFLuxM_S_MT79Cx=gLEL+83XKB7ys8VTqNQ@mail.gmail.com>
 <20121026182020.GF10560@camk.edu.pl>
 <CAB9Jk9AR7vFBH6E7-hFabyD9XgRrF5PVZU-HtABS85wkwVTt+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Drew Northup <n1xim.email@gmail.com>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 21:00:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRp9J-0001f7-Io
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 21:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759005Ab2JZTAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 15:00:40 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:57679 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758960Ab2JZTAk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 15:00:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 2B36F5F0047;
	Fri, 26 Oct 2012 21:00:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bDFtFv5zZuho; Fri, 26 Oct 2012 21:00:31 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 88AFA5F0048;
	Fri, 26 Oct 2012 21:00:31 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 5931843CFD; Fri, 26 Oct 2012 21:00:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAB9Jk9AR7vFBH6E7-hFabyD9XgRrF5PVZU-HtABS85wkwVTt+Q@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208477>

On Fri, Oct 26, 2012 at 08:35:50PM +0200, Angelo Borsotti wrote:
> Hello

> Drew,

> I made some further tests on git-push to see if it handled branches
> and tags in the same way, and have discovered the following
> differences:

>     - git push origin --delete master
>       remote: error: By default, deleting the current branch is denied

>     - git push origin --delete vx            (where vx is a tag)
>       ... accepted

> This is consistent with what is done on the local repo: deleting the
> current branch is disallowed, but deleting a tag is allowed (even when
> HEAD points to it).
> That means that git-push does not handle branches and tags exactly the same.

> Kacper

> thank you for the patch. To keep downward compatibility, the denial to
> update tags should perhaps be enabled with some option.

You are probably right. The proper submission should also contain a
test. I have sent a crude patch to show that the behaviour asked by you
is possible to obtain.

I will try to prepare a formal submission patch, but I can't say how
long it will take me. So if you want to do it by yourself feel free.

-- 
  Kacper Kornet
