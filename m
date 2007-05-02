From: Eric Blake <ebb9@byu.net>
Subject: Re: [PATCH] Makefile: use --unsafe option under Cygwin with asciidoc
Date: Wed, 02 May 2007 07:06:06 -0600
Message-ID: <46388CBE.1080605@byu.net>
References: <ejlze97d.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed May 02 15:11:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjEcJ-00024D-QD
	for gcvg-git@gmane.org; Wed, 02 May 2007 15:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993146AbXEBNLd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 09:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993133AbXEBNLd
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 09:11:33 -0400
Received: from sccrmhc13.comcast.net ([204.127.200.83]:40824 "EHLO
	sccrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993146AbXEBNLc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 09:11:32 -0400
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 May 2007 09:11:31 EDT
Received: from [192.168.0.103] (c-71-199-58-92.hsd1.ut.comcast.net[71.199.58.92])
          by comcast.net (sccrmhc13) with ESMTP
          id <20070502130435013003f2one>; Wed, 2 May 2007 13:04:35 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.10) Gecko/20070221 Thunderbird/1.5.0.10 Mnenhy/0.7.5.666
In-Reply-To: <ejlze97d.fsf@cante.net>
X-Enigmail-Version: 0.94.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46020>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Jari Aalto on 5/2/2007 5:49 AM:
> New: variable ASCIIDOC_FLAGS was introduced. It was also added to two
> new targets. The old ASCIIDOC_EXTRA is set to --unsafe under Cygwin to
> ignore asciidoc error about unsafe include.

This isn't just for cygwin, since it benefits any platform where the
installed asciidoc is 8.1 or better (asciidoc is currently at 8.2.1 if you
build the from tarballs).

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGOIy+84KuGfSFAYARAo/XAKCuKOXb7cYzPL0AU4oiz5VbS54mtwCfVzX/
bTMHegP6uvmaFZB5pKL5Dxo=
=QYTe
-----END PGP SIGNATURE-----
