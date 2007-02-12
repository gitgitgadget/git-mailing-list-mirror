From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [PATCH] Use patch file's modtime as the git author and commiter date
Date: Mon, 12 Feb 2007 01:57:20 -0500
Message-ID: <20070212065720.GB31806@filer.fsl.cs.sunysb.edu>
References: <11712362751442-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 12 07:57:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGV7z-0003dO-FH
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 07:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933051AbXBLG52 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 01:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933052AbXBLG52
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 01:57:28 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:59610 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933051AbXBLG52 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 01:57:28 -0500
Received: from filer.fsl.cs.sunysb.edu (IDENT:LU6dO1AYbzg4sHA3LHJyqskqSLZpAH7W@localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l1C6vNfQ032703;
	Mon, 12 Feb 2007 01:57:23 -0500
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l1C6vKIu032700;
	Mon, 12 Feb 2007 01:57:20 -0500
Content-Disposition: inline
In-Reply-To: <11712362751442-git-send-email-tytso@mit.edu>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39381>

On Sun, Feb 11, 2007 at 06:24:35PM -0500, Theodore Ts'o wrote:
> By using the same author and committer date, it keeps the git commit
> id's stable if the patches haven't changed.  Otherwise, repeated
> invocations of "guilt pop -a; guilt push -a" will create new commit's
> with different commit dates, creating a lot of garbage commits that
> won't disappear for a LONG time, even after running "git-gc --prune",
> thanks to the reflog in git 1.5.

Applied. Thanks.

Josef "Jeff" Sipek.

-- 
Real Programmers consider "what you see is what you get" to be just as bad a
concept in Text Editors as it is in women. No, the Real Programmer wants a
"you asked for it, you got it" text editor -- complicated, cryptic,
powerful, unforgiving, dangerous.
