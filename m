From: Sergey Organov <sorganov@gmail.com>
Subject: 'git pull' inconsistent messages.
Date: Tue, 12 Aug 2014 00:02:22 +0400
Message-ID: <87fvh223sh.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 22:02:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGvna-0001J5-Ed
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 22:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbaHKUCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 16:02:25 -0400
Received: from mail.javad.com ([54.86.164.124]:39505 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825AbaHKUCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 16:02:25 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id C8C3161814
	for <git@vger.kernel.org>; Mon, 11 Aug 2014 20:02:23 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1XGvnS-0000CU-7k
	for git@vger.kernel.org; Tue, 12 Aug 2014 00:02:22 +0400
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255136>

Hello,

$ git pull --rebase=false
Already up-to-date.
$ git pull --rebase=true
Current branch v3.5 is up to date.
$ git pull --rebase=preserve
Successfully rebased and updated refs/heads/v3.5.

The last one being particularly misleading as nothing was actually
changed.

git version 1.9.3

-- Sergey.
