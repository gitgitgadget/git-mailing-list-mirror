From: "Philipp A. Hartmann" <pah@qo.cx>
Subject: [PATCH] contrib: GnomeKeyring support + generic helper implementation
Date: Thu, 23 Aug 2012 18:57:44 +0200
Message-ID: <1345741068-11004-1-git-send-email-pah@qo.cx>
Cc: Jeff King <peff@peff.net>, John Szakmeister <john@szakmeister.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 19:07:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4asC-0005c4-0B
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 19:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758886Ab2HWRHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 13:07:06 -0400
Received: from offis4.offis.uni-oldenburg.de ([134.106.51.109]:34521 "EHLO
	offis4.offis.uni-oldenburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756298Ab2HWRHD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 13:07:03 -0400
Received: by offis4.offis.uni-oldenburg.de (Postfix, from userid 1003)
	id AC187741D55; Thu, 23 Aug 2012 18:58:05 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	offis4.offis.uni-oldenburg.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.3.2
X-Spam-DCC: : offis4 1282; Body=3 Fuz1=3 Fuz2=3
X-Spam-score: -1.7 ()
X-Spam-hits: -1.7
Received: from localhost (ritchie.offis.uni-oldenburg.de [134.106.53.254])
	by offis4.offis.uni-oldenburg.de (Postfix) with ESMTP id BDA2E741CF2;
	Thu, 23 Aug 2012 18:58:03 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204154>

All,

the following patch series proposes enhancements to the credential helper
implementations in the contrib section.  The detailed development history
can be found at GitHub [1].

  The first patch adds a GnomeKeyring credential backend.  The GnomeKeyring
specific parts are based on the work by John Szakmeister, who wrote the
helper originally for the initial, unpublished version of the credential
helper protocol.

  The second patch adds a generic implementation of a credential helper
based on a simplified credential API and common helper functions.  Helpers
based on this implementation do not need to worry about the credential
protocol and only need to implement callback functions for the different
credential operations.

  The third and fourth patches port the existing helpers to this generic
implementation.

Looking forward to your thoughts.

Greetings from Oldenburg,
  Philipp

[1] https://github.com/pah/git-credential-helper
