From: david@lang.hm
Subject: how to make a commit only contain existing files
Date: Tue, 7 Dec 2010 13:00:18 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1012071203190.662@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 22:09:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ4nE-0008BN-Q8
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 22:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251Ab0LGVJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 16:09:44 -0500
Received: from mail.lang.hm ([64.81.33.126]:36992 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368Ab0LGVJo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 16:09:44 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Dec 2010 16:09:44 EST
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id oB7L0I8h015740
	for <git@vger.kernel.org>; Tue, 7 Dec 2010 13:00:18 -0800
X-X-Sender: dlang@asgard.lang.hm
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163135>

I know that I can do a git rm to explictly remove files, but is there an 
easy way to just say that this commit should contain all the files that 
exist at this point in time, without carrying over any files that were in 
a prior commit but that don't exist now?

David Lang
