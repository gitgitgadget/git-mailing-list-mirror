From: Jochen <rick23@gmx.net>
Subject: Re: Umlaut in filename makes troubles
Date: Tue, 01 Dec 2009 09:26:14 +0100
Message-ID: <hf2jvd$jff$2@ger.gmane.org>
References: <200912010815.14515.rick23@gmx.net> <20091201074420.GC3618@triton>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 09:40:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFOHP-00058Q-LX
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 09:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551AbZLAIkB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 03:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753497AbZLAIkB
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 03:40:01 -0500
Received: from lo.gmane.org ([80.91.229.12]:58331 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753463AbZLAIkA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 03:40:00 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NFOHF-00052v-JC
	for git@vger.kernel.org; Tue, 01 Dec 2009 09:40:05 +0100
Received: from 85-127-8-251.dynamic.xdsl-line.inode.at ([85.127.8.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 09:40:05 +0100
Received: from rick23 by 85-127-8-251.dynamic.xdsl-line.inode.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 09:40:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 85-127-8-251.dynamic.xdsl-line.inode.at
User-Agent: KNode/0.99.01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134179>

=C3=98yvind A. Holm wrote:

> On 2009-12-01 08:15:08, rick23@gmx.net wrote:
> > I have problems with my repository under slackware vs. windows. I
> > created a repo in linux and every time I use it under msysgit,
> > the files containing umlauts in the filename are marked as
> > deleted (and vice versa).
> >
> > For instance: the repo perfectly synced under msysgit leads to:
> >
> > user@sauron:/media/disk-2$ git status |grep Auszug
> > #       deleted:    "trunk/007_Literatur/Auszug aus Ergonomische
> > Untersuchung des Lenkgef\374hles.docx"
> > #       "trunk/007_Literatur/Auszug aus Ergonomische Untersuchung
> > des Lenkgef\303\274hles.docx"
> >
> > in linux. But the file exists and is displayed correctly in the
> > shell or in dolphin (my filemanager under X):
> >
> > user@sauron:/media/disk-2$ ls trunk/007_Literatur/Auszug*
> > trunk/007_Literatur/Auszug aus Ergonomische Untersuchung des
> > Lenkgef=C3=BChles.docx
> >
> > Can you please give me a hint what to do?
>
> Try to specify "utf8" as mount option under Linux.=20

The automount of KDE 4.2.4 already used utf-8 (I guess the filenames=20
would be garbled in dolphin otherwise)

> You can also try
> experimenting with the "nls" mount option, check out the mount(8)
> man page to see how it's used.

Ufff, I'm sorry - I'm not sure how to pass this to the automouter. I'd=20
tried to mount the stick manually (with and without utf) and without=20
utf8 the filenames are display strange from "ls".

> Additionally, I found that I need "shortname=3Dmixed" when mounting
> USB memory cards. As filenames are case insensitive in Windowsworld
> and gadgets using vfat, Linux tend to treat them differently.

My automouter done it as

/dev/sde on /media/disk-2 type vfat=20
(rw,nosuid,nodev,uhelper=3Dhal,uid=3D1000,utf8,shortname=3Dmixed)

So the options look right to me.

Kindest regards
Jochen
