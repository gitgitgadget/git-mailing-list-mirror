From: Bruno Haible <bruno@clisp.org>
Subject: how to speed up "git log"?
Date: Sun, 11 Feb 2007 12:52:28 +0100
Message-ID: <200702111252.28393.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 11 12:53:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGDGS-0004zP-W0
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 12:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbXBKLwz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 06:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbXBKLwy
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 06:52:54 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:39533 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbXBKLwy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 06:52:54 -0500
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Feb 2007 06:52:53 EST
Received: from linuix.haible.de (cable-137-244.iesy.net [81.210.137.244])
	by post.webmailer.de (klopstock mo9) (RZmta 4.5) with ESMTP id T0104dj1B6pM0d
	; Sun, 11 Feb 2007 12:46:33 +0100 (MET)
User-Agent: KMail/1.5.4
Content-Disposition: inline
X-RZG-AUTH: gMysVb8JT2gB+rFDu0PuvnPihAP8oFdePhw95HsN8T+WAEY4JDyuz6KRYg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39279>

Hi,

Are there some known tricks to speed up the operation of "git log"?

On a file in a local copy of the coreutils git repository,
"git log tr.c > output" takes
  - 33 seconds of CPU time (33 user, 0 system) on a Linux/x86 500MHz system,
  - 24 seconds of CPU time (12 user, 12 system) on a MacOS X PowerPC 1.1 GHz
    system.
The result shows only 147 commits and a total of 40 KB textual output.

1) Why so much user CPU time?
2) Why so much system CPU time, but only on MacOS X?

Bruno
