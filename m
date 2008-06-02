From: Thomas Christensen <thomasc@thomaschristensen.org>
Subject: Re: [Bug] vfat: Not a git archive
Date: Mon, 02 Jun 2008 13:05:30 +0200
Message-ID: <878wxo5c79.fsf@debian.erik.com>
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
	id 1K37rQ-0003Qq-P6
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 13:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbYFBLFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 07:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753699AbYFBLFE
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 07:05:04 -0400
Received: from main.gmane.org ([80.91.229.2]:42080 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752107AbYFBLFD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 07:05:03 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1K37qY-0001Uj-Td
	for git@vger.kernel.org; Mon, 02 Jun 2008 11:05:02 +0000
Received: from 194.239.24.50 ([194.239.24.50])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 11:05:02 +0000
Received: from thomasc by 194.239.24.50 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 11:05:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 194.239.24.50
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:Vnf7gxsrztt/lOz07lFrKXh9PD0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83512>

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
