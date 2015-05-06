From: Yue Lin Ho <yuelinho777@gmail.com>
Subject: Typo: Remote branch V.S. Remote-tracking branch
Date: Wed, 6 May 2015 01:21:55 -0700 (MST)
Message-ID: <1430900515653-7630076.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 10:22:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypuaf-0002kV-PQ
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 10:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbbEFIV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 04:21:58 -0400
Received: from mwork.nabble.com ([162.253.133.43]:52128 "EHLO mwork.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbbEFIV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 04:21:56 -0400
Received: from mjim.nabble.com (unknown [162.253.133.84])
	by mwork.nabble.com (Postfix) with ESMTP id 0EC561D4C909
	for <git@vger.kernel.org>; Wed,  6 May 2015 01:22:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268462>

Hi:

"git branch -r -D -- origin/master" shows
  "Deleted remote branch origin/master (was xxxxxxx)."

Suppose the message should be
  "Deleted remote-tracking branch origin/master (was xxxxxxx)."

See delete_branches() in builtin/branch.c

Yue Lin Ho



--
View this message in context: http://git.661346.n2.nabble.com/Typo-Remote-branch-V-S-Remote-tracking-branch-tp7630076.html
Sent from the git mailing list archive at Nabble.com.
