From: Hnerik =?utf-8?b?R3J1YmJzdHLDtm0=?= <grubba@grubba.org>
Subject: Re: [PATCH v2] autocrlf: Make it work also for =?utf-8?b?dW4tbm9ybWFsaXplZAlyZXBvc2l0b3JpZXM=?=
Date: Wed, 12 May 2010 09:26:06 +0000 (UTC)
Message-ID: <loom.20100512T112040-607@post.gmane.org>
References: <20100511223757.GB16974@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 12 12:55:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC9ax-0000tu-6B
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 12:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522Ab0ELKzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 06:55:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:44801 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755459Ab0ELKzD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 06:55:03 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OC9ag-0000kt-M7
	for git@vger.kernel.org; Wed, 12 May 2010 12:55:02 +0200
Received: from shipon.roxen.com ([212.247.28.156])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 May 2010 12:55:02 +0200
Received: from grubba by shipon.roxen.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 May 2010 12:55:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.247.28.156 (Mozilla/5.0 (X11; U; SunOS i86pc; en-US; rv:1.9.2) Gecko/20100117 Firefox/3.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146939>

Finn Arne Gangstad <finnag <at> pvv.org> writes:

> Previously, autocrlf would only work well for normalized
> repositories. Any text files that contained CRLF in the repository
> would cause problems, and would be modified when handled with
> core.autocrlf set.
> 
> The following sequence should now always be a NOP even with autocrlf
> set (assuming a clean working directory):
> 
> git checkout <something>
> touch *
> git add -A .    (will add nothing)
> git commit      (nothing to commit)

Please note that the above problem is solved for the general case with the
"[PATCH v3 0/5] Patches to avoid reporting conversion changes." patch set.

--
/grubba
