X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Minor documentation problems
Date: Thu, 02 Nov 2006 11:40:23 +0100
Message-ID: <vpqmz7a1694.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 10:42:23 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: git <git@vger.kernel.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Thu, 02 Nov 2006 11:40:26 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30708>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfa1S-0005hE-AJ for gcvg-git@gmane.org; Thu, 02 Nov
 2006 11:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751328AbWKBKmH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 05:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818AbWKBKmG
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 05:42:06 -0500
Received: from imag.imag.fr ([129.88.30.1]:39365 "EHLO imag.imag.fr") by
 vger.kernel.org with ESMTP id S1751328AbWKBKmD (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 05:42:03 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52]) by
 imag.imag.fr (8.13.6/8.13.6) with ESMTP id kA2AeNhr013541
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO) for
 <git@vger.kernel.org>; Thu, 2 Nov 2006 11:40:26 +0100 (CET)
Received: from ecrins.imag.fr ([129.88.43.124]) by mail-veri.imag.fr with
 esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GfZzj-0006lm-Ja for
 git@vger.kernel.org; Thu, 02 Nov 2006 11:40:23 +0100
Received: from moy by ecrins.imag.fr with local (Exim 4.50) id
 1GfZzj-0004dc-GB for git@vger.kernel.org; Thu, 02 Nov 2006 11:40:23 +0100
To: git <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Hi,

I'm giving a try to git/cogito after using other systems (particularly
GNU Arch and Bazaar).

I'm looking for a VCS which can suite me (willing to spend some time
learning it) and some collegues (NOT willing to spend more than a few
minutes learning a new tool. "patch" was already too complex, and
someone already requested me to send a full version instead of this
"weird thing that I don't have time to learn"). I'm also looking for a
system for my students, ranging from the somewhat experienced hacker
to the mathematician not caring about computers at all.

The git/cogito duo might do it, let's see.


I found minor problems with the doc, which deserve to be fixed:

* http://www.kernel.org/pub/software/scm/cogito/docs/cg-commit.1.html
  Mentions .git/config, but not ~/.gitconfig (which is indeed _the_
  place where I think most people want to set their name and email).

  Side note: it can be interesting to have a command to do this.
  For example, bzr has "bzr whoami 'me <myself@myisp.com>'", which
  avoids having to learn the config file syntax.

* RSS link on the wiki:
  The URL
  http://git.or.cz/gitwiki/RecentChanges?action=rss_rc&ddiffs=1&unique=1
  seems to be working as an RSS feed for changes, but it's not linked
  to by http://git.or.cz/gitwiki/RecentChanges. Usually, there's an
  RSS icon, and an HTML <link rel="alternate" ...> to help finding it.

Thanks,

-- 
