From: Mike Doherty <doherty@cs.dal.ca>
Subject: git rebase -i doesn't respect rebase.autosquash
Date: Thu, 30 Dec 2010 18:48:08 -0500
Message-ID: <4D1D1A38.9090305@cs.dal.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 31 01:10:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYSa1-0002mS-FF
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 01:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429Ab0LaAKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 19:10:42 -0500
Received: from hammer.CS.Dal.Ca ([129.173.22.32]:57521 "EHLO hammer.cs.dal.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136Ab0LaAKl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 19:10:41 -0500
X-Greylist: delayed 1356 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Dec 2010 19:10:40 EST
Received: from [10.0.1.5] (node-7061.tor.pppoe.execulink.com [67.158.75.150])
	by hammer.cs.dal.ca (Postfix) with ESMTP id 073F24F2B6
	for <git@vger.kernel.org>; Thu, 30 Dec 2010 19:47:58 -0400 (AST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.0
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164374>

Hello,

In a git repo, I have rebase.autosquash enabled by default (in
~/.gitconfig), but whenever I do `git rebase -i`, that setting isn't
respected. Is this a known bug, or am I misunderstanding what that
setting is meant to do?

Thanks for your help,
-Mike Doherty
