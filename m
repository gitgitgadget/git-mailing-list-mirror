From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/6] Extensions of core.ignorecase=true support
Date: Sun, 3 Oct 2010 20:12:01 +0200
Message-ID: <201010032012.01678.j6t@kdbg.org>
References: <20101003043221.1960.73178.stgit@SlamDunk> <AANLkTinZzM=HeT_J-tF5F9DBdvts3i+nboPkPy-uc8V5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 20:12:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2T2g-0006al-Un
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 20:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429Ab0JCSMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 14:12:06 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:26741 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754322Ab0JCSMD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 14:12:03 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0A196A7EB5;
	Sun,  3 Oct 2010 20:12:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id B99E219F609;
	Sun,  3 Oct 2010 20:12:01 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTinZzM=HeT_J-tF5F9DBdvts3i+nboPkPy-uc8V5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157889>

On Sonntag, 3. Oktober 2010, Robert Buck wrote:
> So I could we please separate the behaviors that change intent
> (folding) from the behaviors that merely alter how things are
> displayed (listing) by splitting this into two separate properties?
> For example,
>
> core.casepreserving=true|false
> core.caseinsensitive=true|false
>
> The former property would control folding, the latter property would
> apply to listing and pattern matching. Then people could opt out of
> the folding behaviors (add, import), while continuing to adopt listing
> and pattern matching (status, ls, ignore).

core.ignorecase has a very well-defined meaning: It describes whether the 
worktree lives on a filesystem that is case-insensitive. Perhaps you could 
help me understand your case if you gave examples and a use-case? I have a 
slight suspicion that your wish is orthogonal to core.ignorecase.

-- Hannes
