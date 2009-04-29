From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 0/6] cleanups for git-send-email
Date: Wed, 29 Apr 2009 09:12:17 -0400
Message-ID: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu>
Cc: gitster@pobox.com, Bill Pemberton <wfp5p@virginia.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 15:16:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz9eY-0003wt-QT
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 15:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758735AbZD2NM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 09:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757814AbZD2NM0
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 09:12:26 -0400
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:37680 "EHLO
	viridian.itc.Virginia.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760189AbZD2NMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 09:12:25 -0400
Received: by viridian.itc.Virginia.EDU (Postfix, from userid 1249)
	id C1F0C57034; Wed, 29 Apr 2009 09:12:23 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117881>

The following are some code cleanups for git-send-email.perl.  They're
based on suggestions by perlcritc.

Bill Pemberton (6):
  Remove return undef from validate_patch
  Remove function prototypes from git-send-email.perl
  Remove return undef from ask()
  Add explict return to end of subroutines
  Remove mix of high and low-precedence booleans
  Remove bareword filehandles in git-send-email.perl

 git-send-email.perl |   63 ++++++++++++++++++++++++++------------------------
 1 files changed, 33 insertions(+), 30 deletions(-)
