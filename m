From: David Kastrup <dak@gnu.org>
Subject: A question about git-rev-list
Date: Mon, 16 Jul 2007 10:55:35 +0200
Message-ID: <86wsx0wwvs.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 10:56:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAMN5-0004nV-E6
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 10:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318AbXGPIzy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 04:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755046AbXGPIzy
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 04:55:54 -0400
Received: from main.gmane.org ([80.91.229.2]:51031 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754744AbXGPIzx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 04:55:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IAMMs-0007ZE-Io
	for git@vger.kernel.org; Mon, 16 Jul 2007 10:55:46 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 10:55:46 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 10:55:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:2ls9JKZbCKOb5ujVg0lXDUIy5B0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52651>


Hi,

if I do

git-rev-list --remove-empty HEAD --not some-commit -- filename | tail -1

do I have any guarantee that the commit id I get (if any) is a direct
descendant of some-commit?  I _think_ --remove-empty might be
necessary for that option, but have no idea whether this hunch is
correct.  Do I need additional options like --topo-order, or is that
unnecessary?

Thanks,

-- 
David Kastrup
