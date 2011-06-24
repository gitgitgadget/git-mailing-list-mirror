From: John Powell <jpowell@vmware.com>
Subject: submodule/index/working tree woes
Date: Fri, 24 Jun 2011 11:25:46 -0700
Message-ID: <20110624182546.GB30640@vmware.com>
Reply-To: masterblaster@vmware.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 20:26:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QaB4q-0002YT-PN
	for gcvg-git-2@lo.gmane.org; Fri, 24 Jun 2011 20:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580Ab1FXSZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jun 2011 14:25:47 -0400
Received: from smtp-outbound-2.vmware.com ([65.115.85.73]:30373 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752304Ab1FXSZq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2011 14:25:46 -0400
Received: from mailhost3.vmware.com (mailhost3.vmware.com [10.16.27.45])
	by smtp-outbound-2.vmware.com (Postfix) with ESMTP id 9E81637009
	for <git@vger.kernel.org>; Fri, 24 Jun 2011 11:25:46 -0700 (PDT)
Received: from localhost (jpowell-lx2.eng.vmware.com [10.20.102.36])
	by mailhost3.vmware.com (Postfix) with ESMTP id 8BAE0CD954
	for <git@vger.kernel.org>; Fri, 24 Jun 2011 11:25:46 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176312>

I have no changes to be committed (tracked or untracked according to
'git status') and yet when I try and switch branches git complains
that I have untracked working tree files that would be overridden
and aborts before the switch. 

The change I have just committed locally removes some files from the
repository and adds a submodule in it's place to better organize the
source for the project. 

Shaka, when the walls fell.  Anyone want to assist me with this issue?
Feeling clueless.
