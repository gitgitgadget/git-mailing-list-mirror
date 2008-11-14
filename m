From: Jens Seidel <jensseidel@users.sf.net>
Subject: Error in git-cherry-pick manpage?
Date: Fri, 14 Nov 2008 16:14:26 +0100
Message-ID: <20081114151426.GA20985@merkur.sol.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 14 16:17:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L10QG-0002dA-J8
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 16:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbYKNPPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 10:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbYKNPPn
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 10:15:43 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:34772 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbYKNPPm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 10:15:42 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id AE5A3F6B4583
	for <git@vger.kernel.org>; Fri, 14 Nov 2008 16:15:40 +0100 (CET)
Received: from [77.188.140.134] (helo=merkur.sol.de)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1L10Oa-0001HM-00
	for git@vger.kernel.org; Fri, 14 Nov 2008 16:15:40 +0100
Received: from jens by merkur.sol.de with local (Exim 4.69)
	(envelope-from <tux-master@web.de>)
	id 1L10NO-0005So-Sc
	for git@vger.kernel.org; Fri, 14 Nov 2008 16:14:26 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Sender: tux-master@web.de
X-Provags-ID: V01U2FsdGVkX1+JCzn6ILZbSrRh0gAta0DEy+aqUSEesduliPEr
	cXFgaGwnAqMETv5Dimyn2ZoPz7AxF1WdwLrNmOwoTNxQm4KJni
	jA6I0rTgE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100982>

Hi,

I try to use git cherry-pick to combine multiple commits but I'm confused
about the second sentence of the description:

"Given one existing commit, apply the change the patch introduces, and
record a new commit that records it. This requires your working tree to be
clean (no modifications from the HEAD commit)."

I intent to use it as follows:

 git cherry-pick -x --no-commit 2e855ae
 git cherry-pick -x --no-commit 0c1151
 ...

After the first invocation my working tree will not be clean but contain
changes in the index.

Does this mean that's a wrong usage of cherry-pick?

Jens
