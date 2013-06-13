From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC V2 0/4] git-remote-mediawiki: new tool to preview local changes without pushing
Date: Thu, 13 Jun 2013 13:23:37 +0200
Message-ID: <vpqa9muuudi.fsf@anie.imag.fr>
References: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>,
	Jeff King <peff@peff.net>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Thu Jun 13 13:23:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un5d8-0005Uj-W4
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 13:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381Ab3FMLXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 07:23:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54867 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925Ab3FMLXq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 07:23:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5DBNaZV002432
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 13 Jun 2013 13:23:36 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Un5cv-0002ur-Jk; Thu, 13 Jun 2013 13:23:37 +0200
In-Reply-To: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Thu, 13 Jun 2013 12:07:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 13 Jun 2013 13:23:37 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227718>

benoit.person@ensimag.fr writes:

> For now, this PATCH/RFC is based on the 'next' branch merged with the 
> bp/mediawiki-credential patch. For the final version, I will try 
> to rebase it on celestin's work with perlcritic.

Actually, it seems based on an old "next" branch. This hunk

--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -13,6 +13,8 @@
 
 use strict;
 use MediaWiki::API;
+use Git;

Fails to apply because "use Git;" is already there in today's next.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
