From: Ron Garret <ron1@flownet.com>
Subject: A git-mv question
Date: Mon, 01 Feb 2010 16:08:38 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-09EE6C.16083801022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 01:09:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc6Ki-0005mN-AE
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 01:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447Ab0BBAJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 19:09:23 -0500
Received: from lo.gmane.org ([80.91.229.12]:39448 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753422Ab0BBAJW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 19:09:22 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nc6KP-0005RA-4P
	for git@vger.kernel.org; Tue, 02 Feb 2010 01:09:13 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 01:09:13 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 01:09:13 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138661>

If I do a git-mv *and* edit the file all in one commit, does that get 
recorded in a way that allows git to track the change through the 
changed file name?  In other words, if I do just a git-mv (without 
changing the file) git can track that by observing that two differently 
named objects in two different commit trees contain the same blob.  But 
if the file is edited then the blobs will be different.  Is git smart 
enough to distinguish a git-mv and edit from, say, the equivalent git-rm 
and git-add?  If so, how does it do it?

Thanks,
rg
