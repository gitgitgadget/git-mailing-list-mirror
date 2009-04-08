From: Janos Laube <janos.dev@gmail.com>
Subject: Re: [msysGit] Git for Windows 1.6.2.2
Date: Wed, 8 Apr 2009 12:11:48 +0200
Message-ID: <9d6091530904080311s7f8f893exd504202f77214c31@mail.gmail.com>
References: <alpine.DEB.1.00.0904080440170.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Wed Apr 08 12:13:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrUmZ-0006xu-Ib
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 12:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764097AbZDHKLw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 06:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764071AbZDHKLv
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 06:11:51 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:45821 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764069AbZDHKLu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2009 06:11:50 -0400
Received: by bwz17 with SMTP id 17so44552bwz.37
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 03:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kIqLfBehkQB7/hJlxSWoQhDU3RFDeDXEV05ieqCiYp4=;
        b=lco57MWB5Q0fkzw4pbn19++BMeaQa8noyXgTYduqqEfjStXc4XcHWfIUCHG57wq7tJ
         83xHl6EcnhK7ye70/1Dl7aoMRWx1k0gEfqidzGVJWws1m1hjecSlVxy12maOO24+fYtO
         aRvzUJixi7sUgnCi0eCJWHNUfQFuBkQCsi7AU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=s0aZERzkOnQ80umC4MB8Xs5oEKsMrR0+UvTMb47s+1zOSWlB5Ce8xIvCFz7E1z1K5o
         Mn4fpKQVivtMJorv22WalxKEWo55/r7u6L/CKxntSs/CLL7vdVkW4bvbYcBDIj1H4cI7
         KE+WdS6QaE97cpFeKu2h+tfITy9BGDWZjXYC4=
Received: by 10.204.31.207 with SMTP id z15mr980344bkc.63.1239185508243; Wed, 
	08 Apr 2009 03:11:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904080440170.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116074>

>
> Hi,
>
> this email tries to inform you that the Windows installer was updated=
 to
> the newest version of Git.
>
> Changes since Git-1.6.2.1-preview20090322
>
> New Features
>
> - Comes with official git 1.6.2.2.
> - Upgraded Tcl/Tk to 8.5.5.
> - TortoiseMerge is supported by mergetool now (Thanks Markus Heidelbe=
rg).
> - Uses pthreads (faster garbage collection on multi-core machines).
> - The test suite passes!
>
> Bugfixes
>
> - Renaming was made more robust (due to Explorer or some virus scanne=
rs,
> =C2=A0files could not be renamed at the first try, so we have to try =
multiple
> =C2=A0times).
> - Johannes Sixt made lots of changes to the test-suite to identify
> =C2=A0properly which tests should pass, and which ones cannot pass du=
e to
> =C2=A0limitations of the platform.
> - Support PAGERs with spaces in their filename.
> - Quite a few changes were undone which we needed in the olden days o=
f
> =C2=A0msysGit.
> - Fall back to / when HOME cannot be set to the real home directory d=
ue to
> =C2=A0locale issues (works around Issue 108 for the moment).
>
> Ciao,
> Dscho "who really needs some sleep"

thank you very much! awesome work :-)
