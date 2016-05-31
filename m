From: Johannes Sixt <j6t@kdbg.org>
Subject: git gc and worktrees
Date: Tue, 31 May 2016 09:07:22 +0200
Message-ID: <574D382A.8030809@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 09:07:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7dly-0002fD-Fv
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 09:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248AbcEaHH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 03:07:26 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:54131 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbcEaHHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 03:07:25 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rJl170v1nz5tlH
	for <git@vger.kernel.org>; Tue, 31 May 2016 09:07:22 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 3914252A4
	for <git@vger.kernel.org>; Tue, 31 May 2016 09:07:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295961>

Earlier this year I had a largish merge going on in a separate worktree. 
With a mix of staged resolutions and unmerged paths in the index, I ran 
'git gc' in the main worktree. This removed a lot of objects that were 
recorded in that separate worktree index. (I was able to recover them 
because the content was still on disk.)

Now I wanted to derive a test case that shows that breakage, but I am 
unable to. The objects recorded in a separate worktree index, but not 
committed, yet, are not pruned anymore.

Have there been any fixes in this regard recently? Or does this look 
like something else going on?

-- Hannes
