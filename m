From: Jonas Thiem <contact@eloxoph.com>
Subject: Re: Remote corruption issue, linked to thin pack code?
Date: Thu, 26 Aug 2010 12:13:04 +0200
Message-ID: <4C763E30.2050407@eloxoph.com>
References: <201008252253.26521.trast@student.ethz.ch> <alpine.LFD.2.00.1008252107070.622@xanadu.home>
Reply-To: contact@eloxoph.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 12:21:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoZaZ-00085o-Ca
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 12:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085Ab0HZKVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 06:21:39 -0400
Received: from friendly.landlord.eloxoph.com ([85.214.104.74]:55991 "EHLO
	h1347290.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab0HZKVh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 06:21:37 -0400
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Aug 2010 06:21:37 EDT
Received: from [192.168.2.102] (p5B13EF7B.dip.t-dialin.net [91.19.239.123])
	by h1347290.stratoserver.net (Postfix) with ESMTPA id A0797D0C1F1;
	Thu, 26 Aug 2010 12:13:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.8) Gecko/20100806 Fedora/3.1.2-1.fc13 Thunderbird/3.1.2
In-Reply-To: <alpine.LFD.2.00.1008252107070.622@xanadu.home>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154536>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

I'll try to provide the missing information as good as I can:

> What about 'git fsck --full'?  Given git v1.5.4 on the remote, you 
> should try --full with 'git fsck' as this wasn't the default back then.
$ GIT_DIR=./ git fsck --full
dangling commit d298351127861349846fe626a320c66101821d72
dangling commit a71ea8dd4c837c39ef26765574d515253ea2fd5a

> What about 'git cat-file -t e28ae6b61c384732c506' ?
$ GIT_DIR=./ git cat-file -t e28ae6b61c384732c506
commit

> Also, what is the OS version and filesystem used on the remote machine?
OS is Ubuntu 8.04 LTS. It's a virtual server by a hosting company,
therefore I don't know much about the filesystem setup, but maybe that
helps:

$ df -T:
Filesystem    Type   1K-blocks      Used Available Use% Mounted on
/dev/vzfs reiserfs    10485760   4056808   6428952  39% /
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iF4EAREIAAYFAkx2Ph8ACgkQVizsUChSmww9TAEAptTyg+0yqidArbg2wMLmgac+
PrK9T3g4cU20EBOEuXkBALlqLapTQLlyO8UoFi+I3Mq64sDBBdjaEqH8bi6LcTor
=ahRa
-----END PGP SIGNATURE-----
