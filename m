From: Alban Crequy <alban.crequy@collabora.co.uk>
Subject: Bug: receive.denyCurrentBranch fails if core.bare unset
Date: Fri, 12 Jun 2009 18:53:18 +0300
Message-ID: <20090612185318.42e738c6@alban.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Alban Crequy <alban.crequy@collabora.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 18:04:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF9F0-0005vz-Di
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 18:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756668AbZFLQEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 12:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755882AbZFLQEQ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 12:04:16 -0400
Received: from bhuna.collabora.co.uk ([93.93.131.97]:60971 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755585AbZFLQEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 12:04:16 -0400
X-Greylist: delayed 655 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2009 12:04:15 EDT
Received: from alban.research.nokia.com (korma.collabora.co.uk [93.93.131.100])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4C5A735A7;
	Fri, 12 Jun 2009 16:53:22 +0100 (BST)
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.14.7; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121433>

Hi,

When I set "receive.denyCurrentBranch" to "refuse", it still have the
behavior of ignore. On newly created repository, core.bare is always
set, but I had a old non-bare repository where it is unset. With
core.bare unset, rev-parse --is-bare-repository returns true in .git,
but false in the worktree.

What should be the right fix for this problem? Adding in the
documentation of receive.denyCurrentBranch that setting
core.bare explicitely is highly recommended ?

Br,
Alban
