From: Frank Li <lznuaa@gmail.com>
Subject: [Announce]: TortoiseGit 0.6.2.0 Release
Date: Wed, 6 May 2009 21:44:29 +0800
Message-ID: <1976ea660905060644o7ebddb0etf0f7c1adf6a3f566@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	tortoisegit-dev <tortoisegit-dev@googlegroups.com>,
	tortoisegit-users@googlegroups.com,
	tortoisegit-announce@googlegroups.com
X-From: git-owner@vger.kernel.org Wed May 06 15:44:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1hQP-0000BR-SH
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 15:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbZEFNob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 09:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753855AbZEFNoa
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 09:44:30 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:7370 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbZEFNoa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 09:44:30 -0400
Received: by rv-out-0506.google.com with SMTP id f6so2717658rvb.5
        for <git@vger.kernel.org>; Wed, 06 May 2009 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=DMchgaoUFaMhsAtIeVdiiFhwJ+4lftQ5qUXzi2Ha/oM=;
        b=YuZ9AUeu6PZR2Z97USewbdkyAppcjCIlfw/rmm3zt98dl02XZckhqJTha8YPoz+nXZ
         2WE4Df9jwoJtcN8fwBrCSj94YZONzJZAhc1OJE9TG9fOa1cWTY8exK8F4q1mLKWyFbTk
         zHCM61vcm377NrXZKWyNVEfAmhrQxX2CO9Ve4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=YzSJF4VCng8QW9Vf6dMk1p3e3xbvVvaFe0sM0ZQVGu2YCXyQw4SDLexYgmAmQ/CY1n
         4ScTSTTQt91N92zWFdJPU4LNNmoWlpyfKMZ5H4FlXP9B3Lf0mLKc3GYjltHrapmqe0of
         WRLj5kYStAFyJiN5CPa/FuGbmKGhzooC1nCSo=
Received: by 10.141.48.6 with SMTP id a6mr422782rvk.161.1241617469707; Wed, 06 
	May 2009 06:44:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118341>

Download:
http://code.google.com/p/tortoisegit/downloads/list?saved=1&ts=1241617267

Version 0.6.2.0 version(external)
        *Improve fetch overlay speed
        rebase igit.exe to msysgit 1.6.2.2, which is major application
to get git status.

Version 0.6.1.0 version(internal)
Features:
	*TortoiseMerge Support git format patch file.
	TortoiseMerge can open git patch file and review diff and merge change.

	*SendMail support
	Right click .patch or .diff file, click "send mail..." to send patch out.

	*improve clone dialog
	Add auto fill module name at directory when change URL. Fix tab order.

	
Fix:
	Issue 73:  Error while reading/writing the registry key MSysGit
Access is denied
	Issue 11:  Show differences as unified diff does not use selected item
	Issue 77:  "Show differencess" against a deleted file will cause
TortoiseMerge to error
	Issue 74:  Add multiple files from commit dialog only adds first two
in multi-selection
	Issue 75:  About box does not show version information
	Wrong error message when fail launch pageant
	Setup will launch old version msi to remove old version. Directly
update to new version without remove old version
	Double click conflict item to launch diffview, not conflict edit.
	Issue 66 in tortoisegit: Some log lines lose color or disappear after
you click on them
	Issue 81:  Cannot have x86 and x64 versions installed at the same time.
