From: DigitalPig <digitalpiglee@gmail.com>
Subject: What is the difference between git-gc, git-repack and git-prune?
Date: Tue, 06 May 2008 22:44:11 -0400
Organization: Clemson Univ.
Message-ID: <873aoux284.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 04:51:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtZkY-0006rK-S4
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 04:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755058AbYEGCuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 22:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754849AbYEGCuI
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 22:50:08 -0400
Received: from main.gmane.org ([80.91.229.2]:53703 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753981AbYEGCuG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 22:50:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JtZjG-0000AG-Rg
	for git@vger.kernel.org; Wed, 07 May 2008 02:50:02 +0000
Received: from host-69-59-106-234.nctv.com ([69.59.106.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 May 2008 02:50:02 +0000
Received: from digitalpiglee by host-69-59-106-234.nctv.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 May 2008 02:50:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: host-69-59-106-234.nctv.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:KYDI6vIHSXg5eRogKRsHw7KimVU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81400>

Hi!

For git-prune, according to the manual, it will delete all the dangling
objects. So it is easy to understand. However, in the git-gc manpage,
there is another option named "--prune". Does that make git-gc do the
same thing as git-prune?

And manpage of git-gc says it cleans unnecessary files and compresses
the objects, and git-repack also compresses the objects too. Are there
any difference between these two operations? Or do I need to invoke
git-repack after running git-gc? Thanks!


Zhenqing

-- 
DigitalPig
E-mail: digitalpiglee AT gmail DOT com
ALL WE SEEN IS ILLUSION.

*Fudan University Macromoleculer Science Forum*
http://fudanmacro.com
