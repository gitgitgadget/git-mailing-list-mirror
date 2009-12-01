From: Jochen <rick23@gmx.net>
Subject: Re: Umlaut in filename makes troubles
Date: Tue, 01 Dec 2009 10:06:31 +0100
Message-ID: <hf2mau$l2r$1@ger.gmane.org>
References: <200912010815.14515.rick23@gmx.net> <4B14CBA9.6080104@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 10:07:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFOhc-000775-C0
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 10:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbZLAJHH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 04:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752812AbZLAJHH
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 04:07:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:48276 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbZLAJHF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 04:07:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NFOhP-00071D-Dc
	for git@vger.kernel.org; Tue, 01 Dec 2009 10:07:07 +0100
Received: from rain.gmane.org ([80.91.229.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 10:07:07 +0100
Received: from rick23 by rain.gmane.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 10:07:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: rain.gmane.org
User-Agent: KNode/0.99.01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134184>

Michael J Gruber wrote:

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
> I would say you can give us more info about your setup. If I
> understand you correctly, you use the same repo and checkout under
> linux and msysgit.=20

Right - I created it under linux on a local directory, cloned it to an=20
usb-stick and cloned it again under windows.
I then worked under windows (msysgit) and pushed it to the stick=20
again.=20
Now I am back an my linux maschine and the files with umlauts in the=20
filenames are mared as deleted.

> > What kind of filesystem is this on, what are the
> mount options?=20

/dev/sde on /media/disk-2 type vfat=20
(rw,nosuid,nodev,uhelper=3Dhal,uid=3D1000,utf8,shortname=3Dmixed)

mounted by the automounter of KDE 4.2.4

> What is your locale ($LANG) in slackware?

LANG=3Dde_AT.utf-8

Jochen
