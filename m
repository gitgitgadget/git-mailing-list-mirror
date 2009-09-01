From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] fixed error in whitespace handling of
	RefDatabase#readLine
Date: Tue, 1 Sep 2009 16:15:24 -0700
Message-ID: <20090901231524.GA1033@spearce.org>
References: <196796.47610.qm@web27808.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: robin.rosenberg@dewire.com, git@vger.kernel.org
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Wed Sep 02 01:15:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MicZZ-0003YZ-FF
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 01:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755352AbZIAXPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 19:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755346AbZIAXPX
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 19:15:23 -0400
Received: from george.spearce.org ([209.20.77.23]:34805 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755342AbZIAXPW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 19:15:22 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id F17F038200; Tue,  1 Sep 2009 23:15:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <196796.47610.qm@web27808.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127563>

Mark Struberg <struberg@yahoo.de> wrote:
> jgit fails with "cannot checkout; no HEAD advertised by remote"
> in guessHEAD on some repositories.
...
> @@ -500,8 +500,12 @@ private static String readLine(final File file)
>          int n = buf.length;
>          if (n == 0)

Whitespace damage here, the patch won't apply as-is.

Also, please line wrap your commit message.

-- 
Shawn.
