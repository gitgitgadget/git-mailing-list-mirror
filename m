From: Kai Blin <kai@samba.org>
Subject: Re: Git over SMBFS
Date: Wed, 06 Oct 2010 07:36:42 +0200
Message-ID: <4CAC0AEA.6050502@samba.org>
References: <AANLkTik9U_jr6r6BuUcRrk8pjQTacKDY7YbqWnfrCLmD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: fREW Schmidt <frioux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 07:44:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Mnj-0001Ki-F2
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 07:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756749Ab0JFFoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 01:44:22 -0400
Received: from fn.samba.org ([216.83.154.106]:44278 "EHLO lists.samba.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755234Ab0JFFoW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 01:44:22 -0400
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Oct 2010 01:44:22 EDT
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by lists.samba.org (Postfix) with ESMTP id AE360ACFCE;
	Tue,  5 Oct 2010 23:36:42 -0600 (MDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100915 Thunderbird/3.0.8
In-Reply-To: <AANLkTik9U_jr6r6BuUcRrk8pjQTacKDY7YbqWnfrCLmD@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158266>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2010-10-06 04:26, fREW Schmidt wrote:
> A coworker of mine is working on a project that is running on a
> windows server.

Please tell me you're not really using smbfs as the filesystem but
you're actually using the cifs kernel module. smbfs has been deprecated
years ago and is unlikely to work correctly against servers more recent
than Win NT 4.0.

Cheers,
Kai

- -- 
Kai Blin
Worldforge developer http://www.worldforge.org/
Wine developer http://wiki.winehq.org/KaiBlin
Samba team member http://www.samba.org/samba/team/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkysCuYACgkQEKXX/bF2FpSujgCfU6bRiu/m7OQe68ju5cl7Wl1H
2xoAn1roY9WnFQ1MN3hpFjna/iMfwWob
=xGqM
-----END PGP SIGNATURE-----
