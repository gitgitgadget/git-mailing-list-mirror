From: Lawrence Mitchell <wence@gmx.li>
Subject: Re: Rewriting references to existing commits in commit messages with filter-branch
Date: Mon, 11 Mar 2013 12:06:29 +0000
Message-ID: <87haki2la2.fsf@gmx.li>
References: <E1UF1Ag-0006m3-5k@smtp.tt-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 11 13:07:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF1VS-0000Ye-Q9
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 13:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920Ab3CKMGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 08:06:40 -0400
Received: from plane.gmane.org ([80.91.229.3]:44852 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751Ab3CKMGk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 08:06:40 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UF1VM-0000Uw-SP
	for git@vger.kernel.org; Mon, 11 Mar 2013 13:07:00 +0100
Received: from e4300lm.epcc.ed.ac.uk ([129.215.63.156])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 13:07:00 +0100
Received: from wence by e4300lm.epcc.ed.ac.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 13:07:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: e4300lm.epcc.ed.ac.uk
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:2Kb3LneB20F/7D7trUgZWNuFSUY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217870>

Vadim Zeitlin wrote:

[...]


> git filter-branch --msg-filter svnmsg2git --tag-name-filter cat -- --all

git rev-list lists by default in chronological order.  Do you
want to pass --topo-order as one of the rev-list options?
[...]

Lawrence
-- 
Lawrence Mitchell <wence@gmx.li>
