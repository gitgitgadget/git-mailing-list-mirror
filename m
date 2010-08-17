From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/6] Extensions of core.ignorecase=true support
Date: Tue, 17 Aug 2010 23:20:17 +0200
Message-ID: <201008172320.17939.j6t@kdbg.org>
References: <cover.1281985411.git.j6t@kdbg.org> <AANLkTi=0j_JFWBp=kJG6v+YBUxKAiVAVc4UtG0LWmipq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Joshua Jensen <jjensen@workspacewhiz.com>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 23:20:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlTa7-0000Fq-I7
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 23:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037Ab0HQVUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 17:20:22 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:15431 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912Ab0HQVUW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 17:20:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DAF3010012;
	Tue, 17 Aug 2010 23:20:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 12E0619F5C0;
	Tue, 17 Aug 2010 23:20:18 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTi=0j_JFWBp=kJG6v+YBUxKAiVAVc4UtG0LWmipq@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153780>

On Dienstag, 17. August 2010, Robert Buck wrote:
> While I tend to agree with case-insensitive searches, I would tend to
> question the use of a non-case-preserving / last-use methodology
> reminiscent of the days of DOS.

There is no "last-use" involved. Everything's rather "first-use", i.e., 
case-preserving.

> The nice thing about case-insensitivity is that when requesting a file
> by name any capitalization can be used. The bad thing, well come to
> think of it, there is none that I can think of, but for those more
> religious than I about Unix they may cite otherwise.

What do you mean by "requesting a file"?

core.ignorecase is purely about the worktree and the transition of files from 
the worktree to the index. It is *not* involved when files are moved from the 
index or the repository to the worktree. In particular, it is not used when 
you give a pathspec to limit 'git log' results. (Joshua proposed a change 
where core.ignorecase would also kick in in this case as well, but this 
change is not included in this series, and I would not agree to it.)

-- Hannes
