From: Tobias Richter <tsr-git@achos.com>
Subject: remove broken refloc
Date: Thu, 22 Oct 2009 17:57:15 +0100
Message-ID: <20091022165715.GE30266@cave.achos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 19:26:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N11QH-00059h-3W
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 19:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161AbZJVRZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 13:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755971AbZJVRZu
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 13:25:50 -0400
Received: from mail.achos.com ([88.198.178.178]:38252 "EHLO mail.achos.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755638AbZJVRZt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 13:25:49 -0400
X-Greylist: delayed 1676 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Oct 2009 13:25:49 EDT
Received: from cave.achos.com (cave.achos.com [212.159.124.96])
	by mail.achos.com (Postfix) with ESMTP id D825E111872F
	for <git@vger.kernel.org>; Thu, 22 Oct 2009 18:57:57 +0200 (CEST)
Received: by cave.achos.com (Postfix, from userid 1111)
	id 1DF358032D; Thu, 22 Oct 2009 17:57:15 +0100 (BST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131034>

Hi,

>From using git-svn I've imported a (git-wise) broken reference. This isn't 
a huge problem, as I don't need that ref anyway. But 'git gc' no longer
works and that results in frequent errors when updating:

$ git gc
error: cannot lock ref 'refs/remotes/release_7.5.'
error: failed to run reflog

As far as I understand I could expire that ref, but that fails as well:

$ git reflog expire --expire=0 --all
error: cannot lock ref 'refs/remotes/release_7.5.'

Is there a way to forcefully remove that broken ref?

Then I may be able to stop git-svn from re-importing that using the config,
I hope.

Thanks,

Tobias
