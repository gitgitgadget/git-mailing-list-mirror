From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: git-gui and untracked files
Date: Tue, 26 Jun 2007 10:51:05 +0200
Organization: eudaptics software gmbh
Message-ID: <4680D379.F891FED0@eudaptics.com>
References: <8b65902a0706260102i25f79375r5e5b419107f6e587@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 10:51:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I36m9-0006wu-Em
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 10:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbXFZIvA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 04:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbXFZIvA
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 04:51:00 -0400
Received: from main.gmane.org ([80.91.229.2]:34536 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683AbXFZIu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 04:50:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I36lC-0008Mr-VJ
	for git@vger.kernel.org; Tue, 26 Jun 2007 10:50:55 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Jun 2007 10:50:54 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Jun 2007 10:50:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50955>

Guilhem Bonnefille wrote:
> Is it possible to hide untracked files in git-gui? (for example an
> option available with a right click on the "Changed but not updated"
> frame)

Sure. Add the files to .gitignore (which you itself put under version
control) or to .git/info/exclude.

man 5 gitignore

-- Hannes
