From: Thomas Christensen <thomasc@thomaschristensen.org>
Subject: Re: [Bug] vfat: Not a git archive
Date: Mon, 02 Jun 2008 13:04:20 +0200
Message-ID: <87abi45c97.fsf@debian.erik.com>
References: <873anwt9ya.fsf@debian.erik.com>
	<20080602103909.GB11287@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 13:05:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K37rQ-0003Qq-4x
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 13:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbYFBLEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 07:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753699AbYFBLEv
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 07:04:51 -0400
Received: from main.gmane.org ([80.91.229.2]:42066 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471AbYFBLEt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 07:04:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K37qG-0001TU-OI
	for git@vger.kernel.org; Mon, 02 Jun 2008 11:04:44 +0000
Received: from 194.239.24.50 ([194.239.24.50])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 11:04:44 +0000
Received: from thomasc by 194.239.24.50 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 11:04:44 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 194.239.24.50
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:6h0drtIJx1bFpv/j0xw/lC4B3no=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83513>

Teemu Likonen <tlikonen@iki.fi> writes:

> Thomas Christensen wrote (2008-06-02 12:20 +0200):
>
> Hmm, for example KDE automatically mounts VFAT filesystems with mount
> option "utf8" when using UTF-8 locale. VFAT uses UTF-16 in filenames and
> the only way to convert filenames losslessly (apart from the case
> insensitive issue) between Linux and VFAT is to use UTF-8 locale in
> Linux. I have described the subject in the Debian bug #417324:
>
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=417324
>
> What locale are you using? What mount options did you use when you
> mounted the /media/KINGSTON/ filesystem?

LANG=en_DK.UTF-8

/dev/sda1 on /media/KINGSTON type vfat
(rw,nosuid,nodev,uhelper=hal,shortname=lower,uid=1000)

It is auto mounted by the Gnome desktop.  I have tried to mount it
manually without mount options as well:

/dev/sda1 on /mnt type vfat (rw)

But alas, same problem.  I have been fiddling with the shortname option
and iocharset too, also without success.

	Thomas
