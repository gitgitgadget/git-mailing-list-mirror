From: Thomas Koch <thomas@koch.ro>
Subject: [Request] Git export with hardlinks
Date: Wed, 6 Feb 2013 16:19:07 +0100
Message-ID: <201302061619.07765.thomas@koch.ro>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 17:01:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U37Qq-00072N-TL
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 17:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757289Ab3BFQAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 11:00:46 -0500
Received: from koch.ro ([88.198.2.104]:53617 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755083Ab3BFQAp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 11:00:45 -0500
X-Greylist: delayed 2494 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Feb 2013 11:00:44 EST
Received: from 123-16.2-85.cust.bluewin.ch ([85.2.16.123] helo=x121e.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <thomas@koch.ro>)
	id 1U36mD-0006GC-RH
	for git@vger.kernel.org; Wed, 06 Feb 2013 16:19:09 +0100
User-Agent: KMail/1.13.7 (Linux/3.7-trunk-amd64; KDE/4.8.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215595>

Hi,

I'd like to script a git export command that can be given a list of already 
exported worktrees and the tree SHA1s these worktrees correspond too. The git 
export command should then for every file it wants to export lookup in the 
existing worktrees whether an identical file is already present and in that 
case hardlink to the new export location instead of writing the same file 
again.

Use Case: A git based web deployment system that exports git trees to be 
served by a web server. Every new deployment is written to a new folder. After 
the export the web server should start serving new requests from the new 
folder.

It might be possible that this is premature optimization. But I'd like to 
learn more Python and dulwich by hacking this.

Do you have any additional thoughts or use cases about this?

Regards,

Thomas Koch, http://www.koch.ro
