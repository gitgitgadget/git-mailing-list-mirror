From: Greg Brockman <gdb@MIT.EDU>
Subject: [PATCHv3] Updated patch series for providing mechanism to list available repositories
Date: Wed, 21 Jul 2010 11:15:52 -0400
Message-ID: <1279725355-23016-1-git-send-email-gdb@mit.edu>
To: j.sixt@viscovery.net, gitster@pobox.com, avarab@gmail.com,
	jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 21 17:16:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obb1t-00055e-2F
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 17:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650Ab0GUPQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 11:16:14 -0400
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:49325 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752113Ab0GUPQM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 11:16:12 -0400
X-AuditID: 1209190c-b7c0dae000000a0c-45-4c470f3d0425
Received: from mailhub-auth-4.mit.edu (MAILHUB-AUTH-4.MIT.EDU [18.7.62.39])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Brightmail Gateway) with SMTP id 32.C6.02572.D3F074C4; Wed, 21 Jul 2010 11:16:13 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id o6LFGBpT005470;
	Wed, 21 Jul 2010 11:16:11 -0400
Received: from localhost (dhcp-18-111-45-125.dyn.mit.edu [18.111.45.125])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6LFGAJc005806;
	Wed, 21 Jul 2010 11:16:10 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151398>

In this version, I fixed up the problems that Junio noted in my first
patch.  Per Junio's comments on my second patch (git-shell-commands:
Add a command to list bare repos), I added a README file in
contrib/git-shell-commands.  I also squashed the commits creating
files in that directory.

I'll note that I realized (and documented in the README) that since
commands are actually run out of $(cwd)/git-shell-commands, this might
not do what the user expects if run outside of his or her home
directory.  I'm not sure if this is bad behavior; do people have
thoughts?

Once again, thanks Junio for you comments.
