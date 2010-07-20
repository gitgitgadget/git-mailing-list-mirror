From: Greg Brockman <gdb@MIT.EDU>
Subject: Updated patch series for providing mechanism to list available repositories
Date: Tue, 20 Jul 2010 01:16:08 -0400
Message-ID: <1279602972-1264-1-git-send-email-gdb@mit.edu>
To: j.sixt@viscovery.net, git@vger.kernel.org, gitster@pobox.com,
	avarab@gmail.com, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Jul 20 07:17:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ob5CY-0001ZB-Dq
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 07:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842Ab0GTFQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 01:16:38 -0400
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:50250 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753811Ab0GTFQh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 01:16:37 -0400
X-AuditID: 1209190c-b7c0dae000000a0c-f0-4c453136a5ef
Received: from mailhub-auth-1.mit.edu (MAILHUB-AUTH-1.MIT.EDU [18.9.21.35])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Brightmail Gateway) with SMTP id 1D.1B.02572.631354C4; Tue, 20 Jul 2010 01:16:38 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id o6K5GQnb007372;
	Tue, 20 Jul 2010 01:16:26 -0400
Received: from localhost (STRATTON-FIVE-FIFTY-FOUR.MIT.EDU [18.187.7.43])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6K5GOil001105;
	Tue, 20 Jul 2010 01:16:25 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
X-Brightmail-Tracker: AAAAAhUrKiQVLC1f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151300>

I have updated the patch series sent to this list on July 13th.  Based
largely on feedback from this list, I have made the following changes:

- sample commands now live in contrib/git-shell-commands
- blank lines have been added to patch 1's commit message for readability
- commands are run with cwd of the user's $HOME directory
- run_command is used rather than writing a new function with the same functionality
- the shell's loop resides in its own function
- commands are now parsed with split_cmdline, so helper functions can be passed arguments

Thanks to those who provided feedback.  I look forward to further
comments!

Greg
