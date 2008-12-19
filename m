From: jidanni@jidanni.org
Subject: Re: How to extract files out of a "git bundle", no matter what?
Date: Sat, 20 Dec 2008 04:13:26 +0800
Message-ID: <87zlirc49l.fsf@jidanni.org>
References: <494BFCAF.9060703@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, git@vger.kernel.org
To: mdl123@verizon.net
X-From: git-owner@vger.kernel.org Fri Dec 19 21:14:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDlkF-0006n1-JR
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 21:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbYLSUN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 15:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbYLSUN3
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 15:13:29 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:45801 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750874AbYLSUN3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Dec 2008 15:13:29 -0500
Received: from jidanni.org (122-127-33-249.dynamic.hinet.net [122.127.33.249])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id 088B7414B0;
	Fri, 19 Dec 2008 12:13:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103579>

SOP> If the bundle requires 0 refs (like above) then you can init a
SOP> new repository and should be able to fetch from it:

SOP> 	git init
SOP> 	git pull bundle.bdl master

Phew, that worked. Thank you!

ML> With relatively recent git (not sure the version), you can just do
ML>    git clone bundle.bdl
Not with git version 1.5.6.5, Debian sid.

Anyway, for man page completeness, I still see the day when:

SOP> You can't just "get the files out".  A bundle contains deltas,
SOP> where you need the base in order to recreate the file content.
SOP> It can't be unpacked in a vacuum.

That is nice by we here at the forensics department of XYZ police
force just need to get the files out. We tried "PK UNZIP" but that
didn't extract them. We contacted the Computer Science Dept. but
that's who they're holding hostage.

SOP> To unpack a bundle you need to clone the project and then fetch
SOP> from it:

SOP> 	git clone src...
SOP> 	git pull bundle.bdl master

That is nice but the perpetrators have destroyed everything except for
that one bundle.bdl file, which contains the password to defuse the
time bomb.

There must be a way to make a "phony tree" or whatever to "attach to"
so extraction can proceed. Be sure to spell it all out on the
git-bundle man page as a reference in case some non-computer people
need to do aforementioned emergency extraction one day.
