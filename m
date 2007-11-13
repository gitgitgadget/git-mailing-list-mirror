From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] user-manual: Talk about tracking third-party snapshots
Date: Tue, 13 Nov 2007 18:30:14 +0300
Message-ID: <87zlxi88op.fsf@osv.gnss.ru>
References: <11949569992214-git-send-email-msmith@cbnco.com>
	<fhcb29$ef$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 16:31:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irxj7-0007kx-Pq
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 16:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603AbXKMPaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 10:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755902AbXKMPaZ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 10:30:25 -0500
Received: from javad.com ([216.122.176.236]:3252 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753974AbXKMPaY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 10:30:24 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lADFUK021398;
	Tue, 13 Nov 2007 15:30:20 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1IrxiQ-0003Hu-Fk; Tue, 13 Nov 2007 18:30:14 +0300
In-Reply-To: <fhcb29$ef$2@ger.gmane.org> (Jakub Narebski's message of "Tue\, 13 Nov 2007 15\:07\:05 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64808>

Jakub Narebski <jnareb@gmail.com> writes:

> Michael Smith wrote:
>
>> +You can use the gitlink:git-cherry[1] command to display the commit
>> +IDs that are only present on your local branch, or only on the remote
>> +branch, respectively:
>
> I think git-cherry is deprecated in favor of "git log --left-right" (with
> appropriate format, for example '--abbrev-commit --pretty=oneline')
>
> BTW. that means that git-cherry can be removed from git-help output,
> I think.

And from core-tutorial.txt:1567:

4. Use `git cherry origin` to see which ones of your patches
   were accepted, and/or use `git rebase origin` to port your
   unmerged changes forward to the updated upstream.

???

-- 
Sergei.
