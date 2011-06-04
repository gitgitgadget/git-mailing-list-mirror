From: "Neal Kreitzinger" <neal@rsss.com>
Subject: pre-commit to reject EOL changes
Date: Fri, 3 Jun 2011 19:27:15 -0500
Message-ID: <isbu54$dn3$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 02:27:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSeiF-0000pG-T0
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 02:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756826Ab1FDA1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 20:27:31 -0400
Received: from lo.gmane.org ([80.91.229.12]:40786 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756815Ab1FDA1a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 20:27:30 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QSei9-0000nP-IM
	for git@vger.kernel.org; Sat, 04 Jun 2011 02:27:29 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Jun 2011 02:27:29 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Jun 2011 02:27:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6090
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175053>

I see that the pre-commit.sample reject introduction of lines with trailing 
whitespaces.  Is there a way to have it reject changes in EOL format (CRLF 
vs LF)?

v/r,
neal 
