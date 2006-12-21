From: Eric Blake <ebb9@byu.net>
Subject: Re: git 1.4.4.2 is giving the following errors...
Date: Thu, 21 Dec 2006 06:03:59 -0700
Message-ID: <458A863F.10700@byu.net>
References: <ace3f33d0612202115p3fedb169pf235c4556f2eef57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 14:17:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxNnP-0002Lq-B5
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 14:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422719AbWLUNRM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 08:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422757AbWLUNRM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 08:17:12 -0500
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:50214 "EHLO
	rwcrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422719AbWLUNRL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 08:17:11 -0500
X-Greylist: delayed 727 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 08:17:11 EST
Received: from [192.168.0.103] (c-67-186-254-72.hsd1.co.comcast.net[67.186.254.72])
          by comcast.net (rwcrmhc11) with ESMTP
          id <20061221130504m11003un3de>; Thu, 21 Dec 2006 13:05:04 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.8) Gecko/20061025 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: srinivas naga vutukuri <srinivas.vutukuri@gmail.com>
In-Reply-To: <ace3f33d0612202115p3fedb169pf235c4556f2eef57@mail.gmail.com>
X-Enigmail-Version: 0.94.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35064>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to srinivas naga vutukuri on 12/20/2006 10:15 PM:
> Hi,
> 
>      I am new to git.
>> From the web site downloaded the 1.4.4.2 source and compiled on the
> cygwin environment.

Why not download the pre-compiled git 1.4.4.3 from cygwin, rather than
building it yourself?

> when am trying as an example to use the git,
> 
> ------------------------------------snip----------------------------------------------------------
> 
> sh-3.2$ git clone git://git.kernel.org/pub/scm/git/git.git
> : command not foundclone: line 7:

I wonder if you are suffering from corrupted line endings.  If your
scripts end up with DOS line endings, but you execute them on a cygwin
binary mount, then bash will happily treat those \r as literal characters
rather than ignored whitespace (similarly to how bash behaves on Linux
with \r characters, except that on Linux, people tend to not use DOS line
endings).

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFioY/84KuGfSFAYARAiNEAJ942dcJyv4v2uYWd5NI7y43JeL9FQCeMMyH
GGOX9k8mTra+K19nxv9qqDw=
=RWS0
-----END PGP SIGNATURE-----
