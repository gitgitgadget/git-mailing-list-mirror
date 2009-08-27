From: Tim Potter <tpot@hp.com>
Subject: [git-svn] always prompted for passphrase with subversion 1.6
Date: Thu, 27 Aug 2009 10:38:36 +1000
Message-ID: <4A95D58C.1070409@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 02:38:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgT0p-0006lt-3m
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 02:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422AbZH0Aii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 20:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754390AbZH0Aih
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 20:38:37 -0400
Received: from g1t0026.austin.hp.com ([15.216.28.33]:47299 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399AbZH0Aih (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 20:38:37 -0400
Received: from g5t0012.atlanta.hp.com (g5t0012.atlanta.hp.com [15.192.0.49])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g1t0026.austin.hp.com (Postfix) with ESMTPS id EF8BFC33A;
	Thu, 27 Aug 2009 00:38:39 +0000 (UTC)
Received: from [16.176.26.157] (tigerella.asiapacific.hpqcorp.net [16.176.26.157])
	by g5t0012.atlanta.hp.com (Postfix) with ESMTPSA id 0248410005;
	Thu, 27 Aug 2009 00:38:38 +0000 (UTC)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127125>

Hi everyone.  I am using git-svn with the Subversion 1.6 client compiled
with GNOME Keyring support.  This neat features allows a SSL client
certificate password to be cached inside GNOME Keyring instead of being
prompted to enter it every time.  However the git-svn script doesn't
appear to know about this and always prompts for a password.

Obviously there's some tweak required in the _auth_providers()
subroutine but I don't know enough about the Subversion Perl client to
figure out a fix.

Has anyone else run in to this problem?  I did a quick search on the
list but didn't find anything relevant.


Regards,

Tim.
