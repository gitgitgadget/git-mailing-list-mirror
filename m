From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: git fsck not identifying corrupted packs
Date: Tue, 20 Oct 2009 17:41:50 +0200
Message-ID: <200910201741.50764.robin.rosenberg@dewire.com>
References: <loom.20091019T094924-194@post.gmane.org> <7v7hur1a0h.fsf@alter.siamese.dyndns.org> <200910191327.49092.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 17:42:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0GqV-0004il-J3
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 17:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbZJTPlt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 11:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752463AbZJTPlt
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 11:41:49 -0400
Received: from mail.dewire.com ([83.140.172.130]:8643 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227AbZJTPls convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 11:41:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E878D143F184;
	Tue, 20 Oct 2009 17:41:51 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cLcMeDXpmUN6; Tue, 20 Oct 2009 17:41:51 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 63EE213F412B;
	Tue, 20 Oct 2009 17:41:51 +0200 (CEST)
User-Agent: KMail/1.11.4 (Linux/2.6.28-11-generic; KDE/4.2.4; i686; ; )
In-Reply-To: <200910191327.49092.wjl@icecavern.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130804>

m=E5ndag 19 oktober 2009 21:27:48 skrev  Wesley J. Landaker:
> (Not CCing everyone, since this is mostly curiosa in the "using git a=
s it
> was never intended" section):
>
> On Monday 19 October 2009 13:03:42 Junio C Hamano wrote:
> > Once a packfile is created and we always use it read-only, there di=
dn't
> > seem to be much point in suspecting that the underlying filesystems=
 or
> > disks may corrupt them in such a way that is not caught by the SHA-=
1
> > checksum over the entire packfile and per object checksum.  That tr=
ust in
> > the filesystems might have been a good tradeoff between fsck perfor=
mance
> > and reliability on platforms git was initially developed on and for=
, but
> > it might not be true anymore as we run on more platforms these days=
=2E
>
> Filesystems are mostly reliable, but only until your crazy users do s=
trange
> and terrible things. I have a real, non-toy environment where I use t=
his
> stack as a [horrible] workaround for some issues beyond my control:
>
> git -> ext4 -> lvm -> dmcrypt -> loop -> sshfs -> cygwin sshd -> SMB =
share

The obvious follow up question here is: Why?

-- robin
