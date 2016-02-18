From: Juergen Kosel <juergen.kosel@gmx.de>
Subject: How to merge branches with git-svn without loosing svn-properties
Date: Thu, 18 Feb 2016 21:56:15 +0100
Message-ID: <56C62FEF.6000504@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 22:38:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWWHa-0004Gi-5k
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 22:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757190AbcBRVii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 16:38:38 -0500
Received: from dslb-178-007-019-037.178.007.pools.vodafone-ip.de ([178.7.19.37]:49251
	"EHLO acer-ilzleite" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753790AbcBRVih (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 16:38:37 -0500
X-Greylist: delayed 2539 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Feb 2016 16:38:37 EST
Received: from localhost ([127.0.0.1] ident=foobar)
	by acer-ilzleite with esmtp (Exim 4.84)
	(envelope-from <juergen.kosel@gmx.de>)
	id 1aWVcV-0003dQ-Vj
	for git@vger.kernel.org; Thu, 18 Feb 2016 21:56:16 +0100
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286621>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

could you please give me some recommendations how to merge two
branches in a git-svn repository, without loosing svn-properties?

As the git-svn man-page says:

> We ignore all SVN properties except svn:executable. Any unhandled
> properties are logged to $GIT_DIR/svn/<refname>/unhandled.log

Therefore I expect the following:
If branch A is merged by git into branch B any modified property
(except svn:executable and svn:mergeinfo) is not merged by git
automatically.
If I know that in branch A some property was set (e.g. svn-eol-style
or svn:keywords), than I could re-add the property manually by calling

	git svn propset

But usually I do not know. In this case it would be nice to have some
script which iterates over all files and compares the properties for
each file in the 2 branches.
Is there already such a tool?


Greetings
	Juergen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFWxi/vYZbcPghIM9IRApUpAJ9TFKagQUPdSx3QQZn5Cygb40G2TwCgkrWz
7+28Llb0IAo97gfNTSYIdG4=
=W2u9
-----END PGP SIGNATURE-----
