From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: GIT Error issue
Date: Wed, 19 Apr 2006 13:21:36 +0200
Organization: Harddisk-recovery.com
Message-ID: <20060419112135.GA24807@harddisk-recovery.com>
References: <3857255c0604190416j62abeae8va164896c5100f6ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 13:21:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWAkh-0003Ur-6z
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 13:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWDSLVk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 07:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWDSLVk
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 07:21:40 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:100 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750891AbWDSLVj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Apr 2006 07:21:39 -0400
Received: (qmail 17827 invoked by uid 501); 19 Apr 2006 13:21:36 +0200
To: Shyamal Sadanshio <shyamal.sadanshio@gmail.com>
Content-Disposition: inline
In-Reply-To: <3857255c0604190416j62abeae8va164896c5100f6ee@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18921>

On Wed, Apr 19, 2006 at 04:46:57PM +0530, Shyamal Sadanshio wrote:
> I am newbie to GIT and facing some problem with the GIT usage. I am
> trying to clone a repository at www.linux-mips.org with the
> following command, I get error message as below:
> 
> **************************************************************************
> [root@sshyamal git-tutorial]# git clone
> git://ftp.linux-mips.org/pub/scm/linux-malta.git linux-malta.git
> git: warning: invalid extra options ignored
> 
> GNU Interactive Tools 4.3.20 (i686-pc-linux-gnu), 12:39:46 Apr 18 2006
> GIT is free software; you can redistribute it and/or modify it under the
> terms of the GNU General Public License as published by the Free
> Software
> Foundation; either version 2, or (at your option) any later version.
> Copyright (C) 1993-1999 Free Software Foundation, Inc.
> Written by Tudor Hulubei and Andrei Pitis, Bucharest, Romania
> 
> git: fatal error: `chdir' failed: permission denied.

You're using the wrong GIT. Remove the GNU Interactive Tools and use
git from kernel.org.

> ***************************************************************************
> 
> I am exercising this command in root mode.

There is absolutely zero reason to run git as root.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
