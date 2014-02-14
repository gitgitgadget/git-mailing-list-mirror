From: Mick Killianey <mkillianey@guidewire.com>
Subject: git stash and --skip-worktree files
Date: Fri, 14 Feb 2014 01:59:07 +0000
Message-ID: <8D4386EEB9152247A45EC47A89E64C554D2ED6F3@sm-ex-01-vm.guidewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 14 03:09:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE8Dd-0001kA-OG
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 03:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbaBNCJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 21:09:29 -0500
Received: from mx-1.guidewire.com ([199.91.42.135]:46677 "EHLO
	mx-1.guidewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbaBNCJ2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Feb 2014 21:09:28 -0500
X-Greylist: delayed 615 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2014 21:09:28 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ap8EACV4/VLAqAdq/2dsb2JhbABZhBW/V4EvdIInBTpRARUVFEImAQQb0FQXjkiDXIEUBJ8bjmGCKg
X-IronPort-AV: E=Sophos;i="4.95,842,1384329600"; 
   d="scan'208";a="8980433"
Thread-Topic: git stash and --skip-worktree files
Thread-Index: Ac8pKFg3bxbjuDZKS4uGmJfwGSzs6w==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242089>

My team is starting to use the --skip-worktree flag on files to allow them to keep modified files in their working directories.  Ideally, they'd like an option for "git-stash" to apply to skip-worktree files, just as it can (optionally) be applied to untracked files, so that skip-worktree files could be included when saving and restored (ideally, with the skip-worktree bit set) on a git-stash pop.

(1)  I don't see an option for "git-stash" to support skip-worktree files...is it there and I'm just not seeing it?
(2)  Does anyone know if there's a reason why this is not possible/unreasonable to support/philosophically discouraged?
(3)  If it is reasonable, where would the right place be to suggest/request this feature?

I'm happy to look at making such changes to git-stash.sh, but before I do so, I'd love to know that such work would be aligned with the design philosophy of git-stash.  (For example, if the git team would only want such an option if it also included the ability to stash assume-unchanged files, too, that would be useful to know before I start making changes.)

Mick
