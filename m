From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: BUG: git --bare log HEAD
Date: Fri, 19 Jan 2007 13:02:24 +0100
Message-ID: <eoqc09$454$2@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 19 13:05:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7sUq-0001Fu-Cc
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 13:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbXASMFP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 07:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbXASMFP
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 07:05:15 -0500
Received: from main.gmane.org ([80.91.229.2]:60733 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965083AbXASMFM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 07:05:12 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1H7sUQ-0006J4-Hz
	for git@vger.kernel.org; Fri, 19 Jan 2007 13:05:02 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 13:05:02 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 13:05:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37173>


of course, when --bare is used, then HEAD is not ambiguous.


[lilydev@haring .git]$ git --bare log HEAD
fatal: ambiguous argument 'HEAD': both revision and filename
Use '--' to separate filenames from revisions

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
