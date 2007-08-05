From: David Kastrup <dak@gnu.org>
Subject: Re: way to automatically add untracked files?
Date: Sun, 05 Aug 2007 14:17:54 +0200
Message-ID: <85bqdm89al.fsf@lola.goethe.zz>
References: <873ayymzc1.fsf@catnip.gol.com>
	<fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
	<20070805041320.GH9527@spearce.org>
	<200708051411.25238.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Miles Bader <miles@gnu.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Aug 05 14:18:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHf3i-0004ap-HI
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 14:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146AbXHEMSH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 08:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754563AbXHEMSG
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 08:18:06 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:58790 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750873AbXHEMSF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 08:18:05 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 68A1613652;
	Sun,  5 Aug 2007 14:18:04 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 52693100C2;
	Sun,  5 Aug 2007 14:18:04 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 27873292B67;
	Sun,  5 Aug 2007 14:18:04 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 969841C3D500; Sun,  5 Aug 2007 14:17:54 +0200 (CEST)
In-Reply-To: <200708051411.25238.johan@herland.net> (Johan Herland's message of "Sun\, 05 Aug 2007 14\:11\:24 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3859/Sun Aug  5 11:16:51 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55005>

Johan Herland <johan@herland.net> writes:

> So different users seem to have two different (almost incompatible) 
> expectations to git-add:
>
> 1. git-add adds new files into the index. git-add has _no_ business removing 
> deleted files from the index.
>
> 2. git-add updates the index according to the state of the working tree. 
> This includes adding new files and removing deleted files.
>
>
> Both interpretations are useful and worth supporting, but git-add
> currently seems focused on #1 (and rightly so, IMHO).
>
> Even though #2 can be achieved by using a couple of git-add
> commmands (or a longer series of more obscure plumbing-level
> commands), it might be worth considering the more user-friendly
> alternative of adding a dedicated command for supporting #2. Such a
> command already exists in a similar RCS:

[...]

> Adding a git-addremove command should not be much work, and it would
> be a lot friendlier to people whose workflow is more aligned with #2
> than #1.

Maybe just git-add -a?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
