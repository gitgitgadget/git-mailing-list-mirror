From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [StGit PATCH] add option to import series directly from a tar archive
Date: Fri, 12 Sep 2008 14:21:13 +0200
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-09-12-14-21-13+trackit+sam@rfc1149.net>
References: <48C34EC7.9040102@gmail.com>
	<20080908180317.GA6123@diana.vm.bytemark.co.uk>
	<48C56AD9.6040007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 14:29:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke7mR-00024S-9q
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 14:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbYILM2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 08:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753432AbYILM2g
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 08:28:36 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:48499 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbYILM2f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 08:28:35 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Sep 2008 08:28:34 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id B4C4DE0E81;
	Fri, 12 Sep 2008 14:21:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sgn+ddDTDz9X; Fri, 12 Sep 2008 14:21:16 +0200 (CEST)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:e35:1382:f950::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTPS id D993CE0536;
	Fri, 12 Sep 2008 14:21:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id CD598C40BC;
	Fri, 12 Sep 2008 14:21:14 +0200 (CEST)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sG6GFcfsEDly; Fri, 12 Sep 2008 14:21:14 +0200 (CEST)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 3CA13C40BD; Fri, 12 Sep 2008 14:21:14 +0200 (CEST)
In-Reply-To: <48C56AD9.6040007@gmail.com> (Clark Williams's message of "Mon\, 08 Sep 2008 13\:11\:37 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95716>

>>>>> "Clark" == Clark Williams <clark.williams@gmail.com> writes:

Clark> [...] is to see if I can ease StGit's patch
Clark> import rules a bit, since quilt accepts pretty much anything as
Clark> long as there's a diff in there somewhere. I bomb out regularly
Clark> importing the -rt series using StGit, because some people don't
Clark> put complete email addresses in their patches.

Two things that would be great would be:

  - to be able to import patches with "-p0" (people not using git
    often sends such patches)

  - to be able to find where the patch should be applied; I sometimes
    receive patches for GCC directory "gcc/ada/", diffed from there,
    and if StGit could see that the patch only makes sense there and
    not at the top-level it would be great as well

 Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
